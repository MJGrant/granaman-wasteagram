import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:path/path.dart' as Path;

class NewPost extends StatelessWidget {
  static const routeName = 'newPost';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Post')),
      body: SingleChildScrollView(
        child: AddEntryForm(),
      ),
    );
  }
}

class PostEntryFields {
  String photoURL;
  String quantity;
}

class AddEntryForm extends StatefulWidget {

  @override
  _AddEntryFormState createState() => _AddEntryFormState();
}

class _AddEntryFormState extends State<AddEntryForm> {

  File _image;
  var image;

  final formKey = GlobalKey<FormState>();
  final postEntryFields = PostEntryFields();

  Future getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);

    // updates the preview
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imagePreview(),
            _quantityFormField(),
            SizedBox(height: 40),
            _submitButton(),
          ]
        )
      )
    );
  }

  Widget _imagePreview() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _image == null
            ? Text('No image selected.')
            : Image.file(_image),
        ChoosePhoto(getImage),
      ]
    );
  }

  Widget _quantityFormField() {
    return TextFormField(
      autofocus: true,
      decoration:
      InputDecoration(labelText: 'Number of items'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      validator: (value) => validateQuantity(value),
      onSaved: (value) {
        postEntryFields.quantity = value;
      }
    );
  }


  Widget _submitButton() {
    return SizedBox(
      width: 300,
      height: 160,
      child: RaisedButton(
          color: Colors.grey[300],
          onPressed: () => validateAndSave(context),
          child: Icon(Icons.cloud_upload)),
    );
  }


  String validateQuantity(String value) {
    if (value.isEmpty) {
      return 'Please enter a quantity';
    } else
      return null;
  }

  void validateAndSave(BuildContext context) async {
    final formState = formKey.currentState;

    if (formState.validate()) {
      formKey.currentState.save();

      LocationData locationData;

      var locationService = Location();
      locationData = await locationService.getLocation();

      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Creating post...')));

      // todo: add timestamp to name
      StorageReference storageReference = FirebaseStorage.instance.ref().child(Path.basename(image.path));

      // actually upload the image
      // do this only when form is valid, and hold the completion until the url is returned
      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      postEntryFields.photoURL = await storageReference.getDownloadURL();

      await Firestore.instance.collection('posts').add({
        'date': DateTime.now().toString(),
        'imageURL': postEntryFields.photoURL,
        'latitude': locationData.latitude.toString(),
        'longitude': locationData.longitude.toString(),
        'quantity': int.parse(postEntryFields.quantity),
      });

      Navigator.popUntil(context, ModalRoute.withName('/'));
    }
  }
}

class ChoosePhoto extends StatelessWidget {

  final getImage;
  ChoosePhoto(this.getImage);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RaisedButton(
            child: Text('Choose Photo'),
            onPressed: getImage
        )
    );
  }
}




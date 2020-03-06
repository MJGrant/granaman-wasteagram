import 'package:flutter/material.dart';
import 'new_post.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class Photo extends StatefulWidget {
  static const routeName = 'Photo';

  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });

    // todo: add timestamp to name
    StorageReference storageReference = FirebaseStorage.instance.ref().child(Path.basename(image.path));
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    final url = await storageReference.getDownloadURL();
    print(url);
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPost(url)),
            );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _image == null
              ? Text('No image selected.')
              : Image.file(_image),
              ChoosePhoto(getImage),
            ]
          ),
        ),
      )
    );
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

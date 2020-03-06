import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class NewPost extends StatelessWidget {
  static const routeName = 'newPost';

  final String url;

  NewPost(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Post')),
      body: SingleChildScrollView(
        child: AddEntryForm(url),
      ),
    );
  }
}

class PostEntryFields {
  String quantity;
}

class AddEntryForm extends StatefulWidget {
  final String url;

  AddEntryForm(this.url);

  @override
  _AddEntryFormState createState() => _AddEntryFormState(url);
}

class _AddEntryFormState extends State<AddEntryForm> {
  final formKey = GlobalKey<FormState>();

  final postEntryFields = PostEntryFields();

  final String url;
  _AddEntryFormState(this.url);

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
    return Container(
        width: 300,
        height: 300,
        color: Colors.blue,
        child: Text('Photo')
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

      Firestore.instance.collection('posts').add({
        'date': DateTime.now().toString(),
        'imageURL': this.url,
        'latitude': 12345,
        'longitude': 98765,
        'quantity': int.parse(postEntryFields.quantity),
      });

      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Posting...')));

      Navigator.popUntil(context, ModalRoute.withName('/'));
    }
  }
}




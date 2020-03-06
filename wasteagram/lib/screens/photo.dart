import 'package:flutter/material.dart';
import 'new_post.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

/*
class Photo extends StatelessWidget {
  static const routeName = 'Photo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Photo')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ChoosePhoto(),
            TakePhoto(),
          ],
        ),
      ),
    );
  }
}

class ChoosePhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
          child: Text('Choose Photo'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPost()),
            );
          }
      ),
    );
  }
}

class TakePhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
          child: Text('Take Photo'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPost()),
            );
          }
      ),
    );
  }
}

 */
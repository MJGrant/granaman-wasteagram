import 'package:flutter/material.dart';
import 'new_post.dart';

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
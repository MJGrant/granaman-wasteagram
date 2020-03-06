import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:math';

class NewPost extends StatelessWidget {

  static const routeName = 'newPost';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
        Text('New Post')
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Photo'),
            Text('Number of items'),
            TextField(
              decoration: InputDecoration(labelText: 'Number of items'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly]
            ),
            RaisedButton(
              onPressed: () {
                final _random = Random();
                Firestore.instance.collection('posts').add({
                  'date': DateTime.now().toString(),
                  'imageURL':'http://test.png',
                  'latitude':12345,
                  'longitude':98765,
                  'quantity': _random.nextInt(100 - 0),
                });
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Icon(Icons.cloud_upload)
            )
          ],
        ),
      ),
    );
  }
}

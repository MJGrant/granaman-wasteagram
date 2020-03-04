import 'package:flutter/material.dart';

class Photo extends StatelessWidget {

  static const routeName = 'Photo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      Text('Photo')
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Choose Photo'),
            Text('Take Photo')
          ],
        ),
      ),
    );
  }
}
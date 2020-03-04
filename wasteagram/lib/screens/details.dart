import 'package:flutter/material.dart';

class Details extends StatelessWidget {

  static const routeName = 'Details';
  final String post;

  Details({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      Text(post?? 'no post')
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('POST DATE'),
            Text('PHOTO'),
            Text('ITEMS: N'),
            Text('Latitude, Longitude')
          ],
        ),
      ),
    );
  }
}
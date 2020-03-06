import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Details extends StatelessWidget {

  static const routeName = 'Details';
  final DocumentSnapshot document;

  Details({Key key, @required this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(document['date']),
            Text(document['imageURL']),
            Text(document['quantity'].toString()),
            Text('(' +
                document['latitude'].toString() +
                ', ' +
                document['longitude'].toString() +
                ')')
          ],
        ),
      ),
    );
  }
}
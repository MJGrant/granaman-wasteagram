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
      body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DateHeadline(date: document['date']),
              Image(imageURL: document['imageURL']),
              Quantity(quantity: document['quantity']),
              Coords(lat: document['latitude'], long: document['longitude'])
            ],
          ),
        );
  }
}

class DateHeadline extends StatelessWidget {
  final String date;
  DateHeadline({this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(date,
          style: Theme.of(context).textTheme.headline),
    );
  }
}

class Image extends StatelessWidget {
  final String imageURL;
  Image({this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Text(imageURL);
  }
}

class Quantity extends StatelessWidget {
  final int quantity;
  Quantity({this.quantity});

  @override
  Widget build(BuildContext context) {
    return Text(quantity.toString());
  }
}

class Coords extends StatelessWidget {
  final int lat;
  final int long;

  Coords({this.lat, this.long});

  @override
  Widget build(BuildContext context) {
    return Text('(' +
        lat.toString() +
        ', ' +
        long.toString() +
        ')');
  }
}
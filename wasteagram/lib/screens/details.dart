import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post.dart';

class Details extends StatelessWidget {
  static const routeName = 'Details';
  final Post post;

  Details({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram')),
      body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DateHeadline(date: post.date),
              Image(imageURL: post.imageURL),
              Quantity(quantity: post.quantity),
              Coords(lat: post.latitude, long: post.longitude)
            ],
          ),
        );
  }
}

class DateHeadline extends StatelessWidget {

  final String date;
  DateHeadline({this.date});

  String formatDate(date) {
    var dateParsed = DateTime.parse(date);
    final DateFormat dateFormat = DateFormat("EEEE, MMM. d yyyy");

    return dateFormat.format(dateParsed).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(formatDate(date),
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
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/post.dart';

class Details extends StatelessWidget {
  static const routeName = 'Details';
  final Post post;

  Details({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram')),
      body: MergeSemantics(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DisplayDateHeadline(date: post.date),
            DisplayImage(imageURL: post.imageURL),
            DisplayQuantity(quantity: post.quantity),
            DisplayCoords(lat: post.latitude, long: post.longitude)
          ],
        ),
      ),
    );
  }
}

class DisplayDateHeadline extends StatelessWidget {

  final String date;
  DisplayDateHeadline({this.date});

  String formatDate(date) {
    var dateParsed = DateTime.parse(date);
    final DateFormat dateFormat = DateFormat("EEEE, MMM. d yyyy");

    return dateFormat.format(dateParsed).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        textField:true,
        readOnly:true,
        header:true,
        label:"Post title",
        value:formatDate(date),
        child: Text(formatDate(date),
          style: Theme.of(context).textTheme.headline),
      ),
    );
  }
}

class DisplayImage extends StatelessWidget {
  final String imageURL;
  DisplayImage({this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height:300,
          child: Center(
            child: Semantics(
              label:"Progress indicator",
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        Center(
          child: Semantics(
            label: "Photo of food items going to waste",
            child: FadeInImage.memoryNetwork(
              height:300,
              placeholder: kTransparentImage,
              image: this.imageURL,
            ),
          )),
        ]
    );
      //return Image.network(this.imageURL);
  }
}

class DisplayQuantity extends StatelessWidget {
  final int quantity;
  DisplayQuantity({this.quantity});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Item count",
      value: quantity.toString(),
      child: Text('Items: ' + quantity.toString())
    );
  }
}

class DisplayCoords extends StatelessWidget {
  final String lat;
  final String long;

  DisplayCoords({this.lat, this.long});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Lat and Long coordinates",
      value: '$lat, $long',
      child: Text('($lat, $long)')
    );
  }
}
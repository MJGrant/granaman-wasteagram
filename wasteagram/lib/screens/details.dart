import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/post.dart';

import '../styles.dart';
import '../util.dart';

class Details extends StatelessWidget {
  static const routeName = 'Details';
  final Post post;

  Details({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram', style: Styles.appTitle)),
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


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8.0, 0, 0),
      child: Semantics(
        textField: true,
        readOnly: true,
        header: true,
        label: "Post title",
        value: Util.formatDateWithYear(date),
        child: Text(Util.formatDateWithYear(date), style: Styles.postTitle),
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
              label: "Progress indicator",
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        Center(
          child: Semantics(
            label: "Photo of food items going to waste",
            child: FadeInImage.memoryNetwork(
              height: 300,
              placeholder: kTransparentImage,
              image: this.imageURL,
            ),
          )),
        ]
    );//return Image.network(this.imageURL);
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
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
        child: Text('Items: ' + quantity.toString(), style: Styles.detailsItemsCount)
      )
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
      child: Text('($lat, $long)', style: Styles.detailsCoords)
    );
  }
}
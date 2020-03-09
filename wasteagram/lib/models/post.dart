import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String date;
  String imageURL;
  String latitude;
  String longitude;
  int quantity;

  Post(DocumentSnapshot document) {
    this.date = document['date'];
    this.imageURL = document['imageURL'];
    this.latitude = document['latitude'];
    this.longitude = document['longitude'];
    this.quantity = document['quantity'];
  }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/post.dart';

import 'screens/details.dart';
import 'screens/new_post.dart';
import 'screens/photo.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const routeName = '/';

  final routes = {
    Photo.routeName: (context) => Photo(),
    NewPost.routeName: (context) => NewPost(),
    Details.routeName: (context) => Details(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      title: 'Wasteagram',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var totalWasted = 0;

  String formatDate(date) {
    var dateParsed = DateTime.parse(date);
    final DateFormat dateFormat = DateFormat("EEEE, MMM. d");

    return dateFormat.format(dateParsed).toString();
  }

  String formatTimestamp(date) {
    var timestampParsed = DateTime.parse(date);
    final DateFormat timestampFormat = DateFormat("jm");

    return timestampFormat.format(timestampParsed).toString();
  }

  void onTapped(document) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Details(document: document),
        ));
    //await Navigator.pushNamed(context, 'Details', arguments: {'document': document});
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    // this.date, this.photoURL, this.latitude, this.longitude, this.quantity
    Post post = Post(
      date: document['date'],
      imageURL: document['imageURL'],
      latitude: document['latitude'],
      longitude: document['longitude'],
      quantity: document['quantity'],
    );

    return ListTile(
      title: Row(children: [
        Expanded(
          child: Text(
            formatDate(post.date),
            style: Theme.of(context).textTheme.headline,
          ),
        ),
        Expanded(
            child: Text(
              post.quantity.toString(),
        ))
      ]),
      subtitle: Text(formatTimestamp(post.date)),
      onTap: () => onTapped(document),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram - $totalWasted'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('posts')
              .orderBy('date', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              totalWasted = 0;
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    totalWasted += snapshot.data.documents[index]['quantity'];
                    return _buildListItem(
                        context, snapshot.data.documents[index]);
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, 'Photo');
        },
        tooltip: 'New Post',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

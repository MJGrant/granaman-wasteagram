import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/post.dart';

import 'screens/details.dart';
import 'screens/new_post.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:image_picker/image_picker.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  static const routeName = '/';

  final routes = {
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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  File image;
  var totalWasted = 0;
  _HomePageState();

  Future getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewPost(image: image),
        ));
  }

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

  void onTapped(post) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Details(post: post),
        ));
  }

  Widget _buildListItem(BuildContext context, Post post) {

    return ListTile(
      title: Row(children: [
        Expanded(
          child: Semantics(
            label:"Post title: ${post.date}",
            child: Text(
              formatDate(post.date),
              style: Theme.of(context).textTheme.headline,
            ),
          ),
        ),
        Expanded(
            child: Semantics(
              label: "Quantity: ${post.quantity.toString()}",
              child: Text(
                post.quantity.toString(),
              ),
            ),
        ),
      ]),
      subtitle: Text(formatTimestamp(post.date)),
      onTap: () => onTapped(post),
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
                    Post post = Post(snapshot.data.documents[index]);
                    totalWasted += post.quantity;
                    return _buildListItem(
                        context, post);
                  });
            } else {
              return Center(
                  child: Semantics(
                    label:"Loading progress indicator",
                    child: CircularProgressIndicator()
                  ),
              );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Semantics(
        label:"New post button",
        hint:"Use this button to add a new post",
        child: FloatingActionButton(
          onPressed: getImage,
          tooltip: 'New Post',
          child: Icon(Icons.add),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

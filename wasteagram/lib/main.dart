import 'dart:io';
import 'package:flutter/material.dart';

import 'models/post.dart';

import 'screens/details.dart';
import 'screens/new_post.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'styles.dart';
import 'util.dart';

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
        primarySwatch: Colors.green,
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


  void onTapped(post) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Details(post: post),
        ));
  }

  Widget _buildListItem(BuildContext context, Post post) {

    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Semantics(
              label:"Post title: ${post.date}",
              child: Text(
                Util.formatDate(post.date),
                style: Styles.postTitle,
              ),
            ),
          ),
          Semantics(
            label: "Quantity: ${post.quantity.toString()}",
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(post.quantity.toString(), style: Styles.mainQuantity),
            ),
          ),
        ],
      ),
      subtitle: Text(Util.formatTimestamp(post.date)),
      onTap: () => onTapped(post),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Wasteagram', style: Styles.appTitle),
            Text(' - $totalWasted')
          ]
        ),
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

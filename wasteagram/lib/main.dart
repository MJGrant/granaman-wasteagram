import 'package:flutter/material.dart';

import 'screens/details.dart';
import 'screens/new_post.dart';
import 'screens/photo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

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
      home: MyHomePage(title: 'Wasteagram'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void onTapped(post) async {
    print(post);
    await Navigator.pushNamed(context, 'Details', arguments: {'post': post}); //print(post);
  }

  List<String> posts = ['Monday, Feb. 3 (7)', 'Sunday, Feb. 2 (4)'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            var post = posts[index];

            return ListTile(
              title: Text(post),
              onTap: () => onTapped(post),
            );
          },
          itemCount: posts.length,
          padding: EdgeInsets.all(8),
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

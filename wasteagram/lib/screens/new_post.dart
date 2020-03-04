import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewPost extends StatelessWidget {

  static const routeName = 'newPost';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
        Text('New Post')
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Photo'),
            Text('Number of items'),
            TextField(
              decoration: InputDecoration(labelText: 'Number of items'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly]
            ),
            RaisedButton(
              onPressed: () {},
              child: Icon(Icons.cloud_upload)
            )
          ],
        ),
      ),
    );
  }
}

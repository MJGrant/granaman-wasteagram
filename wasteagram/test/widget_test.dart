// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wasteagram/main.dart';
import '../lib/screens/new_post.dart';
import '../lib/screens/details.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

import '../lib/models/post.dart';

class MockPost extends Mock implements Post {}
class MockSnapshot extends Mock implements DocumentSnapshot {}

void main() {

  DocumentSnapshot doc = MockSnapshot();
  Post mockPost = Post(doc);

  // mock post
  mockPost.date = '2020-03-11 20:21:31.239663';
  mockPost.latitude = '47.704296';
  mockPost.longitude = '-122.215157';
  mockPost.quantity = 10;
  mockPost.imageURL = '';

  testWidgets('Main page is properly formed', (WidgetTester tester) async {
    await tester.pumpWidget(App());
    expect(find.text('Wasteagram'), findsOneWidget);
    expect(find.byKey(Key('newPostButton')), findsOneWidget);
  });

  testWidgets('New Post form is properly formed', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: NewPost()));

    expect(find.byKey(Key('photoPreview')), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(RaisedButton), findsOneWidget);
  });

  testWidgets('Form cannot be submitted empty', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: NewPost()));

    final Finder submit = find.byKey(Key('submitButton'));

    await tester.tap(submit);
    await tester.pump();

    expect(find.text('Please enter a quantity'), findsOneWidget);
    expect(find.text('Posting...'), findsNothing);
  });

  testWidgets('Details page is properly formed', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Details(post: mockPost)));

    expect(find.byKey(Key('displayDateHeadline')), findsOneWidget);
    expect(find.byKey(Key('displayImage')), findsOneWidget);
    expect(find.byKey(Key('displayQuantity')), findsOneWidget);
    expect(find.byKey(Key('displayCoords')), findsOneWidget);
  });

}

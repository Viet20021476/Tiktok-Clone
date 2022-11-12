// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_clone/main.dart';
import 'package:tiktok_clone/models/user.dart';
import 'package:tiktok_clone/models/video.dart';
import 'package:tiktok_clone/views/screens/authens/login_screen.dart';
import 'package:tiktok_clone/views/screens/mainScreen/add_video_screen.dart';
import 'package:tiktok_clone/views/screens/mainScreen/comment_screen.dart';
import 'package:tiktok_clone/views/screens/mainScreen/profile_screen.dart';
import 'package:tiktok_clone/views/screens/mainScreen/video_screen.dart';
import 'package:tiktok_clone/views/widgets/circle_animation.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

void main() {
  List<User> users = [];

  setUp(() => {

  });

  testWidgets('Test to see if CircleAnimation is in Login Screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    //await Firebase.initializeApp();

    await tester.pumpWidget(MaterialApp(home: LoginScreen()));
    expect(find.byType(TextInputField), findsWidgets);
  });

  testWidgets('Test to see if Dialog Option is in Add Video Screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    //await Firebase.initializeApp();

    await tester.pumpWidget(const MaterialApp(home: AddVideoScreen()));
    expect(find.byType(InkWell), findsWidgets);
  });

  test("Check if users array is empty", () => {
    expect(users, <User>[])
  });

  test("Check if users array has 1 element", () {
    users.add(User(name: "", email: "", uid: "", profilePhoto: ""));
    expect(users.length, 1);
  });
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/main.dart';

Future<void> addDelay(int ms) async {
  await Future<void>.delayed(Duration(milliseconds: ms));
}

class AppTest {}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.testTextInput.register();

  testWidgets("click register -> go to register screen",
      (WidgetTester tester) async {
    await Firebase.initializeApp().then((value) => {Get.put(AuthController())});
    file = await imageToFile(imageName: 'images/avatar', ext: 'png');
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byKey(const Key('register-screen-button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('register-label')), findsOneWidget);
  });

  testWidgets("click forgot password -> go to forgot password screen",
      (WidgetTester tester) async {
    await Firebase.initializeApp().then((value) => {Get.put(AuthController())});
    file = await imageToFile(imageName: 'images/avatar', ext: 'png');
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byKey(const Key('forgot-password-screen-button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key("Reset password")), findsOneWidget);
  });

  testWidgets("multiple tests", (WidgetTester tester) async {
    await Firebase.initializeApp().then((value) => {Get.put(AuthController())});
    await tester.pumpWidget(const MyApp());
    await tester.enterText(
        find.byKey(const Key('email-field')), 'ductung2002dp@gmail.com');
    await tester.enterText(find.byKey(const Key('password-field')), 'test123');
    await tester.tap(find.byKey(const Key('login-button')));
    await tester.pumpAndSettle();
    await addDelay(3000);
    await tester.pump();
    await tester.tap(find.byKey(const Key('search-button-bar')));
    await addDelay(5000);

    await tester.pumpAndSettle();
    expect(find.byType(TextFormField), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'st');
    await tester.tap(find.byType(TextButton));
    await addDelay(7000);
    await tester.pumpAndSettle();
    await addDelay(7000);
    expect(find.byType(Padding), findsWidgets);

    await tester.tap(find.byKey(const Key('inbox-button-bar')));
    await tester.pumpAndSettle();
    expect(find.byType(Row), findsWidgets);

    await tester.tap(find.byKey(const Key('profile-button-bar')));
    await addDelay(5000);
    await tester.pumpAndSettle();
    expect(find.byType(DefaultTabController), findsWidgets);

    await tester.tap(find.byKey(const Key('Edit-btn')));
    await addDelay(1000);
    await tester.pumpAndSettle();
    await addDelay(2000);
    expect(find.byType(InkWell), findsWidgets);

    await tester.tap(find.byKey(const Key('name')));
    await addDelay(1000);
    await tester.pumpAndSettle();
    await addDelay(1000);
    expect(find.byType(TextFormField), findsWidgets);

    await tester.tap(find.byKey(const Key('back')));
    await addDelay(1000);
    await tester.tap(find.byKey(const Key('profile-back')));
    await addDelay(1000);
    await tester.tap(find.byKey(const Key('profile-back')));
    await tester.pumpAndSettle();
    await addDelay(1000);
    expect(find.byType(DefaultTabController), findsWidgets);


    await tester.tap(find.byKey(const Key('setting')));
    await addDelay(2000);
    await tester.pumpAndSettle();
    await addDelay(2000);
    expect(find.byType(Column), findsWidgets);

    await tester.tap(find.byKey(const Key('change-pass-btn')));
    await addDelay(2000);
    await tester.pumpAndSettle();
    await addDelay(2000);
    expect(find.byType(InkWell), findsWidgets);

    await tester.tap(find.byKey(const Key('pass-back')));
    await addDelay(3000);
    await tester.tap(find.byKey(const Key('setting-back')));
    await addDelay(1000);
    await tester.tap(find.byKey(const Key('setting-back')));
    await tester.pumpAndSettle();
    await addDelay(1000);
    expect(find.byType(DefaultTabController), findsWidgets);

    await tester.tap(find.byKey(const Key('video-button-bar')));
    await addDelay(5000);
    await tester.pump();
    await tester.tap(find.byKey(Key('comment-btn')));
    await addDelay(1000);
    await tester.tap(find.byKey(Key('comment-btn')));
    await addDelay(4000);
    expect(find.byType(Column), findsWidgets);

  });

  testWidgets("enter wrong username, password -> home screen",
      (WidgetTester tester) async {
    await Firebase.initializeApp().then((value) => {Get.put(AuthController())});
    await tester.pumpWidget(const MyApp());
    await tester.enterText(
        find.byKey(const Key('email-field')), 'ductung203302dp@gmail.com');
    await tester.enterText(find.byKey(const Key('password-field')), 'test123');
    await tester.tap(find.byKey(const Key('login-button')));
    await tester.pumpAndSettle();
    await addDelay(5000);
    expect(find.byType(SnackBar), findsOneWidget);
  });
}

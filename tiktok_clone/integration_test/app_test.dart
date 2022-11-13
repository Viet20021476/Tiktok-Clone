import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
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
    await Firebase.initializeApp();
    await tester.pumpWidget(MyApp());
    await tester.tap(find.byKey(const Key('register-screen-button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('register-screen')), findsOneWidget);
  });

  testWidgets("enter correct username, password -> home screen",
      (WidgetTester tester) async {
    await Firebase.initializeApp().then((value) => {Get.put(AuthController())});
    await tester.pumpWidget(MyApp());
    await tester.enterText(
        find.byKey(const Key('email-field')), 'ductung2002dp@gmail.com');
    await tester.enterText(find.byKey(const Key('password-field')), 'test123');
    await tester.tap(find.byKey(const Key('login-button')));
    await tester.pumpAndSettle();
    await addDelay(5000);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('my-home')), findsOneWidget);
  });

  testWidgets("enter wrong username, password -> home screen",
      (WidgetTester tester) async {
    await Firebase.initializeApp().then((value) => {Get.put(AuthController())});
    await tester.pumpWidget(MyApp());
    await tester.enterText(
        find.byKey(const Key('email-field')), 'ductung203302dp@gmail.com');
    await tester.enterText(find.byKey(const Key('password-field')), 'test123');
    await tester.tap(find.byKey(const Key('login-button')));
    await tester.pumpAndSettle();
    await addDelay(5000);
    expect(find.byType(SnackBar), findsOneWidget);
  });
}

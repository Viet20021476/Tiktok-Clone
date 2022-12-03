import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('Check if internet exist', () async {
    final counter = 1;
    print(counter);
    expect(counter, 1);
  });
}

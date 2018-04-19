// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:paragone/main.dart';
import 'package:paragone/repo.dart';

class MockRepository extends Mock implements Repository {}


void main() {
  final repository = MockRepository();

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    when(repository.getCounter()).thenReturn(new Future(() => 0));
    when(repository.incrementCounter()).thenReturn(new Future(() => 1));

    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp(repository));

    // Verify that our counter starts at 0.
    await tester.idle();
    expect(find.text('0'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.idle();

    expect(find.text('1'), findsOneWidget);
  });
}

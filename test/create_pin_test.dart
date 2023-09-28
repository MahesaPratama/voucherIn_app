import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:voucherin/view/Screen/create_pin.dart';

void main() {
  testWidgets('CreatePinPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CreatePinPage()));

    // Verify the initial state of the pinController
    final pinController = tester.widget<TextField>(find.byType(TextField));
    expect(pinController.controller!.text, '');

    // Verify the existence of 'Enter Your 6 Digit Pin' text
    expect(find.text('Enter Your 6 Digit Pin'), findsOneWidget);

    // Verify the existence of the pin number buttons
    expect(find.widgetWithText(GestureDetector, '1'), findsOneWidget);
    expect(find.widgetWithText(GestureDetector, '2'), findsOneWidget);
    expect(find.widgetWithText(GestureDetector, '3'), findsOneWidget);
    expect(find.widgetWithText(GestureDetector, '4'), findsOneWidget);
    expect(find.widgetWithText(GestureDetector, '5'), findsOneWidget);
    expect(find.widgetWithText(GestureDetector, '6'), findsOneWidget);
    expect(find.widgetWithText(GestureDetector, '7'), findsOneWidget);
    expect(find.widgetWithText(GestureDetector, '8'), findsOneWidget);
    expect(find.widgetWithText(GestureDetector, '9'), findsOneWidget);
    expect(find.byIcon(FontAwesome.delete_left), findsOneWidget);
    expect(find.widgetWithText(GestureDetector, '0'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'Continue'), findsOneWidget);

    await tester.tap(find.widgetWithText(GestureDetector, '1'));
    await tester.tap(find.widgetWithText(GestureDetector, '2'));
    await tester.tap(find.widgetWithText(GestureDetector, '3'));
    await tester.tap(find.widgetWithText(GestureDetector, '4'));
    await tester.tap(find.widgetWithText(GestureDetector, '5'));
    await tester.tap(find.widgetWithText(GestureDetector, '6'));

    await tester.tap(find.byIcon(FontAwesome.delete_left));

    await tester.tap(find.widgetWithText(TextButton, 'Continue'));

    await tester.pumpAndSettle();
  });
}

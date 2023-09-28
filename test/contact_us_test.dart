import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voucherin/view/Screen/contact_us.dart';

void main() {
  testWidgets('Contact Us Page UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ContactUsPage()));
    expect(find.text('How can we help you?'), findsOneWidget);
    expect(
        find.text(
            'It looks like you have problems with our system.\nWe are ere to help you, so, please get in touch with us.'),
        findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));

    await tester.enterText(find.byType(TextFormField), 'Test message');

    final gestureDetectorFinder = find.descendant(
      of: find.byType(Stack),
      matching: find.byType(GestureDetector),
    );
    await tester.tap(gestureDetectorFinder.first);
    await tester.pump();
  });
}

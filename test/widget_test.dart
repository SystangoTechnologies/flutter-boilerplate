// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:contact_list_demo/ui/test_cases_demo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:contact_list_demo/constants/strings.dart';

void main() {

  Widget makeTestableWidget({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Login form widget initial visibility test.', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget( child: TestCasesDemoPage()));

    // To get a List of Widgets by Type <TextFormField>
    var textBoxWidgets = find.byType(TextFormField);

    // To check for the number of Widgets.
    expect(textBoxWidgets, findsWidgets);

    // To check for the exact number of Widgets.
    expect(textBoxWidgets, findsNWidgets(2));
    
    // To check for the not-logged-in text in the widget tree.
    expect(find.text(NOT_LOGGED_IN_MESSAGE), findsOneWidget);

    // To get a Widgets by Key.
    var emailField = find.byKey(Key('_emailKey'));
    var passwordField = find.byKey(Key('_passwordKey'));

    // To check for the Widgets if it exists or not.
    expect(emailField , findsOneWidget);
    expect(passwordField , findsOneWidget);

    // To check for the login-in button in the widget tree.
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Login form email validation test.', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget( child: TestCasesDemoPage()));

    // To get a Widgets by Key.
    var emailField = find.byKey(Key('_emailKey'));

    // To check for the Widgets if it exists or not.
    expect(emailField , findsOneWidget);

    /*To check for the login button existance.
    */
    // To check for the login button in the widget tree.
    var loginButton = find.text('Login');
    expect(loginButton, findsOneWidget);

    /*validation test for empty value.
    */
    // To enter empty values in the text widgets.
    await tester.enterText(emailField, '');

    // Tap on the login Button.
    await tester.tap(loginButton);
    await tester.pump();

    // check for the status text value
    expect(find.text(EMAIL_EMPTY_ERROR_MESSAGE), findsOneWidget);

    /*validation test for wrong value format.
    */
    // To enter empty values in the text widgets.
    await tester.enterText(emailField, 'test_gmail');

    // Tap on the login Button.
    await tester.tap(loginButton);
    await tester.pump();

    // check for the status text value
    expect(find.text(EMAIL_NOT_VALID_ERROR_MESSAGE), findsOneWidget);
  });

  testWidgets('Login form password validation test.', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget( child: TestCasesDemoPage()));

    // To get a Widgets by Key.
    var emailField = find.byKey(Key('_emailKey'));
    var passwordField = find.byKey(Key('_passwordKey'));

    // To check for the Widgets if it exists or not.
    expect(passwordField , findsOneWidget);
    expect(emailField , findsOneWidget);

    /*To check for the login button existance.
    */
    // To check for the login button in the widget tree.
    var loginButton = find.text('Login');
    expect(loginButton, findsOneWidget);

    /*validation test for empty value.
    */
    await tester.enterText(emailField, 'test@gmail.com');

    // To enter empty values in the text widgets.
    await tester.enterText(passwordField, '');

    // Tap on the login Button.
    await tester.tap(loginButton);
    await tester.pump();

    // check for the status text value
    expect(find.text(PASSWORD_EMPTY_ERROR_MESSAGE), findsOneWidget);

    /*validation test for short value.
    */
    // To enter empty values in the text widgets.
    await tester.enterText(passwordField, 'test');

    // Tap on the login Button.
    await tester.tap(loginButton);
    await tester.pump();

    // check for the status text value
    expect(find.text(PASSWORD_NOT_VALID_ERROR_MESSAGE), findsOneWidget);
  });

  testWidgets('Login form validation test with correct values', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget( child: TestCasesDemoPage()));

    // To get a Widgets by Key.
    var passwordField = find.byKey(Key('_passwordKey'));
    var emailField = find.byKey(Key('_emailKey'));

    // To check for the Widgets if it exists or not.
    expect(passwordField , findsOneWidget);

    /*To check for the login button existance.
    */
    // To check for the login button in the widget tree.
    var loginButton = find.text('Login');
    expect(loginButton, findsOneWidget);

    /*validation test for empty value.
    */
    // To enter empty values in the text widgets.
    await tester.enterText(emailField, 'test@gmail.com');
    await tester.enterText(passwordField, 'test123');

    // Tap on the login Button.
    await tester.tap(loginButton);
    await tester.pump();

    // check for the status text value
    expect(find.text(LOGGED_IN_MESSAGE), findsOneWidget);
  });
}
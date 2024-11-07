import 'package:busha_app/presentation/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Verify that entering an invalid email or password throws a validation error',
      (WidgetTester tester) async {
    //Arrange - Pump MyApp() widget to tester
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // find our email and password text-fields
    final emailTextField = find.byKey(const Key("emailTextField"));
    final passwordTextField = find.byKey(const Key("passwordTextField"));
    final submitButton = find.byKey(const Key('continueBtn'));

    expect(emailTextField, findsOneWidget);
    expect(passwordTextField, findsOneWidget);

    await tester.tap(submitButton);
    await tester.pump();

    // check to see that the error, email cannot be empty or password cannot be empty is shown
    expect(find.text("Email cannot be empty"), findsOneWidget);
    expect(find.text("password cannot be empty"), findsOneWidget);

    await tester.enterText(emailTextField, 'invalid-email');
    await tester.enterText(passwordTextField, 'pass');

    await tester.tap(submitButton);
    await tester.pump();

    expect(find.text('Please enter a valid email'), findsOneWidget);
    expect(
        find.text('Your password should have at least one upper case, number and special characters'), findsOneWidget);
  });

  testWidgets('Verify that entering a valid email and password navigates the user to the home screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // find our email and password text-fields
    final emailTextField = find.byKey(const Key("emailTextField"));
    final passwordTextField = find.byKey(const Key("passwordTextField"));
    final submitButton = find.byKey(const Key('continueBtn'));

    expect(emailTextField, findsOneWidget);
    expect(passwordTextField, findsOneWidget);

    await tester.enterText(emailTextField, 'invalid-email@gmail.com');
    await tester.enterText(passwordTextField, "Password##%");

    await tester.tap(submitButton);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('Please enter a valid email'), findsNothing);
    expect(find.text('Your password should have at least one upper case, number and special characters'), findsNothing);

    expect(find.text("My Balance"), findsOneWidget);
  });
}

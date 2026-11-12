import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pablo_navigation_app/demo_auth.dart';
import 'package:pablo_navigation_app/main.dart';

void main() {
  setUp(() {
    DemoAuth.registeredUsername = null;
    DemoAuth.registeredPassword = null;
  });

  Future<void> loginAsDefaultUser(WidgetTester tester) async {
    await tester.pumpWidget(const StudentApp());
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'Vincent29',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'lourdevincent102006',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Login'));
    await tester.pumpAndSettle();
  }

  group('Authentication Testing', () {
    testWidgets('launches on Login screen and validates empty fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(const StudentApp());

      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.widgetWithText(AppBar, 'Login'), findsOneWidget);

      await tester.tap(find.widgetWithText(FilledButton, 'Login'));
      await tester.pump();

      expect(find.text('Please enter your username'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('toggles password visibility on Login screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(const StudentApp());

      expect(find.byIcon(Icons.visibility), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off), findsNothing);

      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsNothing);
    });

    testWidgets('shows SnackBar on invalid credentials',
        (WidgetTester tester) async {
      await tester.pumpWidget(const StudentApp());

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Username'),
        'unknown',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'wrongpass',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Login'));
      await tester.pump();

      expect(find.text('Invalid username or password.'), findsOneWidget);
      expect(find.text('Welcome Back'), findsOneWidget);
    });

    testWidgets('logs in successfully with default credentials',
        (WidgetTester tester) async {
      await loginAsDefaultUser(tester);

      expect(find.text('Welcome, Student!'), findsOneWidget);
      expect(find.byType(NavigationBar), findsOneWidget);
    });

    testWidgets('validates registration rules and registers new account',
        (WidgetTester tester) async {
      await tester.pumpWidget(const StudentApp());

      await tester.tap(find.widgetWithText(OutlinedButton, 'Register'));
      await tester.pumpAndSettle();

      expect(find.text('Create an Account'), findsOneWidget);

      // Return via Login link and re-open Register screen
      await tester.tap(
        find.widgetWithText(TextButton, 'Already have an account? Login'),
      );
      await tester.pumpAndSettle();
      expect(find.text('Welcome Back'), findsOneWidget);

      await tester.tap(find.widgetWithText(OutlinedButton, 'Register'));
      await tester.pumpAndSettle();

      // Short username, short password, mismatched confirm password
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Username'),
        'ab',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        '12345',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Confirm Password'),
        '54321',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Register'));
      await tester.pump();

      expect(
        find.text('Username must be at least 3 characters'),
        findsOneWidget,
      );
      expect(
        find.text('Password must be at least 6 characters'),
        findsOneWidget,
      );
      expect(find.text('Passwords do not match'), findsOneWidget);

      // Reserved username 'admin'
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Username'),
        'admin',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'secret123',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Confirm Password'),
        'secret123',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Register'));
      await tester.pump();

      expect(find.text('The username "admin" is reserved'), findsOneWidget);

      // Reserved username 'Vincent29'
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Username'),
        'Vincent29',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Register'));
      await tester.pump();

      expect(
        find.text('The username "Vincent29" is reserved'),
        findsOneWidget,
      );

      // Valid registration
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Username'),
        'lourde',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Register'));
      await tester.pumpAndSettle();

      expect(
        find.text('Registration successful! You can now log in.'),
        findsOneWidget,
      );
      expect(find.text('Welcome Back'), findsOneWidget);

      // Log in with newly registered account
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Username'),
        'lourde',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'secret123',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Login'));
      await tester.pumpAndSettle();

      expect(find.text('Welcome, Student!'), findsOneWidget);
    });
  });

  group('Navigation, Calculator, Profile, and Social Media Testing', () {
    testWidgets('navigates all 4 destinations and preserves calculator state',
        (WidgetTester tester) async {
      await loginAsDefaultUser(tester);

      // Home page verification
      expect(find.text('Welcome, Student!'), findsOneWidget);
      expect(
        find.text('Use the navigation bar below to explore the app.'),
        findsOneWidget,
      );
      expect(
        find.text('Perform basic arithmetic operations.'),
        findsOneWidget,
      );
      expect(find.text('View your student information.'), findsOneWidget);
      expect(find.text('View your sample social accounts.'), findsOneWidget);
      expect(find.byIcon(Icons.home), findsWidgets);
      expect(find.byIcon(Icons.calculate_outlined), findsOneWidget);

      // Switch to Calculator
      await tester.tap(find.text('Calculator').last);
      await tester.pump();

      expect(find.byIcon(Icons.home_outlined), findsOneWidget);
      expect(find.text('My Stateful Calculator'), findsOneWidget);
      expect(find.byIcon(Icons.calculate), findsWidgets);

      final firstField = find.widgetWithText(TextField, 'First Number');
      final secondField = find.widgetWithText(TextField, 'Second Number');

      await tester.enterText(firstField, '12');
      await tester.enterText(secondField, '4');

      // Addition
      await tester.tap(find.widgetWithText(ElevatedButton, '+'));
      await tester.pump();
      expect(find.text('16.0'), findsOneWidget);

      // Subtraction
      await tester.tap(find.widgetWithText(ElevatedButton, '−'));
      await tester.pump();
      expect(find.text('8.0'), findsOneWidget);

      // Multiplication
      await tester.tap(find.widgetWithText(ElevatedButton, '×'));
      await tester.pump();
      expect(find.text('48.0'), findsOneWidget);

      // Division
      await tester.tap(find.widgetWithText(ElevatedButton, '÷'));
      await tester.pump();
      expect(find.text('3.0'), findsOneWidget);

      // Switch to Profile and verify student details while preserving state
      await tester.tap(find.text('Profile').last);
      await tester.pump();

      expect(find.text('My Profile'), findsOneWidget);
      expect(find.text('LOURDE VINCENT M. PABLO'), findsWidgets);
      expect(find.text('553470'), findsOneWidget);
      expect(find.text('BSIT — CCE106L (3447)'), findsWidgets);
      expect(find.text('lourdevincentpablo26@gmail.com'), findsOneWidget);

      // Switch to Social Media and test SnackBar
      await tester.tap(find.text('Social Media').last);
      await tester.pump();

      expect(find.text('Connect With Me'), findsOneWidget);
      expect(find.text('Lourde Vincent'), findsOneWidget);
      expect(find.text('@lrdvncnt_'), findsOneWidget);
      expect(find.text('@VtechChannel'), findsOneWidget);

      await tester.tap(find.text('Facebook'));
      await tester.pump();
      expect(
        find.text('Selected account: Facebook: Lourde Vincent'),
        findsOneWidget,
      );

      await tester.tap(find.text('Instagram'));
      await tester.pump();
      expect(
        find.text('Selected account: Instagram: @lrdvncnt_'),
        findsOneWidget,
      );

      await tester.tap(find.text('YouTube'));
      await tester.pump();
      expect(
        find.text('Selected account: YouTube: @VtechChannel'),
        findsOneWidget,
      );

      // Return to Calculator and confirm input & result were preserved
      await tester.tap(find.text('Calculator').last);
      await tester.pump();

      expect(find.text('12'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('3.0'), findsOneWidget);

      // Division by zero handling
      await tester.enterText(secondField, '0');
      await tester.tap(find.widgetWithText(ElevatedButton, '÷'));
      await tester.pump();
      expect(find.text('Cannot divide by zero'), findsOneWidget);

      // Invalid input handling
      await tester.enterText(firstField, 'abc');
      await tester.tap(find.widgetWithText(ElevatedButton, '+'));
      await tester.pump();
      expect(find.text('Invalid input'), findsOneWidget);

      // Clear button resets calculator
      await tester.ensureVisible(find.text('Clear'));
      await tester.tap(find.text('Clear'));
      await tester.pump();
      expect(find.text('0'), findsOneWidget);
      expect(find.text('Enter two numbers'), findsOneWidget);
    });
  });
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:menstrual_health_system/app.dart';
import 'package:menstrual_health_system/core/constants/app_strings.dart';

void main() {
  testWidgets('App renders welcome screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        path: 'assets/translations',
        startLocale: const Locale('en'),
        supportedLocales: const [
          Locale('en'),
          Locale('hi'),
          Locale('bn'),
          Locale('te'),
          Locale('ta'),
          Locale('mr'),
        ],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify that the app title is shown.
    expect(find.text(AppStrings.appName), findsOneWidget);
  });
}

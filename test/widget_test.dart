// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:crypto_pair_trading/resource/app_constants.dart';
import 'package:crypto_pair_trading/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:crypto_pair_trading/main.dart';

void main() {
  group(('Testing the widget in home screen for different scenarios'), (){


    //CASE 1 - Positive scenario - Search currency pair
    testWidgets('Search currency pair positive scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      var txtForm = find.byKey(const Key(AppConstants.keySearchText));
      await tester.enterText(txtForm, 'btcusd');
      expect(find.text('btcusd'), findsOneWidget); // alphabets are valid
    });

    //CASE 2 - Neagtive scenario - Search currency pair
    testWidgets('Search currency pair positive scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      var txtForm = find.byKey(const Key(AppConstants.keySearchText));
      await tester.enterText(txtForm, '123');
      expect(find.text('123'), findsNothing); // numbers shouldn't be allowed
    });

    //CASE 3 - Positive scenario - Find floating action button
    testWidgets('Find floating action button positive scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      var buttonFinder = find.byKey(const Key(AppConstants.keyFloatingActionButton));
      expect(buttonFinder, findsOneWidget); // alphabets are valid
    });

    //CASE 4 - Negative scenario - Testing open title
    testWidgets('Testing open title negative scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      const String title = AppConstants.open;
      final titleFinder = find.text(title);
      expect(titleFinder, findsNothing);
    });

    //CASE 5 - Negative scenario - Testing high title
    testWidgets('Testing high title negative scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      const String title = AppConstants.high;
      final titleFinder = find.text(title);
      expect(titleFinder, findsNothing);
    });

    //CASE 6 - Negative scenario - Testing low title
    testWidgets('Testing low title negative scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      const String title = AppConstants.low;
      final titleFinder = find.text(title);
      expect(titleFinder, findsNothing);
    });

    //CASE 7 - Negative scenario - Testing last title
    testWidgets('Testing last title negative scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      const String title = AppConstants.last;
      final titleFinder = find.text(title);
      expect(titleFinder, findsNothing);
    });

    //CASE 8 - Negative scenario - Testing volume title
    testWidgets('Testing volume title negative scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      const String title = AppConstants.volume;
      final titleFinder = find.text(title);
      expect(titleFinder, findsNothing);
    });

    //CASE 9 - Negative scenario - Testing view order book title
    testWidgets('Testing view order book button negative scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      const String title = AppConstants.viewOrderBook;
      final titleFinder = find.text(title);
      expect(titleFinder, findsNothing);
    });

    //CASE 10 - Negative scenario - Testing hide order book title
    testWidgets('Testing hide order book button negative scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      const String title = AppConstants.hideOrderBook;
      final titleFinder = find.text(title);
      expect(titleFinder, findsNothing);
    });

    //CASE 11 - Negative scenario - Testing ask price title
    testWidgets('Testing ask price title negative scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      const String title = AppConstants.askPrice;
      final titleFinder = find.text(title);
      expect(titleFinder, findsNothing);
    });

    //CASE 12 - Negative scenario - Testing quantity title
    testWidgets('Testing quantity title negative scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      const String title = AppConstants.qty;
      final titleFinder = find.text(title);
      expect(titleFinder, findsNothing);
    });

    //CASE 13 - Negative scenario - Testing bid price title
    testWidgets('Testing bid price title negative scenario', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      const String title = AppConstants.bidPrice;
      final titleFinder = find.text(title);
      expect(titleFinder, findsNothing);
    });

  });
}

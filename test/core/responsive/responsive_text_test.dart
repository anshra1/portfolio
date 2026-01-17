import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/responsive_text/responsive_text.dart';

void main() {
  group('ResponsiveText', () {
    testWidgets('renders base font size on Mobile (<600)', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(400, 800)), // Mobile
            child: ResponsiveText(
              'Mobile Text',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      );

      final textFinder = find.text('Mobile Text');
      final textWidget = tester.widget<Text>(textFinder);
      // Mobile scale is 1.0 -> 20 * 1.0 = 20.0
      expect(textWidget.style?.fontSize, equals(20.0));
    });

    testWidgets('renders scaled font size on Tablet (600-1200)', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(800, 1000)), // Tablet
            child: ResponsiveText(
              'Tablet Text',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      );

      final textFinder = find.text('Tablet Text');
      final textWidget = tester.widget<Text>(textFinder);
      // Tablet scale is 1.25 -> 20 * 1.25 = 25.0
      expect(textWidget.style?.fontSize, equals(25.0));
    });

    testWidgets('renders scaled font size on Desktop (>1200)', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(1600, 900)), // Desktop
            child: ResponsiveText(
              'Desktop Text',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      );

      final textFinder = find.text('Desktop Text');
      final textWidget = tester.widget<Text>(textFinder);
      // Desktop scale is 1.5 -> 20 * 1.5 = 30.0
      expect(textWidget.style?.fontSize, equals(30.0));
    });
  });
}

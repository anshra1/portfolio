import 'package:core_ui_kit/src/widgets/buttons/kit_base_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('KitBaseButton renders child', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KitBaseButton(
            onPressed: () {},
            child: const Text('Click Me'),
          ),
        ),
      ),
    );

    expect(find.text('Click Me'), findsOneWidget);
  });

  testWidgets('KitBaseButton calls onPressed when tapped', (WidgetTester tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KitBaseButton(
            onPressed: () {
              tapped = true;
            },
            child: const Text('Click Me'),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    expect(tapped, isTrue);
  });

  testWidgets('KitBaseButton is disabled when onPressed is null', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KitBaseButton(
            onPressed: null,
            child: const Text('Click Me'),
          ),
        ),
      ),
    );

    final elevatedButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(elevatedButton.enabled, isFalse);
  });
}

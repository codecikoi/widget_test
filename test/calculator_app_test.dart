import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test/main.dart';
import 'package:widget_test/utilities/calculator.dart';
import 'package:widget_test/utilities/operation.dart';
import 'package:widget_test/widgets/operation_widget.dart';

void main() {
  late Calculator calculator;

  setUp(
    () => calculator = Calculator(),
  );

  group('CalculatorApp', () {
    testWidgets('render 4 widgets of listTile type',
        (WidgetTester tester) async {
      // create the widget - CalculatorApp()
      await tester.pumpWidget(CalculatorApp());

      // create the finders
      final listTileFinder = find.byType(ListTile);

      // comparing finder with matcher
      expect(
        listTileFinder,
        findsNWidgets(4),
      );
    });
  });

  group('add', () {
    testWidgets('show result when gives two numbers', (tester) async {
      await tester.pumpWidget(CalculatorApp());

      final topTextFieldFinder = find.byKey(Key('textField_top_adding'));
      final bottomTextFieldFinder = find.byKey(Key('textField_bottom_adding'));

      await tester.enterText(topTextFieldFinder, '4');
      await tester.enterText(bottomTextFieldFinder, '44');

      final textResultFinder = find.text('result: 48.0');

      // await tester.pump();
      await tester.pumpAndSettle();
      expect(
        textResultFinder,
        findsOneWidget,
      );
    });
  });

  group('operation widget', () {
    testWidgets('render 48 when 4 + 44', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OperationWidget(
              operation: Operation.add,
              calculator: calculator,
            ),
          ),
        ),
      );
      await tester.enterText(find.byKey(Key('textField_top_adding')), '4');
      await tester.enterText(find.byKey(Key('textField_bottom_adding')), '44');

      await tester.pumpAndSettle();

      expect(
        find.text('result: 48.0'),
        findsOneWidget,
      );
    });
  });
}

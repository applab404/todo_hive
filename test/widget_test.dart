// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo_hive/main.dart';
import 'package:todo_hive/models/todo.dart';
import 'package:todo_hive/widgets/todo_tile.dart';

void main() {
  testWidgets('TodoTile displays title and handles toggle',
      (WidgetTester tester) async {
    bool toggled = false;
    bool deleted = false;

    final todo = Todo(title: 'Do homework', isDone: false);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TodoTile(
            todo: todo,
            onToggle: () {
              toggled = true;
            },
            onDelete: () {
              deleted = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('Do homework'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    expect(toggled, isTrue);
    expect(deleted, isFalse);
  });
}

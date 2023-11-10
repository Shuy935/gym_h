import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_h/widget/interfaces/tapbar.dart';

void main() {
  testWidgets('Test TabBarH widget', (WidgetTester tester) async {
    // Construye el widget TabBarH
    await tester.pumpWidget(MaterialApp(home: TabBarH()));

      expect(find.text('Inicio'), findsOneWidget);
    expect(find.text('Rutina'), findsOneWidget);
    expect(find.text('Musculos'), findsOneWidget);
    expect(find.text('Lista'), findsOneWidget);
    expect(find.text('Historial'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_h/widget/interfaces/Ejercicios.dart';
import 'package:gym_h/widget/interfaces/muscles.dart';

void main() {
  testWidgets('MuscleScrn should display a list of muscles', (WidgetTester tester) async {
    // Build the MuscleScrn widget.
    await tester.pumpWidget(MaterialApp(home: MuscleScrn()));

    // Verify that the widget displays a list of muscles.
    expect(find.text('Bíceps'), findsOneWidget);
    expect(find.text('Tríceps'), findsOneWidget);
    expect(find.text('Hombro'), findsOneWidget);
    expect(find.text('Espalda'), findsOneWidget);
    expect(find.text('Pecho'), findsOneWidget);
    expect(find.text('Abdomen'), findsOneWidget);
    expect(find.text('Glúteo'), findsOneWidget);
    expect(find.text('Cuádriceps'), findsOneWidget);
    expect(find.text('Femoral'), findsOneWidget);
    expect(find.text('Pantorrilla'), findsOneWidget);
  });
}

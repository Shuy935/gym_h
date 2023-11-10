import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_h/widget/interfaces/Ejercicios.dart';
import 'package:gym_h/widget/interfaces/muscles.dart';
import 'package:gym_h/widget/interfaces/ArchivoParaMeterEjerciciosMamalones.dart';
import 'package:gym_h/widget/interfaces/Buscador.dart';
import 'package:gym_h/widget/interfaces/tapbar.dart';

void main() {
  testWidgets('Test MuscleScrn and TabBarH widgets', (WidgetTester tester) async {
    // Build the main app with TabBarH widget.
    await tester.pumpWidget(MaterialApp(
      home: TabBarH(),
    ));

    // Verify that MuscleScrn widget is present and contains specific elements.
    expect(find.byType(MuscleScrn), findsOneWidget);

    // Verifying specific elements in MuscleScrn widget.
    expect(find.text('Selecciona de 1-3 músculos'), findsOneWidget);
    expect(find.text('Bíceps'), findsOneWidget);
    expect(find.text('Tríceps'), findsOneWidget);

    // Verify that TabBarH widget is present.
    expect(find.byType(TabBarH), findsOneWidget);

    // Verifying specific elements in TabBarH widget.
    expect(find.text('Inicio'), findsOneWidget);
    expect(find.text('Rutina'), findsOneWidget);
    expect(find.text('Musculos'), findsOneWidget);
    expect(find.text('Lista'), findsOneWidget);
    expect(find.text('Historial'), findsOneWidget);

    // You can add more specific tests for each widget if needed, such as button interactions, tab switching, and so on.
  });
}

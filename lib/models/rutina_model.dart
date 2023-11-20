import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class RutinaService {
  final String? repeticiones;
  final String? series;
  final String? fecha;
  final String? objectIdExercise;
  final String? userId;

  RutinaService({
    this.repeticiones,
    this.series,
    this.fecha,
    this.objectIdExercise,
    this.userId,
  });
}

Future<void> addRutina(
    List<String> ejerciciosSeleccionados, List<String> selectedDias) async {
  final currentUser = FirebaseAuth.instance.currentUser;

  // Dividir la lista en conjuntos de tres
  for (int i = 0; i < ejerciciosSeleccionados.length; i += 3) {
    // Obtener el conjunto de tres elementos
    List<String> conjunto = ejerciciosSeleccionados.sublist(i, i + 3);

    final objeto = ParseObject('rutinas')
      ..set('repeticiones', conjunto[2])
      ..set('series', conjunto[1])
      ..set('fecha', selectedDias)
      ..set('userId', currentUser?.uid)
      ..set(
          'objetoIdExercise', ParseObject('exercise')..objectId = conjunto[0]);

    try {
      await objeto.save();
      Utils.showSusSnackBar('Se agrego la rutina');
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:gym_h/models/users_model.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class HistorialService {
  final String? repeticiones;
  final String? series;
  final String? fecha; // Cambiado a String
  final String? objectIdExercise;
  final String? userId;
  final String? linkImagen;
  final String? nombreMusculo;
  final String? dificultad;
  final String? descanso;
  final String? nombreEjercicio;

  HistorialService({
    this.repeticiones,
    this.series,
    this.fecha,
    this.objectIdExercise,
    this.userId,
    this.descanso,
    this.dificultad,
    this.linkImagen,
    this.nombreMusculo,
    this.nombreEjercicio,
  });

  @override
  String toString() {
    // Devuelve una cadena que representa la información de la instancia
    return '{objectIdExercise: $objectIdExercise, repeticiones: $repeticiones, series: $series, fecha: $fecha, userId: $userId, nombreEjercicio: $nombreEjercicio, descanso: $descanso, dificultad: $dificultad, nombreMusculo: $nombreMusculo, linkImagen: $linkImagen}';
  }
}

Future<void> addHistorial(List<String> ejerciciosSeleccionados) async {
  final dateFormat = DateFormat('yyyy-MM-dd');
  final currentUser = FirebaseAuth.instance.currentUser;

  for (int i = 0; i < ejerciciosSeleccionados.length; i += 3) {
    List<String> conjunto = ejerciciosSeleccionados.sublist(i, i + 3);

    // Obtener la fecha formateada (año, mes, día)
    final fechaF = dateFormat.format(DateTime.now());
    
    final objeto = ParseObject('historial')
      ..set('repeticiones', conjunto[2])
      ..set('series', conjunto[1])
      ..set('fecha', fechaF) // Cambiado a DateTime.now().toString()
      ..set('userId', currentUser?.uid)
      ..set(
          'objectIdExercise', ParseObject('exercise')..objectId = conjunto[0]);

    try {
      await objeto.save();
      Utils.showSusSnackBar('Se agregó al historial');
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }
}

Future<List<HistorialService>?> readHistorial() async {
  final currentUser = FirebaseAuth.instance.currentUser;

  try {
    final query = QueryBuilder<ParseObject>(ParseObject('historial'))
      ..whereEqualTo('userId', currentUser?.uid)
      ..includeObject(['objectIdExercise']);

    final ParseResponse response = await query.query();
    if (response.success) {
      return response.results?.map((a) {
        final exerciseObject = a.get<ParseObject>('objectIdExercise');
        return HistorialService(
          objectIdExercise: exerciseObject?.objectId,
          fecha: a.get('fecha'),
          repeticiones: a.get('repeticiones'),
          series: a.get('series'),
          userId: a.get('userId'),
          nombreMusculo: exerciseObject?.get<String>('nombreMusculo'),
          descanso: exerciseObject?.get<String>('descanso'),
          dificultad: exerciseObject?.get<String>('dificultad'),
          nombreEjercicio: exerciseObject?.get<String>('nombreEjercicio'),
          linkImagen: exerciseObject?.get<String>('linkImagen'),
        );
      }).toList();
    } else {
      Utils.showSnackBar(response.error?.message);
    }
  } catch (e) {
    Utils.showSnackBar(e.toString());
  }
  return null;
}

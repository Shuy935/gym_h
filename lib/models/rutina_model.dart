import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class RutinaService {
  final String? repeticiones;
  final String? series;
  final int? fecha;
  final String? objectIdExercise;
  final String? userId;
  final String? linkImagen;
  final String? nombreMusculo;
  final String? dificultad;
  final String? descanso;
  final String? nombreEjercicio;

  RutinaService({
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
    return '{objectIdExercise: $objectIdExercise, repeticiones: $repeticiones, series: $series, fecha: $fecha, userId: $userId, nombreEjercicio: $nombreEjercicio, descanso: $descanso, dificuldad: $dificultad, nombreMusculo: $nombreMusculo, linkImagen: $linkImagen}';
  }
}

Future<void> addRutina(
    List<String> ejerciciosSeleccionados, List<String> selectedDias) async {
  final currentUser = FirebaseAuth.instance.currentUser;

  // Dividir la lista en conjuntos de tres
  for (int i = 0; i < ejerciciosSeleccionados.length; i += 3) {
    // Obtener el conjunto de tres elementos
    List<String> conjunto = ejerciciosSeleccionados.sublist(i, i + 3);
    int numDia = 0;
    String dia = selectedDias[0];
    dia.replaceAll('[', '').replaceAll(']', '');
    if (dia == 'Lunes') {
      numDia = 1;
    } else if (dia == 'Martes') {
      numDia = 2;
    } else if (dia == 'Miércoles') {
      numDia = 3;
    } else if (dia == 'Jueves') {
      numDia = 4;
    } else if (dia == 'Viernes') {
      numDia = 5;
    } else if (dia == 'Sábado') {
      numDia = 6;
    } else if (dia == 'Domingo') {
      numDia = 7;
    }
    final objeto = ParseObject('rutinas')
      ..set('repeticiones', conjunto[2])
      ..set('series', conjunto[1])
      ..set('fecha', numDia)
      ..set('userId', currentUser?.uid)
      ..set(
          'objectIdExercise', ParseObject('exercise')..objectId = conjunto[0]);

    try {
      await objeto.save();
      Utils.showSusSnackBar('Se agrego la rutina');
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }
}

Future<void> addRutinaUsuario(List<String> ejerciciosSeleccionados,
    List<String> selectedDias, String? username) async {
  final userId = await getUserIdByFullname(username!);
  // Dividir la lista en conjuntos de tres
  for (int i = 0; i < ejerciciosSeleccionados.length; i += 3) {
    // Obtener el conjunto de tres elementos
    List<String> conjunto = ejerciciosSeleccionados.sublist(i, i + 3);

    final objeto = ParseObject('rutinas')
      ..set('repeticiones', conjunto[2])
      ..set('series', conjunto[1])
      ..set('fecha', selectedDias)
      ..set('userId', userId?[0].firebaseUserId)
      ..set(
          'objectIdExercise', ParseObject('exercise')..objectId = conjunto[0]);

    try {
      await objeto.save();
      Utils.showSusSnackBar('Se agrego la rutina');
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }
}

Future<List<RutinaService>?> readRutina() async {
  final currentUser = FirebaseAuth.instance.currentUser;

  // Se hace un for para agarrar todos los datos
  try {
    final query = QueryBuilder<ParseObject>(ParseObject('rutinas'))
      ..whereEqualTo('userId', currentUser?.uid)
      ..includeObject(['objectIdExercise']);

    final ParseResponse response = await query.query();
    if (response.success) {
      return response.results?.map((a) {
        final exerciseObject = a.get<ParseObject>('objectIdExercise');
        return RutinaService(
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

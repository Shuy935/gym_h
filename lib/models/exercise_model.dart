import 'package:firebase_database/firebase_database.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ExerciseService {
  final String? nombreEjercicio;
  final int? descanso;
  final String? dificuldad;
  final String? nombreMusculo;

  ExerciseService({
    this.nombreMusculo,
    this.dificuldad,
    this.descanso,
    this.nombreEjercicio,
  });
}

ParseObject mapModel(ExerciseService exerciseService) {
  final objeto = ParseObject('exercise')
    ..set('nombre-ejercicio', exerciseService.nombreEjercicio)
    ..set('nombre-musculo', exerciseService.nombreMusculo)
    ..set('dificultad', exerciseService.dificuldad)
    ..set('descanso', exerciseService.descanso);
  return objeto;
}

exerciseCreate(ExerciseService exerciseService) async {
  final objeto = mapModel(exerciseService);
  try {
    await objeto.save();
  } catch (e) {
    print(e);
  }
}

import 'package:gym_h/utils/utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ExerciseService {
  final String? nombreEjercicio;
  final String? descanso;
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
    ..set('descanso', exerciseService.descanso)
    ..set('dificultad', exerciseService.dificuldad)
    ..set('nombre-musculo', exerciseService.nombreMusculo);
  return objeto;
}

Future<void> exerciseCreate(ExerciseService exerciseService) async {
  final objeto = ParseObject('exercise')
    ..set('nombreEjercicio', exerciseService.nombreEjercicio)
    ..set('descanso', exerciseService.descanso)
    ..set('dificultad', exerciseService.dificuldad)
    ..set('nombreMusculo', exerciseService.nombreMusculo);
  try {
    await objeto.save();
  } catch (e) {
    Utils.showSnackBar(e.toString());
  }
}

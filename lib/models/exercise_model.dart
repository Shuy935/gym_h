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

exerciseCreate(ExerciseService exerciseService) async {
  final objeto = mapModel(exerciseService);
  try {
    print(objeto);
    final a = await objeto.save();
    print(a.results);
  } catch (e) {
    Utils.showSnackBar(e.toString());
  }
}

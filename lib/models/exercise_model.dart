import 'dart:io';

import 'package:gym_h/utils/utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ExerciseService {
  final String? nombreEjercicio;
  final String? descanso;
  final String? dificuldad;
  final String? nombreMusculo;
  final String? linkImagen;

  ExerciseService({
    this.nombreMusculo,
    this.dificuldad,
    this.descanso,
    this.nombreEjercicio,
    this.linkImagen,
  });
}

Future<void> exerciseCreate(ExerciseService exerciseService) async {
  final objeto = ParseObject('exercise')
    ..set('nombreEjercicio', exerciseService.nombreEjercicio)
    ..set('descanso', exerciseService.descanso)
    ..set('dificultad', exerciseService.dificuldad)
    ..set('nombreMusculo', exerciseService.nombreMusculo)
    ..set('linkImagen', exerciseService.linkImagen);
  try {
    final a = await objeto.save();
    print(a.error);
  } catch (e) {
    Utils.showSnackBar(e.toString());
  }
}

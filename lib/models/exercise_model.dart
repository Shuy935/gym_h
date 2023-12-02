import 'package:gym_h/utils/utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ExerciseService {
  final String? objectId;
  final String? nombreEjercicio;
  final String? descanso;
  final String? dificuldad;
  final String? nombreMusculo;
  final String? linkImagen;

  ExerciseService({
    this.objectId,
    this.nombreMusculo,
    this.dificuldad,
    this.descanso,
    this.nombreEjercicio,
    this.linkImagen,
  });
  @override
  String toString() {
    // Devuelve una cadena que representa la información de la instancia
    return '{objectId: $objectId, nombreEjercicio: $nombreEjercicio, descanso: $descanso, dificuldad: $dificuldad, nombreMusculo: $nombreMusculo, linkImagen: $linkImagen}';
  }
}

Future<void> exerciseCreate(ExerciseService exerciseService) async {
  final objeto = ParseObject('exercise')
    ..set('nombreEjercicio', exerciseService.nombreEjercicio)
    ..set('descanso', exerciseService.descanso)
    ..set('dificultad', exerciseService.dificuldad)
    ..set('nombreMusculo', exerciseService.nombreMusculo)
    ..set('linkImagen', exerciseService.linkImagen);
  try {
    await objeto.save();
  } catch (e) {
    Utils.showSnackBar(e.toString());
  }
}

Future<List<ExerciseService>?> readOneExercise(String musculo) async {
  try {
    final query = QueryBuilder<ParseObject>(ParseObject('exercise'))
      ..whereEqualTo('nombreMusculo', musculo);
    final response = await query.query();
    if (response.success) {
      return response.results?.map((a) {
        return ExerciseService(
          objectId: a.get('objectId') ?? '',
          descanso: a.get('descanso') ?? '',
          dificuldad: a.get('dificultad') ?? '',
          linkImagen: a.get('linkImagen') ?? '',
          nombreEjercicio: a.get('nombreEjercicio') ?? '',
          nombreMusculo: a.get('nombreMusculo') ?? '',
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

Future<List<ExerciseService>?> readObjExercise(String musculo) async {
  try {
    final query = QueryBuilder<ParseObject>(ParseObject('exercise'))
      ..whereEqualTo('nombreMusculo', musculo);
    final response = await query.query();
    if (response.success) {
      return response.results?.map((a) {
        return ExerciseService(
          objectId: a.get('objectId') ?? '',
          descanso: a.get('descanso') ?? '',
          dificuldad: a.get('dificultad') ?? '',
          linkImagen: a.get('linkImagen') ?? '',
          nombreEjercicio: a.get('nombreEjercicio') ?? '',
          nombreMusculo: a.get('nombreMusculo') ?? '',
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

Future<List<ExerciseService>?> readTwoExercise(
    String musculo1, String musculo2) async {
  try {
    final query = QueryBuilder<ParseObject>(ParseObject('exercise'))
      ..whereContainedIn('nombreMusculo', [musculo1, musculo2]);
    final response = await query.query();
    if (response.success) {
      return response.results?.map((a) {
        return ExerciseService(
          objectId: a.get('objectId') ?? '',
          descanso: a.get('descanso') ?? '',
          dificuldad: a.get('dificultad') ?? '',
          linkImagen: a.get('linkImagen') ?? '',
          nombreEjercicio: a.get('nombreEjercicio') ?? '',
          nombreMusculo: a.get('nombreMusculo') ?? '',
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

Future<List<ExerciseService>?> readThreeExercise(
    String musculo1, String musculo2, String musculo3) async {
  try {
    final query = QueryBuilder<ParseObject>(ParseObject('exercise'))
      ..whereContainedIn('nombreMusculo', [musculo1, musculo2, musculo3]);
    final response = await query.query();
    if (response.success) {
      return response.results?.map((a) {
        return ExerciseService(
          objectId: a.get('objectId') ?? '',
          descanso: a.get('descanso') ?? '',
          dificuldad: a.get('dificultad') ?? '',
          linkImagen: a.get('linkImagen') ?? '',
          nombreEjercicio: a.get('nombreEjercicio') ?? '',
          nombreMusculo: a.get('nombreMusculo') ?? '',
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

Future<List<ExerciseService>?> readExercises() async {
  try {
    final query = QueryBuilder<ParseObject>(ParseObject('exercise'));
    final response = await query.query();
    if (response.success) {
      return response.results?.map((a) {
        return ExerciseService(
          descanso: a.get('descanso') ?? '',
          dificuldad: a.get('dificultad') ?? '',
          linkImagen: a.get('linkImagen') ?? '',
          nombreEjercicio: a.get('nombreEjercicio') ?? '',
          nombreMusculo: a.get('nombreMusculo') ?? '',
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

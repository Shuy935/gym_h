import 'package:gym_h/utils/utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class RutinaService {
  final String? repeticiones;
  final String? series;
  final String? fecha;
  final String? objectIdMusculos;

  RutinaService({
    this.repeticiones,
    this.series,
    this.fecha,
    this.objectIdMusculos,
  });
}

Future<void> addRutina(
    List<String> ejerciciosSeleccionados, List<String> selectedDias) async {
  // final objeto = ParseObject('rutinas')..set(key, value);

  // try {
  //   await objeto.save();
  // Utils.showSusSnackBar('Se agrego la asistencia');
  // } catch (e) {
  //   Utils.showSnackBar(e.toString());
  // }
}

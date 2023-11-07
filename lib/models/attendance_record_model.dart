import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AsistenciaService {
  final String? firebaseUserId;
  final DateTime? fecha;
  final String? fullname;

  AsistenciaService({
    this.firebaseUserId,
    this.fecha,
    this.fullname,
  });

  Map<String, dynamic> toJson() => {
        "firebaseUserId": firebaseUserId,
        "fecha": fecha,
        "fullname": fullname,
      };
}

final currentUser = FirebaseAuth.instance.currentUser;

Future<void> addAsistencia(AsistenciaService asistenciaService) async {
  final objeto = ParseObject('Asistencia')
    ..set('firebaseUserId', currentUser?.uid)
    ..set('fecha', asistenciaService.fecha)
    ..set('fullname', asistenciaService.fullname);

  try {
    await objeto.save();
  } catch (e) {
    print(e);
  }
}

Future<List<AsistenciaService>> readAsistencias() async {
  try {
    final query = QueryBuilder<ParseObject>(ParseObject('Asistencia'))
      ..whereEqualTo('firebaseUserId', currentUser?.uid);
    final response = await query.query();

    if (response.success) {
      return response.results?.map((a) {
            return AsistenciaService(
              firebaseUserId: a.get('firebaseUserId'),
              fecha: a.get('fecha'),
              fullname: a.get('fullname'),
            );
          }).toList() ??
          [];
    } else {
      print(response.error?.message);
    }
  } catch (e) {
    print(e);
  }
  return [];
}

Future<void> updateAsistencia(AsistenciaService asistenciaService) async {
  final query = QueryBuilder<ParseObject>(ParseObject('Asistencia'))
    ..whereEqualTo('firebaseUserId', currentUser?.uid);

  final response = await query.query();

  if (response.success && response.results != null) {
    final objetoAActualizar = response.results!.first;

    objetoAActualizar.set('fecha', asistenciaService.fecha);
    objetoAActualizar.set('fullname', asistenciaService.fullname);

    final updateResponse = await objetoAActualizar.save();

    if (updateResponse.success) {
      print('Asistencia actualizada con éxito');
    } else {
      print(
          'Error al actualizar la asistencia: ${updateResponse.error.message}');
    }
  } else {
    print('No se encontró un objeto para actualizar.');
  }
}

import 'package:gym_h/models/users_model.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:intl/intl.dart';
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

Future<void> addAsistencia() async {
  String? a;
  DateTime now = DateTime.now();
  String formatDate = DateFormat('yyyy-MM-dd HH:mm').format(now);
  final userData = await readCompleteUser();
  if (userData != null && userData.isNotEmpty) {
    final user = userData[0]; // Suponemos que solo hay un usuario
    a = user.objectId!;
  }
  final objeto = ParseObject('asistencia')
    ..set('fecha', formatDate)
    ..set('usuarioID', ParseObject('users')..objectId = a);

  try {
    await objeto.save();
    Utils.showSusSnackBar('Se agrego la asistencia');
  } catch (e) {
    Utils.showSnackBar(e.toString());
  }
}

// Future<List<AsistenciaService>> readAsistencias() async {
//   String? a;
//   final userData = await readCompleteUser();
//   if (userData != null && userData.isNotEmpty) {
//     final user = userData[0]; // Suponemos que solo hay un usuario
//     a = user.objectId!;
//   }
//   try {
//     final query = QueryBuilder<ParseObject>(ParseObject('asistencia'))
//       ..whereEqualTo(
//           'objectId', (ParseObject('users')..objectId = a).toPointer())
//       ..orderByAscending('fullname');
//     final ParseResponse response = await query.query();
//     print(response.error);
//   } catch (e) {
//     Utils.showSnackBar(e.toString());
//   }
//   return [];
// }
Future<List<AsistenciaService>> readAsistencias() async {
  final currentUser = FirebaseAuth.instance.currentUser;
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
      Utils.showSnackBar(response.error?.message);
    }
  } catch (e) {
    Utils.showSnackBar(e.toString());
  }
  return [];
}

Future<void> updateAsistencia(AsistenciaService asistenciaService) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  final query = QueryBuilder<ParseObject>(ParseObject('Asistencia'))
    ..whereEqualTo('firebaseUserId', currentUser?.uid);

  final response = await query.query();

  if (response.success && response.results != null) {
    final objetoAActualizar = response.results!.first;

    objetoAActualizar.set('fecha', asistenciaService.fecha);
    objetoAActualizar.set('fullname', asistenciaService.fullname);

    final updateResponse = await objetoAActualizar.save();

    if (updateResponse.success) {
      Utils.showSusSnackBar('Asistencia actualizada con éxito');
    } else {
      Utils.showSnackBar(
          'Error al actualizar la asistencia: ${updateResponse.error.message}');
    }
  } else {
    Utils.showSnackBar('No se encontró un objeto para actualizar.');
  }
}

Future<void> deleteAsistencia(DateTime fecha, String email) async {
  final query = QueryBuilder<ParseObject>(ParseObject('Asistencia'))
    ..whereEqualTo('email', email)
    ..whereEqualTo('fecha', fecha.toUtc());

  final response = await query.query();

  if (response.success && response.results != null) {
    final objetoAEliminar = response.results!.first;
    final deleteResponse = await objetoAEliminar.delete();

    if (deleteResponse.success) {
      Utils.showSusSnackBar('Asistencia eliminada con éxito');
    } else {
      Utils.showSnackBar(
          'Error al eliminar la asistencia: ${deleteResponse.error.message}');
    }
  } else {
    Utils.showSnackBar('No se encontró un objeto para eliminar.');
  }
}

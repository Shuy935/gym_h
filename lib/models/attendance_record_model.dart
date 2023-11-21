import 'package:gym_h/models/users_model.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AsistenciaService {
  final String? objectId;
  final String? fecha;
  final String? fullname;

  AsistenciaService({
    this.objectId,
    this.fecha,
    this.fullname,
  });

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "fecha": fecha,
        "fullname": fullname,
      };
}

Future<void> addAsistencia() async {
  String? a;
  DateTime now = DateTime.now();
  String formatDate = DateFormat('yyyy-MM-dd').format(now);
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

Future<List<AsistenciaService>> readAsistencias() async {
  String? a;

  final userData = await readCompleteUser();
  if (userData != null && userData.isNotEmpty) {
    final user = userData[0]; // Suponemos que solo hay un usuario
    a = user.objectId!;
  }
  try {
    final query = QueryBuilder<ParseObject>(ParseObject('asistencia'))
      ..whereEqualTo('usuarioID',
          {'__type': 'Pointer', 'className': 'users', 'objectId': a})
      ..includeObject(['usuarioID']);
    //..orderByAscending('fullname');

    final ParseResponse response = await query.query();
    //print(response.results);
    if (response.success) {
      return response.results?.map((a) {
            return AsistenciaService(
              objectId: a.get('objectId'),
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

Future<List<AsistenciaService>> readAsistenciasUsuario(String objectId) async {
  String a = objectId;

  try {
    final query = QueryBuilder<ParseObject>(ParseObject('asistencia'))
      ..whereEqualTo('usuarioID',
          {'__type': 'Pointer', 'className': 'users', 'objectId': a})
      ..includeObject(['usuarioID']);
    //..orderByAscending('fullname');

    final ParseResponse response = await query.query();
    if (response.success) {
      return response.results?.map((a) {
            return AsistenciaService(
              objectId: a.get('objectId'),
              fecha: a.get('fecha'),
              fullname: a.get('usuarioID')?.get('fullname'),
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


Future<void> updateAsistencia(String originalFecha, AsistenciaService asistenciaService,String fullname) async {
  final objectId = await getObjectIdByFullname(fullname);
  final query = QueryBuilder<ParseObject>(ParseObject('asistencia'))
    ..whereEqualTo('usuarioID', {
      '__type': 'Pointer',
      'className': 'users',
      'objectId': objectId,
    })
    ..whereEqualTo('fecha', originalFecha)
    ..includeObject(['usuarioID']);

  final response = await query.query();

  if (response.success && response.results != null) {
    final objetoAActualizar = response.results!.first;

    objetoAActualizar.set('fecha', asistenciaService.fecha);

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


Future<void> deleteAsistencia(String fecha, String fullname) async {
  final objectId = await getObjectIdByFullname(fullname);
  final query = QueryBuilder<ParseObject>(ParseObject('asistencia'))
    ..whereEqualTo('fecha',fecha)
    ..whereEqualTo('usuarioID',
          {'__type': 'Pointer', 'className': 'users', 'objectId': objectId})
          ..includeObject(['usuarioID']);
     
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

Future<void> addAsistenciaUsuario(String fullname) async {
  DateTime now = DateTime.now();
  String formatDate = DateFormat('yyyy-MM-dd').format(now);

  final objectId = await getObjectIdByFullname(fullname);

  if (objectId != null) {
    final objeto = ParseObject('asistencia')
      ..set('fecha', formatDate)
      ..set('usuarioID', ParseObject('users')..objectId = objectId);

    try {
      await objeto.save();
      Utils.showSusSnackBar('Se agregó la asistencia');
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }
}
Future<void> addAsistenciaUsuarioFecha(String fullname, String fecha) async {
  final objectId = await getObjectIdByFullname(fullname);

  if (objectId != null) {
    final objeto = ParseObject('asistencia')
      ..set('fecha', fecha)
      ..set('usuarioID', ParseObject('users')..objectId = objectId);

    try {
      await objeto.save();
      Utils.showSusSnackBar('Se agregó la asistencia');
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }
}

Future<List<AsistenciaService>> readAsistenciasGeneral() async {
  try {
    final query = QueryBuilder<ParseObject>(ParseObject('asistencia'))
      ..includeObject(['usuarioID']);
    //..orderByAscending('fullname');

    final ParseResponse response = await query.query();
    if (response.success) {
      return response.results?.map((a) {
            return AsistenciaService(
              objectId: a.get('objectId'),
              fecha: a.get('fecha'),
              fullname: a.get('usuarioID')?.get('fullname'),
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

// Future<List<ParseObject>?> getAllAsistencia() async {
//   final ParseResponse result = await ParseObject('asistencia').getAll();
//   if (result.success && result.results != null) {
//     print(result.results);
//     return result.results?.cast<ParseObject>();
//   } else {
//     throw Exception('Error al obtener datos de asistencia');
//   }
// }

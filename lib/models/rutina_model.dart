import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class RutinaService {
  final String? repeticiones;
  final String? series;
  final List<dynamic>? fecha;
  final String? objectIdExercise;
  final String? userId;

  RutinaService({
    this.repeticiones,
    this.series,
    this.fecha,
    this.objectIdExercise,
    this.userId,
  });
  @override
  String toString() {
    // Devuelve una cadena que representa la información de la instancia
    return '{objectIdExercise: $objectIdExercise, repeticiones: $repeticiones, series: $series, fecha: $fecha, userId: $userId}';
  }
}

Future<void> addRutina(
    List<String> ejerciciosSeleccionados, List<String> selectedDias) async {
  final currentUser = FirebaseAuth.instance.currentUser;

  // Dividir la lista en conjuntos de tres
  for (int i = 0; i < ejerciciosSeleccionados.length; i += 3) {
    // Obtener el conjunto de tres elementos
    List<String> conjunto = ejerciciosSeleccionados.sublist(i, i + 3);

    final objeto = ParseObject('rutinas')
      ..set('repeticiones', conjunto[2])
      ..set('series', conjunto[1])
      ..set('fecha', selectedDias)
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
    List<String> selectedDias, String username) async {
  // TODO: hacer esto ahorita que es la busqueda de usuario por nombre xs
  final currentUser = FirebaseAuth.instance.currentUser;

  // Dividir la lista en conjuntos de tres
  for (int i = 0; i < ejerciciosSeleccionados.length; i += 3) {
    // Obtener el conjunto de tres elementos
    List<String> conjunto = ejerciciosSeleccionados.sublist(i, i + 3);

    final objeto = ParseObject('rutinas')
      ..set('repeticiones', conjunto[2])
      ..set('series', conjunto[1])
      ..set('fecha', selectedDias)
      ..set('userId', currentUser?.uid)
      ..set(
          'objetoIdExercise', ParseObject('exercise')..objectId = conjunto[0]);

    try {
      await objeto.save();
      Utils.showSusSnackBar('Se agrego la rutina');
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }
}

Future<List<RutinaService>> readRutina() async {
  // final a = await readRutina();

  try {
    final query = QueryBuilder<ParseObject>(ParseObject('rutinas'))
      ..whereEqualTo('objectIdExercise', {
        '__type': 'Pointer',
        'className': 'exercise',
        // 'objectId': a![0].objectIdExercise
      })
      ..includeObject(['objectIdExercise']);

    final ParseResponse response = await query.query();
    if (response.success) {
      return response.results?.map((a) {
            return RutinaService(
              objectIdExercise:
                  a.get<ParseObject>('objectIdExercise')?.objectId,
              fecha: a.get('fecha'),
              repeticiones: a.get('repeticiones'),
              series: a.get('series'),
              userId: a.get('userId'),
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

// Future<List<RutinaService>> readAsistencias() async {
//   String? a;

//   final userData = await readCompleteUser();
//   if (userData != null && userData.isNotEmpty) {
//     final user = userData[0]; // Suponemos que solo hay un usuario
//     a = user.objectId!;
//   }
//   try {
//     final query = QueryBuilder<ParseObject>(ParseObject('asistencia'))
//       ..whereEqualTo('usuarioID',
//           {'__type': 'Pointer', 'className': 'users', 'objectId': a})
//       ..includeObject(['usuarioID']);
//     //..orderByAscending('fullname');

//     final ParseResponse response = await query.query();
//     //print(response.results);
//     if (response.success) {
//       return response.results?.map((a) {
//             return RutinaService(
//               objectIdExercise: a.get('objectIdExercise'),
//               fecha: a.get('fecha'),
//               repeticiones: a.get('repeticiones'),
//               series: a.get('series'),
//               userId: a.get('userId'),
//             );
//           }).toList() ??
//           [];
//     } else {
//       Utils.showSnackBar(response.error?.message);
//     }
//   } catch (e) {
//     Utils.showSnackBar(e.toString());
//   }
//   return [];
// }
Future<List<RutinaService>?> readRutinaUsuario() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  try {
    final query = QueryBuilder<ParseObject>(ParseObject('rutinas'))
      ..whereEqualTo('userId', currentUser?.uid);
    final response = await query.query();
    if (response.success) {
      return response.results?.map((a) {
        return RutinaService(
          fecha: a.get('fecha'),
          repeticiones: a.get('repeticiones'),
          series: a.get('series'),
          userId: a.get('userId'),
          objectIdExercise: a.get<ParseObject>('objectIdExercise')?.objectId,
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

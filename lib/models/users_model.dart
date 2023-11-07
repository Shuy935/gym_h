import 'package:gym_h/utils/utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final String? email;
  final String? fullname;
  final String? sex;
  final String? age;
  final String? weight;
  final String? height;
  final bool? isAdm;

  UserService({
    this.email,
    this.fullname,
    this.sex,
    this.age,
    this.weight,
    this.height,
    this.isAdm,
  });
  Map<String, dynamic> toJson() => {
        "email": email,
        "fullname": fullname,
        "sex": sex,
        "age": age,
        "weight": weight,
        "height": height,
      };
}

final currentUser = FirebaseAuth.instance.currentUser;
ParseObject mapModel(UserService userService) {
  final objeto = ParseObject('users')
    ..set('firebaseUserId', currentUser?.uid)
    ..set('fullname', userService.fullname)
    ..set('email', userService.email)
    ..set('sex', userService.sex)
    ..set('age', userService.age)
    ..set('weight', userService.weight)
    ..set('height', userService.height)
    ..set('isAdm', userService.isAdm);
  return objeto;
}

addUser(UserService userService) async {
  final object = mapModel(userService);
  try {
    await object.save();
  } catch (e) {
    Utils.showSnackBar(e.toString());
  }
}

Future<List<UserService>?> readUser() async {
  try {
    final query = QueryBuilder<ParseObject>(ParseObject('users'))
      ..whereEqualTo('firebaseUserId', currentUser?.uid);
    final response = await query.query();
    if (response.success) {
      return response.results?.map((a) {
        return UserService(
          fullname: a.get('fullname') ?? '',
          age: a.get('age') ?? '',
          sex: a.get('sex') ?? '',
          weight: a.get('weight') ?? '',
          height: a.get('height') ?? '',
          isAdm: a.get('isAdm') ?? '',
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

Future<void> updateUser(UserService userService) async {
  final query = QueryBuilder<ParseObject>(ParseObject('users'))
    ..whereEqualTo('firebaseUserId', currentUser?.uid);

  final response = await query.query();

  if (response.success && response.results != null) {
    // Supongamos que solo se espera un resultado, si hay más, debes manejarlo adecuadamente
    final objetoAActualizar = response.results?.first;

    // Modifica los campos que desees actualizar
    objetoAActualizar.set('fullname', userService.fullname);
    objetoAActualizar.set('age', userService.age);
    objetoAActualizar.set('sex', userService.sex);
    objetoAActualizar.set('weight', userService.weight);
    objetoAActualizar.set('height', userService.height);

    // Realiza la operación de actualización
    final updateResponse = await objetoAActualizar.save();

    if (updateResponse.success) {
      Utils.showSusSnackBar('Perfil actualizado con éxito');
    } else {
      Utils.showSnackBar(
          'Error al actualizar el perfil: ${updateResponse.error.message}');
    }
  } else {
    Utils.showSnackBar('Error: No se encontró un perfil para actualizar.');
  }
}

Future<List<Map<String, dynamic>>?> readUsers() async {
  try {
    final query = QueryBuilder<ParseObject>(ParseObject('users'))
      ..whereEqualTo('isAdm', false); // Filtrar por isAdm igual a false
    final response = await query.query();
    if (response.success) {
      final userList = response.results?.map((a) {
        final fullname = a.get<String>('fullname') ?? '';
        final email = a.get<String>('email');
        final isAdm = a.get<bool>('isAdm');
        return {
          'email': email,
          'fullname': fullname,
          'isAdm': isAdm, // Establecer isAdm como false
        };
      }).toList();
      print(userList);
      return userList;
    } else {
      print(response.error?.message);
    }
  } catch (e) {
    print(e);
  }
  return null;
}

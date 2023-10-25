import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_h/models/response.dart';

class UserService {
  final String fullname;
  final String sex;
  final String age;
  final String weight;
  final String height;
  final String id;

  UserService({
    required this.fullname,
    required this.sex,
    required this.age,
    required this.weight,
    required this.height,
    required this.id,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = fullname;
    data['sex'] = sex;
    data['age'] = age;
    data['weight'] = weight;
    data['height'] = height;
    data['id'] = id;

    return data;
  }
}

final db = FirebaseFirestore.instance;

userProfileCreate({fullname, sex, age, weight, height}) async {
  try {
    final docRef = db.collection('users').doc();
    UserService usr = UserService(
        fullname: fullname,
        sex: sex,
        age: age,
        weight: weight,
        height: height,
        id: docRef.id);
    await docRef
        .set(usr.toJson())
        .then((value) => print('ahhhhh'), onError: (e) => print(e));
  } catch (e) {
    print(e);
  }
}

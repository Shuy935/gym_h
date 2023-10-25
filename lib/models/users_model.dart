import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:gym_h/models/response.dart';

class UserService {
  final String fullname;
  final String sex;
  final String age;
  final String weight;
  final String height;
  // final String id;

  UserService({
    required this.fullname,
    required this.sex,
    required this.age,
    required this.weight,
    required this.height,
    // required this.id,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = fullname;
    data['sex'] = sex;
    data['age'] = age;
    data['weight'] = weight;
    data['height'] = height;
    // data['id'] = id;

    return data;
  }
}

userProfileCreate({fullname, sex, age, weight, height}) async {
  try {
    DatabaseReference db = FirebaseDatabase.instance.ref().child('users');
    await db.push().set({
      "fullname": fullname,
      "sex": sex,
      "age": age,
      "weight": weight,
      "height": height
    });
  } catch (e) {
    print(e);
  }
}

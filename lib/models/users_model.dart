import 'package:firebase_database/firebase_database.dart';

class UserService {
  final String username;
  final String email;
  final String? fullname;
  final String? sex;
  final String? age;
  final String? weight;
  final String? height;
  final bool? isAdm;

  UserService({
    required this.username,
    required this.email,
    this.fullname,
    this.sex,
    this.age,
    this.weight,
    this.height,
    this.isAdm,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = username;
    data['email'] = email;
    data['fullname'] = fullname;
    data['sex'] = sex;
    data['age'] = age;
    data['weight'] = weight;
    data['height'] = height;
    data['isAdm'] = isAdm;
    return data;
  }
}

DatabaseReference db = FirebaseDatabase.instance.ref().child('users');
userProfileCreate({username, email}) async {
  try {
    await db.push().set({
      "username": username,
      "email": email,
      "isAdm": false,
    });
  } catch (e) {
    print(e);
  }
}

userProfileGet() async {
  try {} catch (e) {}
}

userProfileUpdate({fullname, sex, age, weight, height}) async {
  try {
    await db.push().update({
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

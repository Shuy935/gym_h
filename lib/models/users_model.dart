import 'package:firebase_database/firebase_database.dart';

class UserService {
  final String username;
  final String email;
  final String? fullname;
  final String? sex;
  final String? age;
  final String? weight;
  final String? height;

  UserService({
    required this.username,
    required this.email,
    this.fullname,
    this.sex,
    this.age,
    this.weight,
    this.height,
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

    return data;
  }
}

userProfileCreate({username, email}) async {
  try {
    DatabaseReference db = FirebaseDatabase.instance.ref().child('users');
    await db.push().set({
      "username": username,
      "email": email,
    });
  } catch (e) {
    print(e);
  }
}

userProfileUpdate({fullname, sex, age, weight, height}) async {
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

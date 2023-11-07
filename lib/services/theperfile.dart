import 'package:flutter/material.dart';
import 'package:gym_h/models/users_model.dart';

class TheProfile extends StatelessWidget {
  const TheProfile({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Profile(),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _ageController = TextEditingController();
  final _sexController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            TextFormField(
              controller: _fullnameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Full Name'),
              validator: (value) {
                if (value!.isEmpty || value.length < 5) {
                  return 'Please enter a valid full name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _ageController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty ||
                    int.parse(value.toString()) < 15 ||
                    int.parse(value.toString()) > 70) {
                  return 'Please enter a valid age';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _heightController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Height (cm)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty ||
                    int.parse(value.toString()) < 100 ||
                    int.parse(value.toString()) > 300) {
                  return 'Please enter a valid height';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _weightController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty ||
                    int.parse(value.toString()) < 30 ||
                    int.parse(value.toString()) > 250) {
                  return 'Please enter a valid weight';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _sexController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Sex'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a valid sex';
                }
                return null;
              },
            ),
            const SizedBox(height: 50),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Theme.of(context).primaryColor,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    UserService userService = UserService(
                      fullname: _fullnameController.text,
                      age: _ageController.text,
                      sex: _sexController.text,
                      weight: _weightController.text,
                      height: _heightController.text,
                    );
                    await updateUser(userService); // Call the method to update the user's data in the database
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _ageController.dispose();
    _fullnameController.dispose();
    _heightController.dispose();
    _sexController.dispose();
    _weightController.dispose();
  }
}
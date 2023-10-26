import 'package:flutter/material.dart';
import 'package:gym_h/models/users_model.dart';

class TheProfile extends StatelessWidget {
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
  const Profile({super.key});

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
            TextFormField(
              controller: _fullnameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Nombre Completo'),
              validator: (value) {
                if (value!.isEmpty || value.length < 5) {
                  return 'Porfavor de poner un nombre completo';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _ageController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Edad'),
              keyboardType: TextInputType.number,
              maxLength: 2,
              validator: (value) {
                if (value!.isEmpty ||
                    int.parse(value.toString()) < 15 ||
                    int.parse(value.toString()) > 70) {
                  return 'Porfavor de poner un edad';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _heightController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Altura (cm)'),
              keyboardType: TextInputType.number,
              maxLength: 3,
              validator: (value) {
                if (value!.isEmpty ||
                    int.parse(value.toString()) < 100 ||
                    int.parse(value.toString()) > 300) {
                  return 'Porfavor de poner un altura';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _weightController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Peso (kg)'),
              keyboardType: TextInputType.number,
              maxLength: 3,
              validator: (value) {
                if (value!.isEmpty || int.parse(value.toString()) < 30) {
                  return 'Porfavor de poner un peso';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _sexController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Sexo'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Porfavor de poner un sexo correcto';
                }
                return null;
              },
            ),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Theme.of(context).primaryColor,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await userProfileCreate(
                      fullname: _fullnameController.text,
                      age: _ageController.text,
                      sex: _sexController.text,
                      weight: _weightController.text,
                      height: _heightController.text,
                    );
                  }
                },
                child: Text(
                  "Save",
                  style: TextStyle(color: Theme.of(context).primaryColorLight),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

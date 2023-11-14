import 'package:flutter/material.dart';
import 'package:gym_h/models/users_model.dart';

class TheProfile extends StatelessWidget {
  const TheProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Profile(),
    );
  }
}

String? _sexController;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  bool _boolController = false;
  @override
  void initState() {
    super.initState();

    // Llama a la función para recuperar los datos del usuario
    getUserData();
  }

  Future<void> getUserData() async {
    final userData = await readCompleteUser();
    if (userData != null && userData.isNotEmpty) {
      final user = userData[0]; // Suponemos que solo hay un usuario
      setState(() {
        _fullnameController.text = user.fullname!;
        _ageController.text = user.age!;
        _sexController = user.sex!;
        _weightController.text = user.weight!;
        _heightController.text = user.height!;
      });
    }
    if (_fullnameController.text.isNotEmpty) {
      _boolController = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            TextFormField(
              readOnly: _boolController,
              controller: _fullnameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Nombre Completo'),
              validator: (value) {
                if (value!.isEmpty || value.length < 5) {
                  return 'Porfavor de poner un nombre completo correcto';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _ageController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Edad'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty ||
                    int.parse(value.toString()) < 15 ||
                    int.parse(value.toString()) > 70) {
                  return 'Porfavor de poner una edad correcta';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _heightController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Altura (cm)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty ||
                    int.parse(value.toString()) < 100 ||
                    int.parse(value.toString()) > 300) {
                  return 'Porfavor de poner una altura correcta';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _weightController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Peso (kg)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty ||
                    int.parse(value.toString()) < 30 ||
                    int.parse(value.toString()) > 250) {
                  return 'Porfavor de poner un peso correcto';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const DropdownMenuExample(),
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
                      sex: _sexController,
                      weight: _weightController.text,
                      height: _heightController.text,
                    );
                    await updateUser(userService);
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

  @override
  void dispose() {
    super.dispose();
    _ageController.dispose();
    _fullnameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
  }
}

/// Flutter code sample for [DropdownMenu].

const List<String> list = <String>[
  'Masculino',
  'Femenino',
  'Otros 39 tipos de gays'
];

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: _sexController ?? list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          _sexController = value ?? '';
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}

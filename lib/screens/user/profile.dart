import 'package:flutter/material.dart';
import 'package:gym_h/darkmode/theme_provider.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:provider/provider.dart';

class TheProfile extends StatelessWidget {
  const TheProfile({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                themeProvider.appBarColor1,
                themeProvider.appBarColor2,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          ),
        ),
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
    final themeProvider = Provider.of<ThemeProvider>(context);
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
                  return 'Ingresa un nombre completo válido';
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
                  return 'Ingresa una edad válida';
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
                  return 'Ingresa una altura válida';
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
                  return 'Ingresa un peso válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 35),
            const DropdownMenuExample(),
            const SizedBox(height: 80),
            Material(
              elevation: 0.0,
              borderRadius: BorderRadius.circular(0.0),
              color: Colors.transparent,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
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
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                          themeProvider.buttonColor1,
                          themeProvider.buttonColor2,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20.0),  // Ajusta el radio de la esquina según tus necesidades
                  ),
                  
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 18, color: themeProvider.iconsColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
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
  'Prefiero no responder'
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

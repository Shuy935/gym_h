import 'package:flutter/material.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Profile Page Test', (WidgetTester tester) async {
  // Build our app and trigger a frame.
  await tester.pumpWidget(const MaterialApp(
    home: TheProfile(),
  ));

  // Verify that the Profile Page is displayed.
  expect(find.text('Profile'), findsOneWidget);

  // Add your other tests here.

});
}
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
              decoration: const InputDecoration(
                labelText: 'Nombre Completo',
              ),
              validator: (value) {
                if (value!.isEmpty || value.length < 5) {
                  return 'Por favor, ingrese un nombre completo válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _ageController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Edad',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty ||
                    int.parse(value.toString()) < 15 ||
                    int.parse(value.toString()) > 70) {
                  return 'Por favor, ingrese una edad válida';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _heightController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Altura (cm)',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty ||
                    int.parse(value.toString()) < 100 ||
                    int.parse(value.toString()) > 300) {
                  return 'Por favor, ingrese una altura válida';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _weightController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty ||
                    int.parse(value.toString()) < 30 ||
                    int.parse(value.toString()) > 250) {
                  return 'Por favor, ingrese un peso válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _sexController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Sexo',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, ingrese un sexo válido';
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
                    await updateUser(userService);
                  }
                },
                child: Text(
                  "Guardar",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
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
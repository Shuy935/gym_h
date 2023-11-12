import 'package:flutter/material.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:gym_h/widget/interfaces/usuario/registrosHU.dart';

class ListaU extends StatefulWidget {
  const ListaU({Key? key}) : super(key: key);

  @override
  State<ListaU> createState() => _ListaUState();
}

class _ListaUState extends State<ListaU> {
  //get del usuario actual

  String? usuario;
  @override
  void initState() {
    super.initState();
    // Obtén el nombre del usuario antes de construir el cajón de navegación
    getUserName();
  }

  Future<void> getUserName() async {
    final userData = await readCompleteUser();
    if (userData != null && userData.isNotEmpty) {
      final user = userData[0]; // Suponemos que solo hay un usuario
      setState(() => usuario = user.fullname!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(height: 10),
          Text(
            'Usuario a registrar:\n${usuario ?? 'usuario'}',
            style: const TextStyle(fontSize: 25),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              minimumSize: const Size.fromHeight(50),
            ),
            icon: const Icon(Icons.app_registration, size: 32),
            label: const Text(
              'Registrar',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () => RegistroHU()
            //aqui ira el registro de asistencia del usuario actual
            ,
          ),
        ],
      ),
    );
  }
}

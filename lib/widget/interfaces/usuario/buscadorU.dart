import 'package:flutter/material.dart';
import 'package:gym_h/darkmode/theme_provider.dart';
import 'package:gym_h/models/attendance_record_model.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:provider/provider.dart';

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
    //readAsistencias();
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(height: 45),
          const Text(
            'Nombre de usuario:',
            style: TextStyle(fontSize: 16),
          ),
          Container(height: 10),
          Text(
            usuario ?? 'usuario',
            style: const TextStyle(fontSize: 20),
          ),
          Container(height: 45),
          Container(
            width: 360,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themeProvider.buttonColor1,
                  themeProvider.buttonColor2,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              icon: const Icon(Icons.app_registration, size: 32),
              label: const Text(
                'Registrar Asistencia',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                addAsistencia();
              },
              //aqui ira el registro de asistencia del usuario actual
            ),
          ),
        ],
      ),
    );
  }
}

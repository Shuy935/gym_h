import 'package:flutter/material.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:gym_h/widget/interfaces/Widgets.dart';
import 'package:gym_h/widget/interfaces/usuario/rutina.dart';
import 'package:gym_h/widget/interfaces/usuario/seleccion_diasU.dart';
import 'package:gym_h/widget/interfaces/widgets.dart';

class TabBarH extends StatefulWidget {
  const TabBarH({Key? key}) : super(key: key);

  @override
  State<TabBarH> createState() => _TabBarH();
}

class _TabBarH extends State<TabBarH> {
  bool? rol;
  @override
  void initState() {
    super.initState();
    // Obtén el nombre del usuario antes de construir el cajón de navegación
    getUserRole();
  }

  Future<void> getUserRole() async {
    final userData = await readCompleteUser();
    if (userData != null && userData.isNotEmpty) {
      final user = userData[0]; // Suponemos que solo hay un usuario
      setState(() => rol = user.isAdm!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (rol != true) {
      //if (rol == true) {
      final List<Widget> tabs0 = [
        const Tab(
            text: 'Asignación de rutina'), //Selección de rutina para un usuario
        const Tab(text: 'Asistencia'),
        const Tab(text: 'Historial'),
      ];

      return DefaultTabController(
        length: tabs0.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Inicio'),
            bottom: TabBar(tabs: tabs0),
          ),
          body: TabBarView(
            children: [
              Center(child: Lista_Clientes()),
              Center(child: Lista()),
              Center(child: Text('Historial')),
            ],
          ),
          drawer: const DrawerProfile(),
        ),
      );
    } else {
      final List<Widget> tabs = [
        const Tab(text: 'Rutina'),
        const Tab(
            text: 'Seleccion de Rutina'), //Selección de rutina por un usuario
        const Tab(text: 'Asistencia'),
        const Tab(text: 'Historial'),
      ];

      return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Inicio'),
            bottom: TabBar(tabs: tabs),
          ),
          body: TabBarView(
            children: [
              Center(child: Rutinas()),
              Center(child: DiasScrnU()), //Selección de rutina por un usuario
              Center(child: ListaU()),
              Center(child: Text('Historial')),
            ],
          ),
          drawer: const DrawerProfile(),
        ),
      );
    }
  }
}

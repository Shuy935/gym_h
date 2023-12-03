import 'package:flutter/material.dart';
import 'package:gym_h/darkmode/theme_provider.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:gym_h/widget/interfaces/widgets.dart';
import 'package:provider/provider.dart';

class TabBarH extends StatefulWidget {
  const TabBarH({super.key});

  @override
  State<TabBarH> createState() => _TabBarH();
}

class _TabBarH extends State<TabBarH> {
  bool? rol;
  late ThemeProvider themeProvider;

  @override
  void initState() {
    super.initState();
    // Obtén el nombre del usuario antes de construir el cajón de navegación
    getUserRole();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
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
      ];

      return DefaultTabController(
        length: tabs0.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(110.0),
            child: Appbarcolors(tabs0),
          ),
          body: const TabBarView(
            children: [
              Center(child: ListaClientes()),
              Center(child: Lista()),
            ],
          ),
          drawer: const DrawerProfile(),
        ),
      );
    } else {
      final List<Widget> tabs = [
        const Tab(text: 'Rutina'),
        const Tab(
            text: 'Selección de Rutina'), //Selección de rutina por un usuario
        const Tab(text: 'Asistencia'),
        const Tab(text: 'Historial'),
      ];

      return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(110.0),
            child: Appbarcolors(tabs),
          ),
          body: const TabBarView(
            children: [
              Center(child: Rutinas()),
              Center(child: DiasScrnU()), //Selección de rutina por un usuario
              Center(child: ListaU()),
              Center(child: Historial()),
            ],
          ),
          drawer: const DrawerProfile(),
        ),
      );
    }
  }
}

class Appbarcolors extends StatelessWidget {
  final List<Widget> tabs;
  const Appbarcolors(this.tabs, {super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AppBar(
      title: const Text('Inicio'),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            themeProvider.appBarColor1,
            themeProvider.appBarColor2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
      ),
      bottom: TabBar(
        tabs: tabs,
        indicator: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              themeProvider.appBarColor1,
              themeProvider.appBarColor2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}

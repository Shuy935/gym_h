import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/Widgets.dart';

class TabBarH extends StatelessWidget {
  const TabBarH({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      const Tab(text: 'Rutina'),
      const Tab(text: 'Musculos'),
      const Tab(text: 'Lista'),
      const Tab(text: 'Historial'),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inicio'),
          bottom: TabBar(tabs: tabs),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Rutina de hoy:')),
            //se tiene que eliminar el const despues
            Center(child: MuscleScrn()),
            Center(child: ListaU()),
            Center(child: Text('Historial')),
          ],
        ),
        drawer: const DrawerProfile(),
      ),
    );
  }
}

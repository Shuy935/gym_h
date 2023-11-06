import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/Widgets.dart';

class TabBarH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> _tabs = [
      const Tab(text: 'Rutina'),
      const Tab(text: 'Musculos'),
      const Tab(text: 'Lista'),
      const Tab(text: 'Historial'),
    ];

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inicio'),
          bottom: TabBar(tabs: _tabs),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('Rutina de hoy:')),
            Center(child: Musculos()),
            Center(child: ListaU()),
            const Center(child: Text('Historial')),
          ],
        ),
        drawer: DrawerProfile(),
      ),
    );
  }
}

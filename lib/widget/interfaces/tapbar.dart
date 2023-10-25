import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/widgets.dart';

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
            const Center(child: Text('Rutina de hoy:')),
            const Center(child: Text('Musculos')),
            Center(child: ListaU()),
            const Center(child: Text('Historial')),
          ],
        ),
        floatingActionButton: ProfileButtom(),
      ),
    );
  }
}

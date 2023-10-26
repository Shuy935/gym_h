import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/WidgetsI.dart';

class TabBarH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final List<Widget> _tabs = [
      Tab(text: 'Rutina'),
      Tab(text: 'Musculos'),
      Tab(text: 'Lista'),
      Tab(text: 'Historial'),
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
            Center(child: Rutinas()),
            Center(child: Musculos()),
            Center(child: ListaU()),
            Center(child: Text('Historial')),
          ],
        ),
      ),
    );
  }
}

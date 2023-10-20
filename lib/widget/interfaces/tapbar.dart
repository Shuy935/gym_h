import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/Buscador.dart';

class TabBarH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> _tabs = [
      Tab(text: 'Rutina'),
      Tab(text: 'Musculos'),
      Tab(text: 'Lista'),
      Tab(text: 'Historial'),
    ];

    // final PreferredSizeWidget appBar = PreferredSize(
    //   preferredSize: Size.fromHeight(100),
    //   child: Container(
    //     color: Colors.blue,
    //     child: TabBar(
    //       tabs: _tabs,
    //     ),
    //   ),
    // );

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
            Center(child: Text('Musculos')),
            Center(child: ListaU()),
            Center(child: Text('Historial')),
          ],
        ),
      ),
    );
  }
}

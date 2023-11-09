import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/ArchivoParaMeterEjerciciosMamalones.dart';
import 'package:gym_h/widget/interfaces/Buscador.dart';
import 'package:gym_h/widget/interfaces/BuscadorU.dart';
import 'package:gym_h/widget/interfaces/Ejercicios.dart';
import 'package:gym_h/widget/interfaces/muscles.dart';

class TabBarH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String rol = 'admin';
    if (rol == 'admin') {
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
              Center(child: Text('ASDASD')),
              Center(child: MuscleScrn()),
              Center(child: Lista()),
              Center(child: EjerciciosAdd()),
            ],
          ),
          floatingActionButton: ButtonBar(),
        ),
      );
    } else {
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
              Center(child: MuscleScrn()),
              Center(child: ListaU()),
              const Center(child: Text('Historial')),
            ],
          ),
          floatingActionButton: ButtonBar(),
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';

class Buscador_uwu extends StatefulWidget {
  const Buscador_uwu({super.key});

  @override
  State<Buscador_uwu> createState() => _Buscador_uwuState();
}

class _Buscador_uwuState extends State<Buscador_uwu> {
  String searching = '';
  List<String> filteredEjercicio = [];
  final List<String> allEjercicios = [
    //aquí la lista de ejercicios
    'Sentadilla',
    'ejercicio1',
    'ej2',
    'ej3'
  ];
  @override
  Widget build(BuildContext context) {
    filteredEjercicio = allEjercicios;
    return buildSearchTextField();
  }

  Widget buildSearchTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: handleSearch,
        decoration: InputDecoration(
          labelText: 'Buscar Ejercicio',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  void handleSearch(String value) {
    setState(() {
      searching = value;
      filteredEjercicio = allEjercicios
          .where((ejercicio) =>
              ejercicio.toLowerCase().contains(searching.toLowerCase()))
          .toList();
    });
  }
}

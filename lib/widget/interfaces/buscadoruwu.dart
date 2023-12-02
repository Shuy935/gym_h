import 'package:flutter/material.dart';

class Buscadoruwu extends StatefulWidget {
  const Buscadoruwu({super.key});

  @override
  State<Buscadoruwu> createState() => _BuscadoruwuState();
}

class _BuscadoruwuState extends State<Buscadoruwu> {
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
          prefixIcon: const Icon(Icons.search),
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

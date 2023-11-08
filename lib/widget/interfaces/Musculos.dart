import 'package:flutter/material.dart';
import 'package:gym_h/main.dart';
import 'package:gym_h/widget/interfaces/Ejercicios.dart';

const List<String> list = <String>[
  'Bíceps',
  'Tríceps',
  'Hombro',
  'Espalda',
  'Pecho',
  'Abdomen',
  'Glúteo',
  'Cuádriceps',
  'Femoral',
  'Pantorrilla',
];

class Musculos extends StatelessWidget {
  const Musculos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: MusculosN(),
    );
  }
}

class MusculosN extends StatefulWidget {
  const MusculosN({super.key});

  @override
  State<MusculosN> createState() => _MusculosNState();
}

class _MusculosNState extends State<MusculosN> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            alignment: Alignment.topCenter,
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              underline: Container(
                height: 2,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              onChanged: (String? value) {
                navigatorKey.currentState!.push(
                  MaterialPageRoute(
                    builder: (context) => Ejercicios(),
                  ),
                );
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

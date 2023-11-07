import 'package:flutter/material.dart';

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
  'Pantorrilla'
];

void main() => runApp(const Musculos());

class Musculos extends StatelessWidget {
  const Musculos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Musculos')),
        body: const Center(
          child: MusculosN(),
        ),
      ),
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
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // ejercicios
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

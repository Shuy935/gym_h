import 'package:flutter/material.dart';

class Musculos extends StatefulWidget {
  const Musculos({super.key});

  @override
  State<Musculos> createState() => _MusculosState();
}

List<String> rutinaActual = [];

class _MusculosState extends State<Musculos> {
  final List<String> musculos = [
    //get de musculos
    "Bíceps",
    "Tríceps",
    "Hombro",
    "Espalda",
    "Pecho",
    "Abdomen",
    "Glúteo",
    "Cuádriceps",
    "Femoral",
    "Pantorrilla",
  ];

  final Map<String, List<String>> ejerciciosPorMusculo = {
    //get de ejercicios
    "Bíceps": ["Curl de bíceps", "Martillo", "Flexiones de brazos"],
    "Tríceps": ["Press de tríceps", "Fondos en paralelas", "Patada de tríceps"],
    "Hombro": [
      "Press militar",
      "Elevaciones laterales",
      "Elevaciones frontales"
    ],
    "Espalda": ["Pull-ups", "Dominadas", "Peso muerto"],
    "Pecho": ["Press de banca", "Flexiones de pecho", "Pull-over"],
    "Abdomen": ["Plancha", "Crunches", "Elevación de piernas"],
    "Glúteo": ["Sentadillas", "Prensa de piernas", "Zancadas"],
    "Cuádriceps": [
      "Sentadillas",
      "Extensiones de cuádriceps",
      "Prensa de piernas"
    ],
    "Femoral": [
      "Prensa femoral",
      "Flexión de cadera",
      "Elevación de piernas tumbado"
    ],
    "Pantorrilla": [
      "Elevación de talones",
      "Sentadillas con salto",
      "Prensa de pantorrillas"
    ],
  };
  final int maxEjerciciosPorMusculo = 4;
  final int maxMusculosSeleccionados = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutina'),
      ),
      body: ListView.builder(
        itemCount: musculos.length,
        itemBuilder: (context, index) {
          final musculo = musculos[index];
          return ListTile(
            title: Text(musculo),
            onTap: () {
              if (rutinaActual.length >= maxMusculosSeleccionados) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Ya has seleccionado el máximo de músculos."),
                  ),
                );
              } else {
                seleccionarMusculo(musculo);
              }
            },
          );
        },
      ),
    );
  }

  void seleccionarMusculo(String musculo) {
    if (rutinaActual.where((ejercicio) => ejercicio == musculo).length >=
        maxEjerciciosPorMusculo) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Ya has seleccionado el máximo de ejercicios para $musculo."),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              SeleccionarEjercicios(musculo, ejerciciosPorMusculo[musculo]!),
        ),
      );
    }
  }
}

class SeleccionarEjercicios extends StatefulWidget {
  final String musculo;
  final List<String> ejerciciosDisponibles;

  const SeleccionarEjercicios(this.musculo, this.ejerciciosDisponibles,
      {super.key});

  @override
  State<SeleccionarEjercicios> createState() => _SeleccionarEjerciciosState();
}

class _SeleccionarEjerciciosState extends State<SeleccionarEjercicios> {
  List<String> ejerciciosSeleccionados = [];

  num get maxEjerciciosPorMusculo => 4;

  bool ejercicioYaSeleccionado(String ejercicio) {
    return rutinaActual.contains(ejercicio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar Ejercicios para \n${widget.musculo}'),
      ),
      body: ListView.builder(
        itemCount: widget.ejerciciosDisponibles.length,
        itemBuilder: (context, index) {
          final ejercicio = widget.ejerciciosDisponibles[index];
          return ListTile(
            title: Text(ejercicio),
            onTap: () {
              if (ejerciciosSeleccionados.length < maxEjerciciosPorMusculo) {
                if (ejercicioYaSeleccionado(ejercicio)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Este ejercicio ya ha sido seleccionado."),
                    ),
                  );
                } else {
                  setState(() {
                    ejerciciosSeleccionados.add(ejercicio);
                  });
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Ya has seleccionado el máximo de ejercicios para ${widget.musculo}."),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}

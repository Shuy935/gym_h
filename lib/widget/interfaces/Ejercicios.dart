import 'package:flutter/material.dart';
import 'package:gym_h/models/exercise_model.dart';
import 'package:gym_h/widget/interfaces/widgets.dart';

class Ejercicios extends StatefulWidget {
  final List<String> selectedMusc;
  const Ejercicios({super.key, required this.selectedMusc});

  @override
  State<Ejercicios> createState() => _EjerciciosState();
}

class _EjerciciosState extends State<Ejercicios> {
  int count = 0;
  List<ExerciseService>? data;
  int cantidad = 0;
  @override
  void initState() {
    super.initState();
    // Llama a la función para recuperar los datos del usuario
    if (widget.selectedMusc.length == 1) {
      getExerciseData1();
    } else if (widget.selectedMusc.length == 2) {
      getExerciseData2();
    } else {
      getExerciseData3();
    }
  }

  Future<void> getExerciseData1() async {
    final exerciseData = await readOneExercise(widget.selectedMusc[0]);
    if (exerciseData != null && exerciseData.isNotEmpty) {
      data = exerciseData;
      setState(() {
        cantidad = data!.length;
      });
    }
  }

  Future<void> getExerciseData2() async {
    final exerciseData =
        await readTwoExercise(widget.selectedMusc[0], widget.selectedMusc[1]);
    if (exerciseData != null && exerciseData.isNotEmpty) {
      data = exerciseData;
      setState(() {
        cantidad = data!.length;
      });
    }
  }

  Future<void> getExerciseData3() async {
    final exerciseData = await readThreeExercise(
        widget.selectedMusc[0], widget.selectedMusc[1], widget.selectedMusc[2]);
    if (exerciseData != null && exerciseData.isNotEmpty) {
      // for in para meterlos posible(?)
      data = exerciseData;
      setState(() {
        cantidad = data!.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String miString = widget.selectedMusc.join(" ");
    return MaterialApp(
      theme: ThemeData.dark().copyWith(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('Musculos: $widget.selectedMusc'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            CardE(
              cantidad: cantidad,
              data: data,
            ),
          ],
        )),
      ),
    );
  }
}

class CardE extends StatefulWidget {
  final int? cantidad;
  final List<ExerciseService>? data;

  const CardE({super.key, required this.cantidad, required this.data});

  @override
  State<CardE> createState() => _CardEState();
}

class _CardEState extends State<CardE> {
  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];
    for (int index = 0; index < widget.cantidad!; index++) {
      ExerciseService? exercise = widget.data?[index];
      cards.add(Card(
        color: const Color.fromARGB(255, 58, 58, 59),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 120,
                        child: const Text('Nombre: '),
                      ),
                      Expanded(child: Text(exercise!.nombreEjercicio ?? '')),
                    ],
                  ),
                  Container(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        child: const Text('Repeticiones: '),
                      ),
                      Expanded(
                        child: Rep_Drop(),
                        // TextFormField(
                        //    se cambiará por un dropdown
                        //   decoration: InputDecoration(
                        //     hintText: 'Repeticiones',
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        child: const Text('Series: '),
                      ),
                      Expanded(
                        child: Series_Drop(),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    child: const Image(
                      image: AssetImage('assets/image/logo.png'),
                    ),
                  ),
                  Container(
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Descanso recomendado:'),
                      Container(
                        width: 10,
                      ),
                      Text(exercise.descanso ?? ''),
                      Container(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text('Dificultad:'),
                          Container(
                            width: 10,
                          ),
                          Text(exercise.dificuldad ?? ''),
                        ],
                      ),
                      Container(
                        height: 25,
                      ),
                      Text(exercise.nombreMusculo ?? ''),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ));
    }
    return Column(
      children: cards,
    );
  }
}

/*
TextButton(
  child: const Text('LISTEN'),
  onPressed: () {/* ... */},
),
*/

/// Flutter code sample for [DropdownMenu].
List<String> rep = ['1', '2', '3', '5', '8', '10', '12', '15', '18', '20'];
List<String> series = ['1', '2', '3', '4', '5'];

class Rep_Drop extends StatefulWidget {
  const Rep_Drop({super.key});

  @override
  State<Rep_Drop> createState() => _Rep_DropState();
}

class _Rep_DropState extends State<Rep_Drop> {
  String dropdownValue = rep.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: rep.first,
      width: 100,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: rep.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}

class Series_Drop extends StatefulWidget {
  const Series_Drop({super.key});

  @override
  State<Series_Drop> createState() => _Series_DropState();
}

class _Series_DropState extends State<Series_Drop> {
  String dropdownValue = series.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: series.first,
      width: 100,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries:
          series.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}

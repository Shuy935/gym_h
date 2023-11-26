import 'package:flutter/material.dart';
import 'package:gym_h/models/exercise_model.dart';
import 'package:gym_h/models/rutina_model.dart';
import 'package:gym_h/screens/home_page.dart';
import 'package:gym_h/widget/interfaces/widgets.dart';

class Ejercicios extends StatefulWidget {
  final List<String> selectedMusc;
  final List<String> selectedDias;
  final String? cliente;
  const Ejercicios(
      {super.key,
      required this.selectedMusc,
      required this.selectedDias,
      this.cliente});

  @override
  State<Ejercicios> createState() => _EjerciciosState();
}

List<String> ejerciciosSeleccionados = [];
String repe = '';
String serie = '';

class _EjerciciosState extends State<Ejercicios> {
  List<ExerciseService>? data;
  int cantidad = 0;
  @override
  void initState() {
    super.initState();
    ejerciciosSeleccionados = [];

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
          title: Text('Musculos: ${widget.selectedMusc}', maxLines: 2),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            const Buscador_uwu(),
            CardE(
              cantidad: cantidad,
              data: data,
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (widget.cliente == null) {
              addRutina(ejerciciosSeleccionados, widget.selectedDias);
            } else {
              addRutinaUsuario(
                  ejerciciosSeleccionados, widget.selectedDias, widget.cliente);
            }
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
            );
          },
          child: const Icon(Icons.check),
        ),
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
      Color color = const Color.fromARGB(255, 72, 72, 72);
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
                      const Expanded(
                        child: RepDrop(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        child: const Text('Series: '),
                      ),
                      const Expanded(
                        child: SeriesDrop(),
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
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/image/loading.gif'),
                      image: NetworkImage(exercise.linkImagen!),
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
                      Stack(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const SizedBox(
                            //color: Colors.blue,
                            width: 150,
                            height: 70,
                          ),
                          Center(child: Text(exercise.nombreMusculo ?? '')),
                          Positioned(
                            left: 80,
                            top: -5,
                            child: ElevatedButton(
                              style: ButtonStyle(backgroundColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                // Cambiar el color en función del estado
                                if (states.contains(MaterialState.pressed)) {
                                  // Estado cuando se presiona el botón por unos segundos
                                  if (color == const Color(0xff484848)) {
                                    color = Colors.green;
                                    ejerciciosSeleccionados.addAll({
                                      exercise.objectId.toString(),
                                      serie,
                                      repe
                                    });
                                    //logica de ejercicio añadido
                                  } else {
                                    color = const Color(0xff484848);
                                    ejerciciosSeleccionados
                                        .remove(exercise.objectId.toString());
                                    ejerciciosSeleccionados.remove(serie);
                                    ejerciciosSeleccionados.remove(repe);
                                    //logica de ejercicio eliminado
                                  }
                                  return color;
                                  //hacer que se quede de ese color cuando se seleccione
                                }
                                // Estado normal
                                return color;
                              })),
                              onPressed: () {
                                // Acción selecciona el ejercicio
                                // print(ejerciciosSeleccionados);
                                //Parece que se queda guardada la lista pero no las selecciones :c
                              },
                              child: const Icon(Icons.check_circle_outline),
                            ),
                          )
                        ],
                      ),
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

class RepDrop extends StatefulWidget {
  const RepDrop({super.key});

  @override
  State<RepDrop> createState() => _RepDropState();
}

class _RepDropState extends State<RepDrop> {
  String dropdownValue = rep.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: null,
      width: 100,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          repe = value ?? '';
        });
      },
      dropdownMenuEntries: rep.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}

class SeriesDrop extends StatefulWidget {
  const SeriesDrop({super.key});

  @override
  State<SeriesDrop> createState() => _SeriesDropState();
}

class _SeriesDropState extends State<SeriesDrop> {
  String dropdownValue = series.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: null,
      width: 100,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          serie = value ?? '';
        });
      },
      dropdownMenuEntries:
          series.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}

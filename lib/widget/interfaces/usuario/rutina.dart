import 'package:flutter/material.dart';
import 'package:gym_h/models/rutina_model.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rutinas'),
        ),
        body: Rutinas(),
      ),
    );
  }
}

class Rutinas extends StatefulWidget {
  const Rutinas({Key? key}) : super(key: key);

  @override
  State<Rutinas> createState() => _RutinasState();
}

List<Color> color = [];
int selectedDay = 0;
Map<String, String> rutinaGlobal = {};

class _RutinasState extends State<Rutinas> {
  List<RutinaService>? data;
  int cantidad = 0;

  @override
  void initState() {
    super.initState();
    getRutina();
  }

  Future<void> getRutina() async {
    final rutinaData = await readRutina();
    if (rutinaData != null && rutinaData.isNotEmpty) {
      data = rutinaData;
      setState(() {
        cantidad = data!.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    color = List<Color>.generate(cantidad, (index) => const Color(0xff484848));

    return MaterialApp(
      theme: ThemeData.dark().copyWith(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildDayText(1, 'Lunes V'),
              if (selectedDay == 1)
                CardR(
                  cantidad: cantidad,
                  data: data,
                  dia: selectedDay,
                ),
              _buildDayText(2, 'Martes V'),
              if (selectedDay == 2)
                CardR(
                  cantidad: cantidad,
                  data: data,
                  dia: selectedDay,
                ),
              _buildDayText(3, 'Miercoles V'),
              if (selectedDay == 3)
                CardR(
                  cantidad: cantidad,
                  data: data,
                  dia: selectedDay,
                ),
              _buildDayText(4, 'Jueves V'),
              if (selectedDay == 4)
                CardR(
                  cantidad: cantidad,
                  data: data,
                  dia: selectedDay,
                ),
              _buildDayText(5, 'Viernes V'),
              if (selectedDay == 5)
                CardR(
                  cantidad: cantidad,
                  data: data,
                  dia: selectedDay,
                ),
              _buildDayText(6, 'Sabado V'),
              if (selectedDay == 6)
                CardR(
                  cantidad: cantidad,
                  data: data,
                  dia: selectedDay,
                ),
              _buildDayText(7, 'Domingo V'),
              if (selectedDay == 7)
                CardR(
                  cantidad: cantidad,
                  data: data,
                  dia: selectedDay,
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(rutinaGlobal);
            if (rutinaGlobal.isEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Ningun ejercicio realizado'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                            'En la rutina de hoy no se ha seleccionado ningun ejercicio como realizado'),
                        Container(
                          height: 10,
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              DateTime now = DateTime.now();
              String dayOfWeek = DateFormat('EEEE').format(now);
              Map<String, String> diaDeLaSemana = {
                "Monday": "Lunes",
                "Tuesday": "Martes",
                "Wednesday": "Miércoles",
                "Thursday": "Jueves",
                "Friday": "Viernes",
                "Saturday": "Sábado",
                "Sunday": "Domingo",
              };
              String? diaTraducido = diaDeLaSemana.containsKey(dayOfWeek)
                  ? diaDeLaSemana[dayOfWeek]
                  : dayOfWeek;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Rutina terminada'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                            '¿Desea dar por terminada la rutina de hoy ${diaTraducido?.toLowerCase()}?'),
                        Container(
                          height: 10,
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Agregar'),
                        onPressed: () async {
                          if (rutinaGlobal.isNotEmpty) {
                            print(
                                "Datos de rutina agregados al mapa global: $rutinaGlobal");
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: const Icon(Icons.check),
        ),
      ),
    );
  }

  Widget _buildDayText(int day, String dayText) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedDay = day;
          });
        },
        child: Text(
          dayText,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

class CardR extends StatefulWidget {
  final int cantidad;
  final List<RutinaService>? data;
  final int dia;

  const CardR({
    Key? key,
    required this.cantidad,
    required this.data,
    required this.dia,
  }) : super(key: key);

  @override
  State<CardR> createState() => _CardRState();
}

class _CardRState extends State<CardR> {
  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];
    for (int index = 0; index < widget.cantidad; index++) {
      RutinaService? rutina = widget.data?[index];
      if (rutina?.fecha == widget.dia) {
        color[index] = const Color(0xff484848);
        cards.add(
          Card(
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
                          Expanded(child: Text(rutina!.nombreEjercicio ?? '')),
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
                          Expanded(child: Text(rutina.repeticiones ?? '')),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 120,
                            child: const Text('Series: '),
                          ),
                          Expanded(child: Text(rutina.series ?? '')),
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
                          placeholder:
                              const AssetImage('assets/image/loading.gif'),
                          image: NetworkImage(rutina.linkImagen!),
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
                          Text(rutina.descanso ?? ''),
                          Container(
                            height: 15,
                          ),
                          Row(
                            children: [
                              const Text('Dificultad:'),
                              Container(
                                width: 10,
                              ),
                              Text(rutina.dificultad ?? ''),
                            ],
                          ),
                          Container(
                            height: 25,
                          ),
                          Stack(
                            children: <Widget>[
                              const SizedBox(
                                width: 150,
                                height: 70,
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    Text(rutina.nombreMusculo ?? ''),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 80,
                                top: -5,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          int dia = DateTime.now().weekday;
                                          if (rutina.fecha == dia) {
                                          if (color[index] ==
                                              Color(0xff484848)) {
                                            color[index] = Colors.green;
                                            _addToRutinaGlobal(rutina);
                                            rutinaGlobal['nombreEjercicio'] =
                                                rutina.nombreEjercicio ?? '';
                                            rutinaGlobal['repeticiones'] =
                                                rutina.repeticiones ?? '';
                                            rutinaGlobal['series'] =
                                                rutina.series ?? '';
                                            rutinaGlobal['nombreMusculo'] =
                                                rutina.nombreMusculo ?? '';
                                          } else {
                                            color[index] = Color(0xff484848);
                                            _removeFromRutinaGlobal(rutina);
                                          }
                                          }
                                        }
                                        return color[index];
                                      },
                                    ),
                                  ),
                                  onPressed: () {
                                    int dia = DateTime.now().weekday;
                                    if (rutina.fecha == dia) {
                                    if (color[index] != Color(0xff484848)) {
                                      _mostrarCuadroConfirmacion(context);
                                    } else {
                                      _mostrarCuadroCancelacion(context);
                                    }
                                  }},
                                  child: const Icon(Icons.check_circle_outline),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
    return Column(
      children: cards,
    );
  }

  Future<void> _mostrarCuadroConfirmacion(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Finalizado'),
          content: Text('El ejercicio se ha marcado como realizado'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _mostrarCuadroCancelacion(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reactivado'),
          content: Text('El ejercicio se ha marcado como no realizado'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void _addToRutinaGlobal(RutinaService rutina) {
    rutinaGlobal['nombreEjercicio'] = rutina.nombreEjercicio ?? '';
    rutinaGlobal['repeticiones'] = rutina.repeticiones ?? '';
    rutinaGlobal['series'] = rutina.series ?? '';
    rutinaGlobal['nombreMusculo'] = rutina.nombreMusculo ?? '';
  }

  void _removeFromRutinaGlobal(RutinaService rutina) {
    rutinaGlobal.removeWhere((key, value) => [
          'nombreEjercicio',
          'repeticiones',
          'series',
          'nombreMusculo',
        ].contains(key));
  }
}

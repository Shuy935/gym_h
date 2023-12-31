import 'package:flutter/material.dart';
import 'package:gym_h/darkmode/theme_provider.dart';
import 'package:gym_h/models/historial_model.dart';
import 'package:gym_h/models/rutina_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Rutinas extends StatefulWidget {
  const Rutinas({super.key});

  @override
  State<Rutinas> createState() => _RutinasState();
}

List<Color> color = [];
int selectedDay = 0;
List<String> ejerciciosSelected = [];
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
      setState(() {
        data = rutinaData;
        cantidad = data!.length;
      });
    }
  }

  void handleFloatingActionButton() async {
    final ejerciciosRealizados = ejerciciosSelected;
    await addHistorial(ejerciciosRealizados);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    color = List<Color>.generate(cantidad, (index) => const Color(0xff484848));

    return MaterialApp(
      theme: ThemeData.dark().copyWith(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(margin: const EdgeInsets.only(bottom: 40)),
              _buildDayText(1, 'Lunes V'),
              if (selectedDay == 1)
                CardR(cantidad: cantidad, data: data, dia: selectedDay),
              Container(margin: const EdgeInsets.only(bottom: 22)),
              _buildDayText(2, 'Martes V'),
              if (selectedDay == 2)
                CardR(cantidad: cantidad, data: data, dia: selectedDay),
              Container(margin: const EdgeInsets.only(bottom: 22)),
              _buildDayText(3, 'Miércoles V'),
              if (selectedDay == 3)
                CardR(cantidad: cantidad, data: data, dia: selectedDay),
              Container(margin: const EdgeInsets.only(bottom: 22)),
              _buildDayText(4, 'Jueves V'),
              if (selectedDay == 4)
                CardR(cantidad: cantidad, data: data, dia: selectedDay),
              Container(margin: const EdgeInsets.only(bottom: 22)),
              _buildDayText(5, 'Viernes V'),
              if (selectedDay == 5)
                CardR(cantidad: cantidad, data: data, dia: selectedDay),
              Container(margin: const EdgeInsets.only(bottom: 22)),
              _buildDayText(6, 'Sábado V'),
              if (selectedDay == 6)
                CardR(cantidad: cantidad, data: data, dia: selectedDay),
              Container(margin: const EdgeInsets.only(bottom: 22)),
              _buildDayText(7, 'Domingo V'),
              if (selectedDay == 7)
                CardR(cantidad: cantidad, data: data, dia: selectedDay),
            ],
          ),
        ),
        floatingActionButton: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  if (rutinaGlobal.isEmpty) {
                    _mostrarDialogNingunEjercicioRealizado(
                      context,
                      themeProvider,
                    );
                  } else {
                    _mostrarDialogRutinaTerminada(
                      context,
                      themeProvider,
                    );
                  }
                },
                backgroundColor: Colors.transparent,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        themeProvider.buttonColor1,
                        themeProvider.buttonColor2,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check,
                      color: themeProvider.iconsColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  onPressed: () {
                    getRutina();
                  },
                  backgroundColor: Colors.transparent,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          themeProvider.buttonColor1,
                          themeProvider.buttonColor2,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.refresh,
                        color: themeProvider.iconsColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayText(int day, String dayText) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
            color: themeProvider.textColor,
          ),
        ),
      ),
    );
  }

  void _mostrarDialogNingunEjercicioRealizado(
      BuildContext context, final themeProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No se ha realizado ningún ejercicio.'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                  'Lo sentimos, en la rutina de hoy no existe ningún ejercicio realizado.'),
              Container(
                height: 10,
                alignment: Alignment.center,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return Colors.transparent;
                  },
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      themeProvider.buttonColor1,
                      themeProvider.buttonColor2,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Aceptar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogRutinaTerminada(
      BuildContext context, ThemeProvider themeProvider) {
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
              const SizedBox(height: 10),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return Colors.transparent;
                  },
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: themeProvider.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (rutinaGlobal.isNotEmpty) {
                  handleFloatingActionButton();
                  rutinaGlobal = {};
                  ejerciciosSelected = [];
                  Navigator.of(context).pop();
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return Colors.transparent;
                  },
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Agregar',
                  style: TextStyle(
                    color: themeProvider.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
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
        cards.add(_buildCard(rutina!, index));
      }
    }
    return Column(children: cards);
  }

  Widget _buildCard(RutinaService rutina, int index) {
    return Card(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 120,
                      child: Text('Nombre: '),
                    ),
                    Expanded(child: Text(rutina.nombreEjercicio ?? '')),
                  ],
                ),
                Container(height: 10),
                Row(
                  children: [
                    const SizedBox(
                      width: 120,
                      child: Text('Repeticiones: '),
                    ),
                    Expanded(child: Text(rutina.repeticiones ?? '')),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 120,
                      child: Text('Series: '),
                    ),
                    Expanded(child: Text(rutina.series ?? '')),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/image/loading.gif'),
                    image: NetworkImage(rutina.linkImagen!),
                  ),
                ),
                Container(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Descanso recomendado:'),
                    Container(width: 10),
                    Text(rutina.descanso ?? ''),
                    Container(height: 15),
                    Row(
                      children: [
                        const Text('Dificultad:'),
                        Container(width: 10),
                        Text(rutina.dificultad ?? ''),
                      ],
                    ),
                    Container(height: 25),
                    Stack(
                      children: <Widget>[
                        const SizedBox(width: 150, height: 70),
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
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    int dia = DateTime.now().weekday;
                                    if (rutina.fecha == dia) {
                                      if (color[index] ==
                                          const Color(0xff484848)) {
                                        color[index] = Colors.green;
                                        _addToRutinaGlobal(rutina);
                                      } else {
                                        color[index] = const Color(0xff484848);
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
                                if (color[index] != const Color(0xff484848)) {
                                  _mostrarCuadroConfirmacion(context);
                                  ejerciciosSelected.addAll({
                                    rutina.objectIdExercise.toString(),
                                    rutina.series.toString(),
                                    rutina.repeticiones.toString(),
                                  });
                                } else {
                                  _mostrarCuadroCancelacion(context);
                                  ejerciciosSelected.removeWhere(
                                    (element) =>
                                        element ==
                                            rutina.objectIdExercise
                                                .toString() ||
                                        element == rutina.series.toString() ||
                                        element ==
                                            rutina.repeticiones.toString(),
                                  );
                                }
                              }
                            },
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
    );
  }

  Future<void> _mostrarCuadroConfirmacion(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Finalizado'),
          content: const Text('El ejercicio se ha marcado como realizado'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
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
          title: const Text('Reactivado'),
          content: const Text('El ejercicio se ha marcado como no realizado'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
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
    rutinaGlobal.removeWhere(
      (key, value) => [
        'nombreEjercicio',
        'repeticiones',
        'series',
        'nombreMusculo',
      ].contains(key),
    );
  }
}

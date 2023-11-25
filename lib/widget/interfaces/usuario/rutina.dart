import 'package:flutter/material.dart';
import 'package:gym_h/models/historial_model.dart';
import 'package:gym_h/models/rutina_model.dart';
import 'package:gym_h/utils/utils.dart';

class Rutinas extends StatefulWidget {
  const Rutinas({super.key});

  @override
  State<Rutinas> createState() => _RutinasState();
}

List<Color> color = [];
List<String> ejerciciosSelected = [];
 bool hayEjercicioCompletado = false;

class _RutinasState extends State<Rutinas> {
  List<RutinaService>? data;
  int cantidad = 0;
 
 

  @override
  void initState() {
    super.initState();
     ejerciciosSelected = [];
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
  void handleFloatingActionButton() async {
  if (hayEjercicioCompletado) {
    final ejerciciosRealizados = ejerciciosSelected;
   await addHistorial(ejerciciosRealizados);
  } else {
    Utils.showSnackBar('Ejercicios no selecionados') ;
  }
}

  @override
  Widget build(BuildContext context) {
    color = List<Color>.generate(cantidad, (index) => const Color(0xff484848));

    return MaterialApp(
      theme: ThemeData.dark().copyWith(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //   ),
        //   title: Text('Rutina:'),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CardR(
                cantidad: cantidad,
                data: data,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: handleFloatingActionButton,
        child: Icon(Icons.arrow_forward),
      ),
      ),
    );
  }
}




class CardR extends StatefulWidget {
  final int cantidad;
  final List<RutinaService>? data;
  const CardR({super.key, required this.cantidad, required this.data});

  @override
  State<CardR> createState() => _CardRState();
}

class _CardRState extends State<CardR> {
  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];
    for (int index = 0; index < widget.cantidad; index++) {
      RutinaService? rutina = widget.data?[index];
      color[index] = const Color(0xff484848);
      cards.add(Card(
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
                        image: NetworkImage(rutina.linkImagen!)),
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
                          Center(child: Column( children: [Text(rutina.nombreMusculo ?? ''),
                          Text('${rutina.fecha}')])),
                          Positioned(
                            left: 80,
                            top: -5,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (!canDoExercise(rutina?.fecha)) {
                                        return Colors.grey; // Deshabilitar el botón si no se puede realizar el ejercicio
                                      }

                                      // Verificar si el botón está siendo presionado
                                      final isPressed = states.contains(MaterialState.pressed);

                                      // Cambiar el color del botón según el estado actual
                                      return isPressed ? Colors.green : Color(0xff484848);
                                    },
                                  ),
                                ),
                                onPressed: () {
                                      if (canDoExercise(rutina?.fecha)) {
                                        setState(() {
                                          if (color[index] == Color(0xff484848)) {
                                            color[index] = Colors.green; 
                                            ejerciciosSelected.addAll({
                                              rutina.objectIdExercise.toString(),
                                              rutina.series.toString(),
                                              rutina.repeticiones.toString(),
                                            });
                                            _mostrarCuadroConfirmacion(context);
                                          } else {
                                            color[index] = Color(0xff484848);
                                            ejerciciosSelected.removeWhere((element) =>
                                              element == rutina.objectIdExercise.toString() ||
                                              element == rutina.series.toString() ||
                                              element == rutina.repeticiones.toString(),
                                            );
                                            _mostrarCuadroCancelacion(context);
                                          }
                                          print('Button color: ${color[index]}');
                                        });
                                      } else {
                                        _mostrarMensaje(
                                          context,
                                          'Este día no te corresponde hacer este ejercicio',
                                        );
                                      }
                                    },
                                child: const Icon(Icons.check_circle_outline),
                              ),
                          )
                        ],
                      ),
                // Agregar la fecha después del ElevatedButton
                Text(getFormattedDate(rutina?.fecha)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
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
  void _mostrarMensaje(BuildContext context, String mensaje) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Mensaje'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}


  String getFormattedDate(int? dayOfWeek) {
  // Mapear el número del día de la semana a su nombre correspondiente
  String dayName = '';
  if (dayOfWeek != null) {
    switch (dayOfWeek) {
      case 1:
        dayName = 'Lunes';
        break;
      case 2:
        dayName = 'Martes';
        break;
      case 3:
        dayName = 'Miércoles';
        break;
      case 4:
        dayName = 'Jueves';
        break;
      case 5:
        dayName = 'Viernes';
        break;
      case 6:
        dayName = 'Sábado';
        break;
      case 7:
        dayName = 'Domingo';
        break;
    }
  }

  // Puedes personalizar el formato de la fecha según tus necesidades
  return 'Fecha del ejercicio: $dayName';
}

bool canDoExercise(int? dayOfWeek) {
  if (dayOfWeek != null) {
    return DateTime.now().weekday == dayOfWeek;
  }
  return false;
}
}

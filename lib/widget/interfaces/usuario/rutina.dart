import 'package:flutter/material.dart';
import 'package:gym_h/models/rutina_model.dart';

class Rutinas extends StatefulWidget {
  const Rutinas({super.key});

  @override
  State<Rutinas> createState() => _RutinasState();
}

List<Color> color = [];

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
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      if (color[index] == Color(0xff484848)) {
                                        color[index] = Colors.green;
                                      } else {
                                        color[index] = Color(0xff484848);
                                      }
                                    }
                                    return color[index];
                                  },
                                ),
                              ),
                              onPressed: () {
                                if (color[index] != Color(0xff484848)) {
                                  _mostrarCuadroConfirmacion(context);
                                } else {
                                  _mostrarCuadroCancelacion(context);
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
}

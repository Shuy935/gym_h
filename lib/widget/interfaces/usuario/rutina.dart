import 'package:flutter/material.dart';
import 'package:gym_h/models/rutina_model.dart';

class Rutinas extends StatefulWidget {
  const Rutinas({super.key});

  @override
  State<Rutinas> createState() => _RutinasState();
}

class _RutinasState extends State<Rutinas> {
  List<RutinaService>? data;
  int cantidad = 0;

  @override
  void initState() {
    super.initState();
    getRutina();
  }

  Future<void> getRutina() async {
    final rutinaData = await readRutinaUsuario();
    if (rutinaData != null && rutinaData.isNotEmpty) {
      data = rutinaData;
      setState(() {
        cantidad = data!.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // int m1 = 0;
    // int m2 = 0;
    // int m3 = 0;
    // //get de cada musculo DENTRO de los ifs
    // if (0 == 1) {
    //   m1 = 1;
    // } else if (2 == 2) {
    //   m1 = 1;
    //   m2 = 2;
    // } else {
    //   m1 = 1;
    //   m2 = 1;
    //   m3 = 3;
    // }
    // int cantidad = m1 + m2 + m3;

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
              for (int index = 0; index < cantidad; index++)
                CardR(
                  cardIndex: index,
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
  final int cardIndex;
  final List<RutinaService>? data;
  const CardR({super.key, required this.cardIndex, required this.data});

  @override
  _CardRState createState() => _CardRState();
}

class _CardRState extends State<CardR> {
  Color color = const Color.fromARGB(255, 72, 72, 72);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    const Expanded(child: Text('get del ejercicio')),
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
                      child: Text('data'),
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
                      child: Text('data'),
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
                    placeholder: AssetImage('assets/image/loading.gif'),
                    image: NetworkImage(
                        'https://drive.google.com/u/0/uc?id=1M6K_g7X8BJeK8FNFxwbfsKla7FFEIYAb'),
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
                    const Text('Get de eso'),
                    Container(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Text('Dificultad:'),
                        Container(
                          width: 10,
                        ),
                        const Text('Get de eso'),
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
                        const Center(
                          child: Text('Musculo'),
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
                                    Future.delayed(Duration.zero, () {});
                                  }
                                  return color;
                                },
                              ),
                            ),
                            onPressed: () {
                              if (color == Color(0xff484848)) {
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
    );
  }

  Future<void> _mostrarCuadroConfirmacion(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación'),
          content: Text('¿Ya realizó el ejercicio?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  color = Colors.green;
                });
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
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
          title: Text('Cancelacion'),
          content: Text(
              '¿Desea marcar el ejercicio seleccionado como no realizado?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  color = Color(0xff484848);
                });
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}

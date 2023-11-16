import 'package:flutter/material.dart';

class Rutinas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int m1 = 0;
    int m2 = 0;
    int m3 = 0;
    //get de cada musculo DENTRO de los ifs
    if (0 == 1) {
      m1 = 1;
    } else if (2 == 2) {
      m1 = 1;
      m2 = 2;
    } else {
      m1 = 1;
      m2 = 1;
      m3 = 3;
    }
    int cantidad = m1 + m2 + m3;

    return MaterialApp(
      theme: ThemeData.dark().copyWith(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CardR(
                cantidad: cantidad,
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

  const CardR({Key? key, required this.cantidad}) : super(key: key);

  @override
  _CardRState createState() => _CardRState();
}

class _CardRState extends State<CardR> {
  @override
  Widget build(BuildContext context) {
    print(widget.cantidad);
    List<Widget> cards = [];
    for (int index = 0; index < widget.cantidad; index++) {
      Color color = const Color.fromARGB(255, 72, 72, 72);
      bool cardVisibility = true;
      cards.add(
        Card(
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
                                style: ButtonStyle(backgroundColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  // Cambiar el color en función del estado
                                  if (states.contains(MaterialState.pressed)) {
                                    // Estado cuando se presiona el botón por unos segundos
                                    if (color == Color(0xff484848)) {
                                      _mostrarCuadroConfirmacion(context, color);
                                    }
                                    return color;
                                  }
                                  return color;
                                })),
                                onPressed: () {
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
        ),
      );
    }
    return Column(
      children: cards,
    );
  }
}

Future<void> _mostrarCuadroConfirmacion(BuildContext context,Color color) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmación'),
        content: Text('¿Ya realizo el ejercicio?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              //Futuro historial
              Navigator.of(context).pop();
            },
            child: Text('Aceptar'),
          ),
        ],
      );
    },
  );
}

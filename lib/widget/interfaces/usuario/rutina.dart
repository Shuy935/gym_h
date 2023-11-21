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
    color = List<Color>.generate(cantidad, (index) => Color(0xff484848));

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

  const CardR({Key? key, required this.cantidad}) : super(key: key);

  @override
  _CardRState createState() => _CardRState();
}

class _CardRState extends State<CardR> {
  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];
    for (int index = 0; index < widget.cantidad!; index++) {
      color[index] = Color(0xff484848);
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

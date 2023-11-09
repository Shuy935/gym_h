import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/muscles.dart';

class Ejercicios extends StatelessWidget {
  final List<String> selectedMusc;
  Ejercicios({super.key, required this.selectedMusc});

  @override
  Widget build(BuildContext context) {
    String miString = selectedMusc.join(" ");
    print(selectedMusc);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Musculos: $selectedMusc'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            CardE(),
            CardE(),
            CardE(),
          ],
        )),
      ),
    );
  }
}

class CardE extends StatelessWidget {
  const CardE({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: IntrinsicHeight(
          child: Card(
            color: Color.fromARGB(255, 110, 114, 116),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Nombre: '),
                          ),
                          Expanded(child: Text('get del ejercicio')),
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Repeticiones: '),
                          ),
                          Expanded(
                            child: TextFormField(
                              // se cambiará por un dropdown
                              decoration: InputDecoration(
                                hintText: 'Repeticiones',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Series: '),
                          ),
                          Expanded(
                            child: TextFormField(
                              // se cambiará por un dropdown
                              decoration: InputDecoration(
                                hintText: 'Series',
                              ),
                            ),
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
                        child: Image(
                          image: AssetImage('assets/image/logo.png'),
                        ),
                      ),
                      Container(
                        width: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Descanso recomendado:'),
                          Container(
                            width: 10,
                          ),
                          Text('Get de eso'),
                          Container(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text('Dificultad:'),
                              Container(
                                width: 10,
                              ),
                              Text('Get de eso'),
                            ],
                          ),
                          Container(
                            height: 25,
                          ),
                          Text('Musculo'),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
TextButton(
  child: const Text('LISTEN'),
  onPressed: () {/* ... */},
),
*/
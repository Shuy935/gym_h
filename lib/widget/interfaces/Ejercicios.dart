import 'package:flutter/material.dart';

class Ejercicios extends StatelessWidget {
  const Ejercicios({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Card de :')),
        body: const CardE(),
      ),
    );
  }
}

class CardE extends StatelessWidget {
  const CardE({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicHeight(
        child: Card(
          color: Color.fromARGB(255, 22, 147, 209),
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
                        Expanded(
                          child: TextFormField(
                            // se cambiará por un dropdown
                            decoration: InputDecoration(
                              hintText: 'Nombre del ejercicio',
                            ),
                          ),
                        ),
                      ],
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
                      width: 200,
                      height: 200,
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
    );
  }
}

/*
TextButton(
  child: const Text('LISTEN'),
  onPressed: () {/* ... */},
),
*/
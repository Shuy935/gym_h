import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/muscles.dart';

class Ejercicios extends StatelessWidget {
  final List<String> selectedMusc;
  Ejercicios({super.key, required this.selectedMusc});

  @override
  Widget build(BuildContext context) {
    int m1 = 0;
    int m2 = 0;
    int m3 = 0;
    if (selectedMusc.length == 1) {
      m1 = 1;
    }else if(selectedMusc.length == 2){
     m1 = 1;
     m2 = 1;
    }else{
     m1 = 1;
     m2 = 1;
     m3 = 3;
    }
    int cantidad = m1+m2+m3;
    print(cantidad);
    String miString = selectedMusc.join(" ");
    return MaterialApp(
      theme: ThemeData.dark().copyWith(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('Musculos: $selectedMusc'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            CardE(cantidad: cantidad,),
          ],
        )),
      ),
    );
  }
}

class CardE extends StatelessWidget {
  final int cantidad;
  const CardE({super.key, required this.cantidad});

  @override
  Widget build(BuildContext context) {
    print(cantidad);
    List<Widget> cards = [];
    for (int index = 0; index < cantidad; index++) {
      cards.add(Card(
            color: Color.fromARGB(255, 58, 58, 59),
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
          ));
      }
    return Column(children: cards,
    );
  }
}

/*
TextButton(
  child: const Text('LISTEN'),
  onPressed: () {/* ... */},
),
*/
import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/buscadoruwu.dart';
import 'package:gym_h/widget/interfaces/widgets.dart';

class Ejercicios extends StatelessWidget {
  final List<String> selectedMusc;
  Ejercicios({super.key, required this.selectedMusc});

  @override
  Widget build(BuildContext context) {
    int m1 = 0;
    int m2 = 0;
    int m3 = 0;
    //get de cada musculo DENTRO de los ifs
    if (selectedMusc.length == 1) {
      m1 = 1;
    } else if (selectedMusc.length == 2) {
      m1 = 1;
      m2 = 2;
    } else {
      m1 = 1;
      m2 = 1;
      m3 = 3;
    }
    int cantidad = m1 + m2 + m3;
    String miString = selectedMusc.join(" ");
    return MaterialApp(
      theme: ThemeData.dark().copyWith(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('Musculos: $selectedMusc'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Buscador_uwu(),
            CardE(
              cantidad: cantidad,
            ),
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
                      Expanded(
                        child: Rep_Drop(),
                        // TextFormField(
                        //    se cambiará por un dropdown
                        //   decoration: InputDecoration(
                        //     hintText: 'Repeticiones',
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        child: const Text('Series: '),
                      ),
                      Expanded(
                        child: Series_Drop(),
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
                      Row(children: [
                        Text('Musculo'),
                        
                      ]),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ));
    }
    return Column(
      children: cards,
    );
  }
}

/*
TextButton(
  child: const Text('LISTEN'),
  onPressed: () {/* ... */},
),
*/

/// Flutter code sample for [DropdownMenu].
List<String> rep = ['1', '2', '3', '5', '8', '10', '12', '15', '18', '20'];
List<String> series = ['1', '2', '3', '4', '5'];

class Rep_Drop extends StatefulWidget {
  const Rep_Drop({super.key});

  @override
  State<Rep_Drop> createState() => _Rep_DropState();
}

class _Rep_DropState extends State<Rep_Drop> {
  String dropdownValue = rep.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: rep.first,
      width: 100,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: rep.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}

class Series_Drop extends StatefulWidget {
  const Series_Drop({super.key});

  @override
  State<Series_Drop> createState() => _Series_DropState();
}

class _Series_DropState extends State<Series_Drop> {
  String dropdownValue = series.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: series.first,
      width: 100,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries:
          series.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}

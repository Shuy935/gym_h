import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistroH extends StatefulWidget {
  const RegistroH({Key? key}) : super(key: key);

  @override
  _RegistroHState createState() => _RegistroHState();
}

class _RegistroHState extends State<RegistroH> {
  final List<Registro> registros = [
    //get de id, nombre y fecha
    Registro('Manolo', DateTime(2023, 1, 15)),
    Registro('Sofia', DateTime(2023, 2, 10)),
    Registro('Canela', DateTime(2023, 3, 5)),
  ];

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Registros'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: DataTable(
            columns: <DataColumn>[
              DataColumn(
                label: Text(
                  'Nombre',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Fecha',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: registros.map((registro) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(registro.name)),
                  DataCell(Text(
                    DateFormat('yyyy-MM-dd').format(registro.date),
                  )),
                ],
              );
            }).toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Agregar Registro'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: nombreController,
                        decoration: InputDecoration(labelText: 'Nombre'),
                      ),
                      TextField(
                        controller: fechaController,
                        decoration:
                            InputDecoration(labelText: 'Fecha (yyyy-MM-dd)'),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Agregar'),
                      onPressed: () {
                        final nombre = nombreController.text;
                        final fechaStr = fechaController.text;
                        final fecha =
                            DateFormat('yyyy-MM-dd').parse(fechaStr, true);

                        if (nombre != '' && fecha != null) {
                          setState(() {
                            registros.insert(0, Registro(nombre, fecha));
                            nombreController.clear();
                            fechaController.clear();
                          });
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class Registro {
  final String name;
  final DateTime date;

  Registro(this.name, this.date);
}

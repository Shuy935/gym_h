import 'package:flutter/material.dart';

class RegistroHU extends StatelessWidget {
  const RegistroHU({Key? key}) : super(key: key);
//este es unicamente para el usuario actual (cuando no es admin)
  @override
  Widget build(BuildContext context) {
    final List<Registro> registros = [
      Registro('Manolo', 19, 'Estudiante'),
      Registro('Sofia', 35, 'Maestra'),
      Registro('Canela', 3, 'Mascota'),
    ];

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
        body: DataTable(
          columns: <DataColumn>[
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Age',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Role',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: registros.map((registro) {
            return DataRow(
              cells: <DataCell>[
                DataCell(Text(registro.name)),
                DataCell(Text(registro.age.toString())),
                DataCell(Text(registro.role)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Registro {
  final String name;
  final int age;
  final String role;

  Registro(this.name, this.age, this.role);
}

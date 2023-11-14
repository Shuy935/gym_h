import 'package:flutter/material.dart';
import 'package:gym_h/models/attendance_record_model.dart';

class RegistroHU extends StatelessWidget {
  final List<AsistenciaService> asistencias;

  const RegistroHU({Key? key, required this.asistencias}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Registros'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: asistencias.map((asistencia) {
            return DataRow(
              cells: <DataCell>[
                DataCell(Text('')),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}


// class Registro {
//   final String name;
//   final int age;
//   final String role;

//   Registro(this.name, this.age, this.role);
// }

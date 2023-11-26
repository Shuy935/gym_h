import 'package:flutter/material.dart';
import 'package:gym_h/models/historial_model.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:intl/intl.dart';

class Historial extends StatefulWidget {
  const Historial({super.key});

  @override
  State<Historial> createState() => _HistorialState();
}

final TextEditingController fechaController = TextEditingController();

class _HistorialState extends State<Historial> {
  List<HistorialService> historialData = [];
  Future<void> getHistorial(String fH) async {
    final data = await readHistorial(fH);
    if (data != null && data.isNotEmpty) {
      historialData = data;
      // setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: fechaController,
          decoration: const InputDecoration(
              labelText: 'Fecha', icon: Icon(Icons.calendar_today)),
          readOnly: true, //set it true, so that user will not able to edit text

          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                helpText: 'Seleccione el dia que desee consultar',
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2022),
                lastDate: DateTime
                    .now()); //la ultima fecha que puede escoger es la de hoy
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);

              setState(() {
                fechaController.text = formattedDate;
                getHistorial(fechaController.text);
                //set output date to TextField value.
                //Mandarlo a la base de datos
              });
            } else {
              Utils.showSnackBar("La fecha no esta seleccionada");
            }
          },
          //InputDecoration(labelText: 'Fecha (yyyy-MM-dd)'),
        ),
        Center(
          child: DataTable(
            columnSpacing: 30,
            dataRowMaxHeight: 70,
            headingRowHeight: 50,
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Ejercicio',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Serie',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Repeticion',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Musculo',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
            rows: historialData.map((historial) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(historial.nombreEjercicio.toString())),
                  DataCell(Text(historial.series.toString())),
                  DataCell(Text(historial.repeticiones.toString())),
                  DataCell(Text(historial.nombreMusculo.toString())),
                ],
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

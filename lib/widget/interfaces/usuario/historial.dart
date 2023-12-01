import 'package:flutter/material.dart';
import 'package:gym_h/darkmode/theme_provider.dart';
import 'package:gym_h/models/historial_model.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
      setState(() {
        historialData = data;
      });
    } else {
      setState(() {
        historialData = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Container(margin: EdgeInsets.only(bottom: 20)),
        TextField(
          controller: fechaController,
          decoration: InputDecoration(
            labelText: 'Fecha:', 
            labelStyle: TextStyle(fontSize: 16, color: themeProvider.textColor),
              icon: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Icons.calendar_today, color: themeProvider.iconsColor2)),
              ),
              readOnly: true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  helpText: 'Seleccione el día que desee consultar:',
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
                      Utils.showSnackBar("No hay fecha seleccionada.");
                    }
                  },
          //InputDecoration(labelText: 'Fecha (yyyy-MM-dd)'),
        ),
        Center(child: TableHistory(historialData: historialData))
      ],
    );
  }
}

class TableHistory extends StatefulWidget {
  final List<HistorialService> historialData;
  const TableHistory({super.key, required this.historialData});

  @override
  State<TableHistory> createState() => _TableHistoryState();
}

class _TableHistoryState extends State<TableHistory> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
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
              'Repetición',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Músculo',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: widget.historialData.map((historial) {
        return DataRow(
          cells: <DataCell>[
            DataCell(Text(historial.nombreEjercicio.toString())),
            DataCell(Text(historial.series.toString())),
            DataCell(Text(historial.repeticiones.toString())),
            DataCell(Text(historial.nombreMusculo.toString())),
          ],
        );
      }).toList(),
    );
  }
}

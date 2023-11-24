import 'package:flutter/material.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:intl/intl.dart';

class Historial extends StatefulWidget {
  const Historial({super.key});

  @override
  State<Historial> createState() => _HistorialState();
}

final TextEditingController fechaController = TextEditingController();

class _HistorialState extends State<Historial> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        controller: fechaController,
        decoration: const InputDecoration(
            labelText: 'Fecha', icon: Icon(Icons.calendar_today)),
        readOnly: true, 
        
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              helpText: 'Seleccione el dia que desee consultar',
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2022),
              lastDate: DateTime
                  .now()); 
          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

            setState(() {
              fechaController.text = formattedDate;
              print(fechaController.text);
              print(pickedDate.weekday);
            });
          } else {
            Utils.showSnackBar("La fecha no esta seleccionada");
          }
        },
      ),
    ]);
  }
}

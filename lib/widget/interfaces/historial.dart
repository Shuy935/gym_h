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
    return TextField(
                        controller: fechaController,
                        decoration: const InputDecoration(
                            labelText: 'Fecha',
                            icon: Icon(Icons.calendar_today)),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2023), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime
                                  .now()); //la ultima fecha que puede escoger es la de hoy
                          if (pickedDate != null) {
                            // print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            // print(formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              fechaController.text =
                                  formattedDate;
                                  print(fechaController.text);
                                  print(pickedDate.weekday);
                                   //set output date to TextField value.
                              //Mandarlo a la base de datos
                            });
                          } else {
                            Utils.showSnackBar("Date is not selected");
                          }
                        },
                        //InputDecoration(labelText: 'Fecha (yyyy-MM-dd)'),
    );
  }
}
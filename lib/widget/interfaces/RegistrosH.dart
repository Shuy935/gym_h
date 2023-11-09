import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'date_picker_widget.dart';

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
          child: Center(
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Expanded(
                      child: Text(
                    'Nombre',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 25),
                  )),
                ),
                DataColumn(
                    label: Expanded(
                  child: Text(
                    'Fecha',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 25),
                  ),
                )),
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
              columnSpacing: //sin esta cosa se pegan las columnas
                  200, //espacio entre columnas, creo que hay que ajustarlo porque puede que varíe el tamaño de la pantalla
              dividerThickness:
                  2, //este es para que tanto grosor tienen las lineas
              horizontalMargin:
                  10, //el espacio entre el borde de la pantalla y la tabla
            ),
          ), //para que esté centrada la tabla
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
                        //que solo deje poner los de la base de datos y que haga busquedas que coincidan con lo que se va escribiendo?
                      ),
                      TextField(
                        controller: fechaController,
                        decoration: InputDecoration(
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
                                  formattedDate; //set output date to TextField value.
                              //Mandarlo a la base de datos
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                        //InputDecoration(labelText: 'Fecha (yyyy-MM-dd)'),
                      ),
                      Container(
                        // color: Color.fromARGB(255, 128, 123, 155),
                        height: 10,
                        alignment: Alignment.center,

                        // child: const DatePickerApp(), //No funciona xd hay que modificar el DatePickerApp
                        //Poner un boton que llame para escoger la fecha y llamar a DatePickerApp()
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

// class Date_Picker extends StatefulWidget {
//   const Date_Picker({super.key});

//   @override
//   State<Date_Picker> createState() => _Date_PickerState();
// }

// class _Date_PickerState extends State<Date_Picker> {
//   TextEditingController dateinput = TextEditingController();
//   @override
//   void initState() {
//     dateinput.text = ""; //set the initial value of text field
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//         child: TextField(
//       controller: dateinput, //editing controller of this TextField
//       decoration: InputDecoration(
//           icon: Icon(Icons.calendar_today), //icon of text field
//           labelText: "Enter Date" //label text of field
//           ),
//       readOnly: true, //set it true, so that user will not able to edit text
//       onTap: () async {
//         DateTime pickedDate = await showDatePicker(
//             context: context,
//             initialDate: DateTime.now(),
//             firstDate: DateTime(
//                 2000), //DateTime.now() - not to allow to choose before today.
//             lastDate: DateTime(2101));

//         if (pickedDate != null) {
//           print(
//               pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//           String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//           print(
//               formattedDate); //formatted date output using intl package =>  2021-03-16
//           //you can implement different kind of Date Format here according to your requirement

//           setState(() {
//             dateinput.text =
//                 formattedDate; //set output date to TextField value.
//           });
//         } else {
//           print("Date is not selected");
//         }
//       },
//     ));
//   }
// }

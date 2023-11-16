import 'package:flutter/material.dart';
import 'package:gym_h/models/attendance_record_model.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:intl/intl.dart';

class RegistroH extends StatefulWidget {
  final String? usuario;

  const RegistroH({Key? key, this.usuario}) : super(key: key);

  @override
  State<RegistroH> createState() => _RegistroHState();
}

class _RegistroHState extends State<RegistroH> {
  String? fullname;
  String? objectid;
  List<AsistenciaService> listaAsistencia = [];

  @override
  void initState() {
    super.initState();
    print(widget.usuario);
    fullname = widget.usuario;

    _getData();
  }

  Future<void> _getData() async {
    try {
      final userid = await getObjectIdByFullname(fullname!);
      if (userid != null) {
        final data = await readAsistenciasUsuario(userid);
        setState(() {
          listaAsistencia = data;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
        body: SingleChildScrollView(
          child: Center(
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Nombre',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 25),
                    ),
                  ),
                ),
                DataColumn(label: Text('')),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Fecha',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 25),
                    ),
                  ),
                ),
                DataColumn(label: Text('')),
                DataColumn(label: Text('Editar')),
                DataColumn(label: Text('Borrar'))
              ],
              rows: listaAsistencia.map((asistencia) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: size.width * 0.24,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: fullname.toString(),
                            children: const [
                              TextSpan(
                                text: '\n',
                                style: TextStyle(fontSize: 4),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    DataCell(Container(
                      margin: EdgeInsets.only(right: size.width * 0.05),
                      child: Text(''),
                    )),
                    DataCell(Text(
                      DateFormat('yyyy-MM-dd')
                          .format(DateTime.parse(asistencia.fecha.toString())),
                    )),
                    DataCell(Container(
                      margin: EdgeInsets.only(right: size.width * 0.15),
                      child: Text(''),
                    )),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          //editar registro
                        },
                      ),
                    ),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          //borrar registro
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
              columnSpacing: size.width * 0.025,
              dividerThickness: 2,
              horizontalMargin: 5,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Existing code for adding a new record
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}


// class Registro {
//   final String name;
//   final DateTime date;

//   Registro(this.name, this.date);
// }

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

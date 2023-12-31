import 'package:flutter/material.dart';
import 'package:gym_h/darkmode/theme_provider.dart';
import 'package:gym_h/models/attendance_record_model.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//TODO: agregarle los colores
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
    fullname = widget.usuario;

    if (fullname != null) {
      _getData();
    } else {
      _getDataGeneral();
    }
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
      Utils.showSnackBar('Error: ${e.toString()}');
    }
  }

  Future<void> _getDataGeneral() async {
    try {
      final data = await readAsistenciasGeneral();
      setState(() {
        listaAsistencia = data;
      });
    } catch (e) {
      Utils.showSnackBar('Error: ${e.toString()}');
    }
  }

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(),
      darkTheme: ThemeData.dark().copyWith(),
      themeMode:
      themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Registros'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                themeProvider.appBarColor1,
                themeProvider.appBarColor2,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
          ),
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
                      'Nombre:',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                    ),
                  ),
                ),
                DataColumn(label: Text('')),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Fecha:',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                    ),
                  ),
                ),
                DataColumn(label: Text('')),
                DataColumn(label: 
                  Text(
                    'Editar',
                    style:
                      TextStyle(fontSize: 16),
                  )
                ),
                DataColumn(label:
                  Text(
                    'Borrar',
                    style:
                      TextStyle(fontSize: 16),
                  )
                )
              ],
              rows: listaAsistencia.map((asistencia) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(Text(asistencia.fullname.toString())),
                    DataCell(Container(
                      margin: EdgeInsets.only(right: size.width * 0.05),
                      child: const Text(''),
                    )),
                    DataCell(Text(
                      DateFormat('yyyy-MM-dd')
                          .format(DateTime.parse(asistencia.fecha.toString())),
                    )),
                    DataCell(Container(
                      margin: EdgeInsets.only(right: size.width * 0.15),
                      child: const Text(''),
                    )),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          nombreController.text =
                              asistencia.fullname.toString();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Modificar Registro'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    TextField(
                                      controller: nombreController,
                                      decoration: const InputDecoration(
                                          labelText: 'Nombre:'),

                                      //que solo deje poner los de la base de datos y que haga busquedas que coincidan con lo que se va escribiendo?
                                    ),
                                    TextField(
                                      controller: fechaController,
                                      decoration: const InputDecoration(
                                          labelText: 'Fecha:',
                                          icon: Icon(Icons.calendar_today)),
                                      readOnly:
                                          true, //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(
                                                    2023), //DateTime.now() - not to allow to choose before today.
                                                lastDate: DateTime
                                                    .now()); //la ultima fecha que puede escoger es la de hoy
                                        if (pickedDate != null) {
                                          // print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          // print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                          //you can implement different kind of Date Format here according to your requirement

                                          setState(() {
                                            fechaController.text =
                                                formattedDate; //set output date to TextField value.
                                            //Mandarlo a la base de datos
                                          });
                                        } else {
                                          Utils.showSnackBar(
                                              "Date is not selected");
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
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states){
                                          return Colors.transparent;
                                        }
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            themeProvider.buttonColor1,
                                            themeProvider.buttonColor2,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        'Cancelar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      )
                                    )
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final nombre = nombreController.text;
                                      final fechaStr = fechaController.text;
                                      // final fecha = '';
                                      //     DateFormat('yyyy-MM-dd').parse(fechaStr, true);
                                      if (nombre.isNotEmpty &&
                                          fechaStr.isNotEmpty) {
                                        // Crear un objeto AsistenciaService con los nuevos datos
                                        final nuevaAsistencia =
                                            AsistenciaService(
                                          fullname: nombre,
                                          fecha: fechaStr,
                                          // Agrega otros campos según la definición de AsistenciaService
                                        );
                                        // Llamar a la función de actualización
                                        await updateAsistencia(
                                            asistencia.fecha.toString(),
                                            nuevaAsistencia,
                                            asistencia.fullname.toString());

                                        // Limpiar controladores y cerrar el cuadro de diálogo
                                        nombreController.clear();
                                        fechaController.clear();
                                        Navigator.of(context).pop();
                                        if (fullname != null) {
                                          _getData();
                                        } else {
                                          _getDataGeneral();
                                        }
                                      } else {
                                        Utils.showSnackBar(
                                            "El nombre y la fecha son obligatorios");
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states){
                                          return Colors.transparent;
                                        }
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            themeProvider.buttonColor1,
                                            themeProvider.buttonColor2,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        'Guardar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      )
                                    )
                                  ),
                                ],
                              );
                            },
                          );
                          //editar registro
                        },
                      ),
                    ),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Muestra un AlertDialog para confirmar la eliminación
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirmación'),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                        '¿Estás seguro de eliminar esta asistencia?'),
                                    const SizedBox(height: 10),
                                    Text('Nombre: ${asistencia.fullname}'),
                                    Text(
                                        'Fecha: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(asistencia.fecha.toString()))}'),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      // Cierra el AlertDialog y no realiza ninguna acción
                                      Navigator.of(context).pop();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states){
                                          return Colors.transparent;
                                        }
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            themeProvider.buttonColor1,
                                            themeProvider.buttonColor2,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        'Cancelar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      )
                                    )
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      // Elimina la asistencia y realiza las acciones necesarias
                                      await deleteAsistencia(
                                          asistencia.fecha.toString(),
                                          asistencia.fullname.toString());

                                      if (fullname != null) {
                                        _getData();
                                      } else {
                                        _getDataGeneral();
                                      }

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Asistencia eliminada con éxito'),
                                        ),
                                      );

                                      Navigator.of(context)
                                          .pop(); // Cierra el AlertDialog
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states){
                                          return Colors.transparent;
                                        }
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            themeProvider.buttonColor1,
                                            themeProvider.buttonColor2,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        'Eliminar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      )
                                    )
                                  ),
                                ],
                              );
                            },
                          );
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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Agregar Registro'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: nombreController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre:',
                        ),

                        //que solo deje poner los de la base de datos y que haga busquedas que coincidan con lo que se va escribiendo?
                      ),
                      TextField(
                        controller: fechaController,
                        decoration: const InputDecoration(
                            labelText: 'Fecha:',
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
                            Utils.showSnackBar("Date is not selected");
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states){
                            return Colors.transparent;
                          }
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              themeProvider.buttonColor1,
                              themeProvider.buttonColor2,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        )
                      )
                    ),
                    TextButton(
                      onPressed: () async {
                        final nombre = nombreController.text;
                        final fechaStr = fechaController.text;
                        if (nombre.isNotEmpty && fechaStr.isNotEmpty) {
                          // Llamada al método addAsistenciaUsuario con nombre y fecha
                          await addAsistenciaUsuarioFecha(nombre, fechaStr);

                          // Limpiar controladores y cerrar el cuadro de diálogo
                          nombreController.clear();
                          fechaController.clear();
                          Navigator.of(context).pop();
                          if (fullname != null) {
                            _getData();
                          } else {
                            _getDataGeneral();
                          }
                        } else {
                          Utils.showSnackBar(
                              "El nombre y la fecha son obligatorios");
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states){
                            return Colors.transparent;
                          }
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              themeProvider.buttonColor1,
                              themeProvider.buttonColor2,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Aceptar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        )
                      )
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: Colors.transparent,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themeProvider.buttonColor1,
                  themeProvider.buttonColor2,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.add,
                color: themeProvider.iconsColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

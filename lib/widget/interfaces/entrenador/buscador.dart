import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:gym_h/darkmode/theme_provider.dart';
import 'package:gym_h/models/attendance_record_model.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:gym_h/widget/interfaces/entrenador/registrosH.dart';
import 'package:provider/provider.dart';

class Lista extends StatefulWidget {
  const Lista({super.key});

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  List<String> _suggestions = [];
  String? usuario;

  @override
  void initState() {
    super.initState();
    // Llamada al método para obtener usuarios y actualizar las sugerencias
    _actualizarListaDeSugerencias();
  }

  // Método para obtener usuarios y actualizar la lista de sugerencias
  void _actualizarListaDeSugerencias() async {
    try {
      final userList = await readUsers();
      if (userList != null) {
        setState(() {
          _suggestions =
              userList.map((user) => user['fullname'].toString()).toList();
        });
      }
    } catch (e) {
      Utils.showSnackBar('Error al obtener usuarios: $e');
    }
  }

  //String usuario = '';
  String searchValue = '';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: null,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                themeProvider.appBarColor1,
                themeProvider.appBarColor2,
              ],
            ),
          ),
          child: EasySearchBar(
            title: const Text(
              'Registro',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            elevation: 0.0,
            suggestions: _suggestions,
            iconTheme: IconThemeData(
              color: themeProvider.iconsColor2
            ),
            backgroundColor: Colors.transparent,
            onSearch: (value) {
              setState(() {
                searchValue = value;
              });
            },
            onSuggestionTap: (item) {
              usuario = searchValue;
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(height: 45),
              const Text(
                'Nombre de usuario:',
                style: TextStyle(fontSize: 16),
              ),
              Container(height: 10),
              Text(
                usuario ?? 'usuario',
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
              Container(height: 45),
              Container(
                width: 360,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      themeProvider.buttonColor1,
                      themeProvider.buttonColor2,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    icon: const Icon(Icons.app_registration, size: 32),
                    label: const Text(
                      'Registrar Asistencia',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmación de Registro'),
                            content: Text(
                                '¿Estás seguro de que deseas registrar a $usuario?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Cierra el AlertDialog
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Colors.transparent;
                                    },
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
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Realiza la lógica de registro aquí
                                  addAsistenciaUsuario(usuario!);
                                  // Puedes agregar código para manejar el registro
                                  Navigator.of(context).pop();
                                  usuario = null;
                                  // Cierra el AlertDialog
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Colors.transparent;
                                    },
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
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } //recordar registrar bajo el nombre de
                    ),
              ),
            ],
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: () async {
                final route = MaterialPageRoute(
                  builder: (context) => RegistroH(usuario: usuario),
                );
                // Espera a que la ruta se complete y recibe el valor devuelto por la pantalla RegistroH
                final result = await Navigator.push(context, route);

                // Verifica si el valor de result es null y actualiza usuario en consecuencia
                if (result == null) {
                  setState(() {
                    usuario = null;
                  });
                }
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
                    Icons.history,
                    color: themeProvider.iconsColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

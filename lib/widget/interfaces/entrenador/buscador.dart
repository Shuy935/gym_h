import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:gym_h/darkmode/theme_provider.dart';
import 'package:gym_h/models/attendance_record_model.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:gym_h/widget/interfaces/entrenador/registrosH.dart';
import 'package:provider/provider.dart';

class Lista extends StatefulWidget {
  const Lista({Key? key}) : super(key: key);

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
      print('Error al obtener usuarios: $e');
    }
  }

  //String usuario = '';
  String searchValue = '';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text('Registro'),
        suggestions: _suggestions,
        onSearch: (value) {
          setState(() {
            searchValue = value;
          });
        },
        onSuggestionTap: (item) {
          usuario = searchValue;
        },
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(height: 10),
              Text(
                'Nombre de usuario:',
                style: const TextStyle(fontSize: 16),
              ),
              Container(height: 10),
              Text(
                '${usuario ?? 'usuario'}',
                style: const TextStyle(fontSize: 20),
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
                              child: const Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Cierra el AlertDialog
                              },
                            ),
                            TextButton(
                              child: const Text('Aceptar'),
                              onPressed: () {
                                // Realiza la lógica de registro aquí
                                addAsistenciaUsuario(usuario!);
                                // Puedes agregar código para manejar el registro
                                Navigator.of(context)
                                    .pop(); 
                                usuario=null;    
                                // Cierra el AlertDialog
                              },
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
              foregroundColor: Colors.black,
              elevation: 20,
              backgroundColor: Colors.amber,
              shape: const CircleBorder(),
              splashColor: Colors.white,
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
              child: const Icon(Icons.history),
            ),
          ),
        ],
      ),
    );
  }
}

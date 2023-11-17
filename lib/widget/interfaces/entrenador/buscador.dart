import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:gym_h/models/attendance_record_model.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:gym_h/widget/interfaces/entrenador/registrosH.dart';

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
                'Usuario a registrar:\n$usuario',
                style: const TextStyle(fontSize: 25),
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(Icons.app_registration, size: 32),
                  label: const Text(
                    'Registrar',
                    style: TextStyle(fontSize: 24),
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

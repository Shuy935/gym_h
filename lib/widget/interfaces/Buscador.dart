import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/RegistrosH.dart';

class Lista extends StatefulWidget {
  Lista({Key? key}) : super(key: key);

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  final List<String> _suggestions = [
    'Hana song',
    'Gabriel reyes',
    'Ana amari',
  ];
  String Usuario = ''; //get del seleccionado
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
          Usuario = searchValue;
        },
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(height: 10),
              Text(
                'Usuario a registrar:\n$Usuario',
                style: TextStyle(fontSize: 25),
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    minimumSize: Size.fromHeight(50),
                  ),
                  icon: Icon(Icons.app_registration, size: 32),
                  label: Text(
                    'Registrar',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmación de Registro'),
                          content: Text(
                              '¿Estás seguro de que deseas registrar a $Usuario?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Cierra el AlertDialog
                              },
                            ),
                            TextButton(
                              child: Text('Aceptar'),
                              onPressed: () {
                                
                                // Realiza la lógica de registro aquí
                                // Puedes agregar código para manejar el registro
                                Navigator.of(context).pop(); // Cierra el AlertDialog
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
              onPressed: () {
                final route =
                    MaterialPageRoute(builder: (context) => RegistroH());
                Navigator.push(context, route);
              },
              child: const Icon(Icons.history),
            ),
          ),
        ],
      ),
    );
  }
}

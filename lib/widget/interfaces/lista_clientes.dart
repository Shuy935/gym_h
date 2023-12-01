import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/widgets.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:gym_h/models/users_model.dart';

class Lista_Clientes extends StatefulWidget {
  const Lista_Clientes({super.key});

  @override
  State<Lista_Clientes> createState() => _Lista_ClientesState();
}

class _Lista_ClientesState extends State<Lista_Clientes> {
  List<bool> isSelected = []; // Lista para el estado de los botones
  List<Cliente> dataFromDatabase =
      []; // Lista para los datos de la base de datos
  List<String> _suggestions = [];
  String cliente = '';
  int selectedId = 0;
  String searchValue = '';

  @override
  void initState() {
    super.initState();
    dataFromDatabase = [
      //Lista de los clientes (nombre)
    ];
    _actualizarListaDeSugerencias();
  }

  //construye la lista de clientes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text('Cliente'),
        suggestions: _suggestions,
        onSearch: (value) {
          setState(() {
            searchValue = value;
          });
        },
        onSuggestionTap: (item) {
          setState(() {
            cliente = searchValue;
            // Agrega el cliente seleccionado a dataFromDatabase si no existe
            if (!dataFromDatabase.any((element) => element.name == cliente)) {
              dataFromDatabase
                  .add(Cliente(cliente, dataFromDatabase.length + 1));
            }
          });
        },
      ),
      body: ListView.builder(
        itemCount: dataFromDatabase.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedId = dataFromDatabase[index].id;
                    cliente = dataFromDatabase[index].name;
                    print(cliente);
                  });
                },
                child: Container(
                  height: 40,
                  width: 200,
                  child: Row(
                    children: [
                      Radio(
                        value: dataFromDatabase[index].id,
                        groupValue: selectedId,
                        onChanged: (value) {
                          // No es necesario implementar onChanged aquí, ya que el GestureDetector manejará los toques.
                        },
                      ),
                      Text(dataFromDatabase[index].name),
                    ],
                  ),
                )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Agregar una condicion para que esté uno seleccionado
        //  print(cliente);
          if (cliente == '') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: const Text('Por favor escoja un cliente'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Aceptar'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Cierra el AlertDialog
                        },
                      ),
                    ],
                  );
                });
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirmación de Selección'),
                  content: Text(
                      '¿Estás seguro de que deseas asignar rutina a $cliente?'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Cierra el AlertDialog
                      },
                    ),
                    TextButton(
                      child: const Text('Aceptar'),
                      onPressed: () {
                        // mandamos el cliente seleccionado
                        print(cliente);
                        Navigator.of(context).pop();
                        // cliente = '';
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiasScrn(cliente: cliente),
                            ));
                        // Cierra el AlertDialog
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  // Método para obtener usuarios y actualizar la lista de sugerencias
  void _actualizarListaDeSugerencias() async {
    try {
      final searchValue = await readUsers();
      if (searchValue != null) {
        setState(() {
          _suggestions =
              searchValue.map((user) => user['fullname'].toString()).toList();
        });
      }
    } catch (searchValue) {
      print('Error al obtener usuarios: $searchValue');
    }
  }
}

class Cliente {
  //modelo para la lista de los clientes
  final String name;
  final int id;

  Cliente(this.name, this.id);
}

//todo
/*class Lista extends StatefulWidget {
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
                                Navigator.of(context).pop();
                                usuario = null;
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
*/

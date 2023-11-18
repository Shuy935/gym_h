import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/widgets.dart';

class Lista_Clientes extends StatefulWidget {
  const Lista_Clientes({super.key});

  @override
  State<Lista_Clientes> createState() => _Lista_ClientesState();
}

class _Lista_ClientesState extends State<Lista_Clientes> {
  List<bool> isSelected = []; // Lista para el estado de los botones
  List<Cliente> dataFromDatabase =
      []; // Lista para los datos de la base de datos
  int selectedId = 0;

  @override
  void initState() {
    super.initState();
    // Simulando la recuperación de datos de la base de datos
    dataFromDatabase = [
      Cliente('Juana Perez', 1),
      Cliente('Peter Parker', 2),
      Cliente('Sofía Lopez', 3),
      Cliente('Canela Solís', 4)
    ];
    isSelected = List.generate(dataFromDatabase.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: dataFromDatabase.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(dataFromDatabase[index].name), //nombre del cliente
            leading: Radio(
              //Para seleccionarlo
              focusColor: Colors.amber,
              value: dataFromDatabase[index].id, //lo que vale la seleccion?
              groupValue: isSelected,
              onChanged: (value) {
                setState(() {
                  //isSelected = dataFromDatabase[index]; //asignación del grupo al valor
                  value = true;
                  print(dataFromDatabase[index].name);
                  selectedId = dataFromDatabase[index].id;
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Agregar una condicion para que esté uno seleccionado
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DiasScrn(/*Mandar el Cliente seleccionado */),
              ));
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

class Cliente {
  final String name;
  final int id;

  Cliente(this.name, this.id);
}

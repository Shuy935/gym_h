import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/widgets.dart';

enum ClienteNom { lafayette, jefferson, Juana, Peter }

//Lista con los nombres de los clientes
final List<String> nombre_clientes = [];

class Lista_Clientes extends StatefulWidget {
  const Lista_Clientes({super.key});

  @override
  State<Lista_Clientes> createState() => _Lista_ClientesState();
}

class _Lista_ClientesState extends State<Lista_Clientes> {
  ClienteNom? _character = ClienteNom.lafayette;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ListTile(
            title: const Text('Juana Perez'), //nombre del cliente
            leading: Radio<ClienteNom>(
              //Para seleccionarlo
              value: ClienteNom.Juana, //lo que vale la seleccion?
              groupValue: _character, //se pueden agrupar?
              onChanged: (ClienteNom? value) {
                setState(() {
                  _character = value; //asignación del grupo al valor
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Thomas Jefferson'),
            leading: Radio<ClienteNom>(
              value: ClienteNom.jefferson,
              groupValue: _character,
              onChanged: (ClienteNom? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Peter Parker'),
            leading: Radio<ClienteNom>(
              value: ClienteNom.Peter,
              groupValue: _character,
              onChanged: (ClienteNom? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
        ],
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

import 'package:flutter/material.dart';

class Registrar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar')),
      body: Column(
        children: <Widget>[
          Text('Registrar', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          Container(
            // Contenedor con la foto
            // Puedes agregar la imagen aquí
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          Row(
            children: <Widget>[
              Text('Nombre de usuario'),
              // Textfield para el nombre de usuario
            ],
          ),
          Row(
            children: <Widget>[
              Text('Contraseña'),
              // Textfield para la contraseña
            ],
          ),
          Row(
            children: <Widget>[
              Text('Confirmar Contraseña'),
              // Textfield para confirmar la contraseña
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para el registro
            },
            child: Text('Registrarse'),
          ),
        ],
      ),
    );
  }
}

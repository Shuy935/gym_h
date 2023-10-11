import 'package:flutter/material.dart';
import 'package:peliculas_2023/screens/IniciarSesion.dart';// Importa la pantalla de Iniciar Sesión

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GYM H'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              // Navega a la pantalla de Iniciar Sesión al hacer clic en el icono.
              Navigator.push(context, MaterialPageRoute(builder: (context) => IniciarSesion()));
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Text('GYM H', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          // Otros elementos de la página principal
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:peliculas_2023/screens/Registrar.dart';// Importa la pantalla de Registrar

class IniciarSesion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Column(
        children: <Widget>[
          Text('Iniciar Sesión', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
          GestureDetector(
            child: Text('¿Olvidó su contraseña?'),
            onTap: () {
              // Lógica para manejar el olvido de contraseña
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para iniciar sesión
            },
            child: Text('Iniciar Sesión'),
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          GestureDetector(
            child: Text('¿No tienes cuenta? Regístrate aquí'),
            onTap: () {
              // Navega a la pantalla de Registrar al hacer clic en el texto.
              Navigator.push(context, MaterialPageRoute(builder: (context) => Registrar()));
            },
          ),
        ],
      ),
    );
  }
}

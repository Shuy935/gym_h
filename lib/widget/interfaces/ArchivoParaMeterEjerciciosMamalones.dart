import 'package:flutter/material.dart';

class EjerciciosAdd extends StatelessWidget {
  const EjerciciosAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 120,
              child: Text('Nombre del ejercicio: '),
            ),
            Expanded(
              child: TextFormField(
                // se cambiará por un dropdown
                decoration: InputDecoration(
                  hintText: 'asd',
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 120,
              child: Text('Descanso recomendado: '),
            ),
            Expanded(
              child: TextFormField(
                // se cambiará por un dropdown
                decoration: InputDecoration(
                  hintText: 'asd',
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 120,
              child: Text('dificultad: '),
            ),
            Expanded(
              child: TextFormField(
                // se cambiará por un dropdown
                decoration: InputDecoration(
                  hintText: 'asd',
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 120,
              child: Text('nombre del musculo: '),
            ),
            Expanded(
              child: TextFormField(
                // se cambiará por un dropdown
                decoration: InputDecoration(
                  hintText: 'asd',
                ),
              ),
            ),
          ],
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              minimumSize: Size.fromHeight(50),
            ),
            icon: Icon(Icons.sports_gymnastics, size: 32),
            label: Text(
              'Subir ejercicio',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirmación de Registro'),
                    content: Text(
                        'Subir'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Cierra el AlertDialog
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
    ));
  }
}

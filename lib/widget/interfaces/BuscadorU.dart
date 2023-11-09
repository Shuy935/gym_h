import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';

class ListaU extends StatefulWidget {
  ListaU({Key? key}) : super(key: key);

  @override
  _ListaUState createState() => _ListaUState();
}

class _ListaUState extends State<ListaU> {
  String Usuario = 'manolo'; //get del usuario actual

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            onPressed: null
            //aqui ira el registro de asistencia del usuario actual
            ,
          ),
        ],
      ),
    );
  }
}

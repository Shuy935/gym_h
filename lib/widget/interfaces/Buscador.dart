import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';

class ListaU extends StatefulWidget {
  ListaU({Key? key}) : super(key: key);

  @override
  _ListaUState createState() => _ListaUState();
}

class _ListaUState extends State<ListaU> {
  final List<String> _suggestions = [
    'Puto programa de cagada',
    'Ya me tiene hasta la madre',
    'Aqui ira el get de los usuarios',
  ];
  String Usuario = '';
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
            //se supone que aqui ira el get con el valor de Usuario
            ,
          ),
        ],
      ),
    );
  }
}

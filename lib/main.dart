import 'package:flutter/material.dart';
import 'package:peliculas_2023/screens/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //quitar la madre del debug pq me estorbaba
      title: 'GymH',
      initialRoute: 'home',
      routes: {'home': (_) => HomePage(),},
    );
  }
}
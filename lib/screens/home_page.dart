// import 'dart:async';
// import 'dart:convert';
import 'package:gym_h/screens/user/Interfaces.dart';
// import 'package:http/http.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Interfaces(),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(colors: [
      //       Colors.orange.shade300,
      //       Colors.orange.shade100,
      //       Colors.white
      //     ]),
      //   ),
      //   child: ElevatedButton.icon(
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: Colors.transparent,
      //       minimumSize: Size.fromHeight(50),
      //     ),
      //     icon: Icon(Icons.arrow_back, size: 32),
      //     label: Text(
      //       'Sign Out',
      //       style: TextStyle(fontSize: 24),
      //     ),
      //     onPressed: FirebaseAuth.instance.signOut,
      //   ),
      // ),
    );
  }
}

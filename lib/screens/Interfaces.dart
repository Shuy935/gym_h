import 'package:flutter/material.dart';
import 'package:gym_h/widget/consejos.dart';
import 'package:gym_h/widget/tapbar.dart';
import 'package:provider/provider.dart';

class Interfaces extends StatelessWidget {
  const Interfaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
  children: [
    TabBarH(),
    //ConsejosB(),
  ],
),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.orange.shade300,
            Colors.orange.shade100,
            Colors.white
          ]),
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            minimumSize: Size.fromHeight(50),
          ),
          icon: Icon(Icons.arrow_back, size: 32),
          label: Text(
            'Sign Out',
            style: TextStyle(fontSize: 24),
          ),
          onPressed: null,
        ),
      ),
    );
  }
}

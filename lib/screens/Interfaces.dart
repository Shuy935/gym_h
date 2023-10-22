import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/consejos.dart';
import 'package:gym_h/widget/interfaces/tapbar.dart';
import 'package:provider/provider.dart';

class Interfaces extends StatelessWidget {
  const Interfaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TabBarH(),
          // ConsejosB(),
        ],
      ),
    );
  }
}

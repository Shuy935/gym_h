import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/widgets.dart';

class Interfaces extends StatelessWidget {
  const Interfaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TabBarH(),
          ConsejosB(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/Widgets.dart';

class Interfaces extends StatelessWidget {
  const Interfaces({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          TabBarH(),
          ConsejosB(),
        ],
      ),
    );
  }
}
 
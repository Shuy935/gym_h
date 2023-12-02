import 'package:flutter/material.dart';
import 'package:gym_h/darkmode/theme_provider.dart';
import 'package:gym_h/widget/interfaces/Widgets.dart';
import 'package:provider/provider.dart';

class Interfaces extends StatelessWidget {
  const Interfaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          body: Stack(
            children: [
              TabBarH(),
              ConsejosB(),
            ],
          ),
        );
      },
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsejosBState {
  bool isVisible = true;
  double top = 200.0;
  double left = 200.0;
}

// class ConsejosBProvider extends ChangeNotifier {
//   ConsejosBState _state = ConsejosBState();

//   ConsejosBState get state => _state;

//   void updateState(ConsejosBState newState) {
//     _state = newState;
//     notifyListeners();
//   }
// }

class ConsejosB extends StatefulWidget {
  const ConsejosB({super.key});

  @override
  _ConsejosBState createState() => _ConsejosBState();
}

class _ConsejosBState extends State<ConsejosB> {
  bool isVisible = true;
  double top = 200.0;
  double left = 200.0;

//Este es el Show Dialog donde van a ir los consejos so... editar aquí
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return const SimpleDialog(
          title: Text('Consejo:'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Test'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Hacer el provider de los consejos
    // final consejosBProvider =
    //     Provider.of<ConsejosBProvider>(context, listen: false);
    // final state = consejosBProvider.state;
    //Obtener tamaño de pantalla para que el botón no se salga
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonSize = 60.0;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: top,
            left: left,
            child: Visibility(
              visible: isVisible,
              child: GestureDetector(
                onPanUpdate: (details) {
                  double newTop = top + details.delta.dy;
                  double newLeft = left + details.delta.dx;

                  //Usamos clamp para el límite superior y el izquierdo
                  newTop = newTop.clamp(0.0, screenHeight - buttonSize);
                  newLeft = newLeft.clamp(0.0, screenWidth - buttonSize);
                  //Usamos clamp para el límite inferior menos 100 pixeles para que se detenga justito uwu
                  if (newTop > screenHeight - buttonSize - 100.0) {
                    newTop = screenHeight - buttonSize - 100.0;
                  }

                  setState(() {
                    top = newTop;
                    left = newLeft;
                  });
                },
                onTap: () {
                  setState(() {
                    isVisible = false;
                  });
                  //Despliega el showDialog
                  _showDialog(context);
                  //Tiempo en segundos antes de que el botón vuelva a aparecer
                  Timer(const Duration(seconds: 5), () {
                    setState(() {
                      isVisible = true;
                    });
                  });
                },
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
<<<<<<< HEAD
import 'dart:math';
import 'package:flutter/material.dart';
=======
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_h/models/crud.dart';
import 'package:gym_h/widget/interfaces/tapbar.dart';
>>>>>>> d235c1232fcb13b2c1d94fe619f8637f9cf48119

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
  final Stream<QuerySnapshot> collectionReference = Crud.readAdvices();
  bool isVisible = true;
  double top = 200.0;
  double left = 200.0;
  List<String> consejos = [
    'Come pollito',
    'Consumir arroz antes de el entrenamiento ayuda al bombeo',
    'Asegurate de consumir las calorias necesarias segun tus propositos',
    'Este es otro consejo xd',
  ];

//Este es el Show Dialog donde van a ir los consejos so... editar aquí
// , AsyncSnapshot<QuerySnapshot> e
  void _showDialog(BuildContext context) {
    final random = Random();
    final consejoAleatorio = consejos[random.nextInt(consejos.length)];
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: Text('Consejo:'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text(consejoAleatorio),
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

    // return Scaffold(
    //   body: StreamBuilder(
    //     stream: collectionReference,
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       if (!snapshot.hasData) return const Text('no found');
    //       return Stack(
    //         children: <Widget>[
    //           snapshot.data.docs(
    //             (e) {
    //               Positioned(
    //                 top: top,
    //                 left: left,
    //                 child: Visibility(
    //                   visible: isVisible,
    //                   child: GestureDetector(
    //                     onPanUpdate: (details) {
    //                       double newTop = top + details.delta.dy;
    //                       double newLeft = left + details.delta.dx;

    //                       newTop = newTop.clamp(0.0, screenHeight - buttonSize);
    //                       newLeft =
    //                           newLeft.clamp(0.0, screenWidth - buttonSize);

    //                       if (newTop > screenHeight - buttonSize - 100.0) {
    //                         newTop = screenHeight - buttonSize - 100.0;
    //                       }

    //                       setState(() {
    //                         top = newTop;
    //                         left = newLeft;
    //                       });
    //                     },
    //                     onTap: () {
    //                       setState(() {
    //                         isVisible = false;
    //                       });

    //                       _showDialog(context, e);

    //                       Timer(const Duration(seconds: 5), () {
    //                         setState(() {
    //                           isVisible = true;
    //                         });
    //                       });
    //                     },
    //                     child: Container(
    //                       width: 60.0,
    //                       height: 60.0,
    //                       decoration: const BoxDecoration(
    //                         shape: BoxShape.circle,
    //                         color: Colors.blue,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             },
    //           )
    //         ],
    //       );
    //     },
    //   ),
    // );

    return Stack(
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

                newTop = newTop.clamp(0.0, screenHeight - buttonSize);
                newLeft = newLeft.clamp(0.0, screenWidth - buttonSize);

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

                _showDialog(context);

                Timer(const Duration(seconds: 1), () {
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
    );
  }
}

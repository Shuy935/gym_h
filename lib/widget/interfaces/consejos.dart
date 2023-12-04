import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gym_h/darkmode/theme_provider.dart';
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
  State<ConsejosB> createState() => _ConsejosBState();
}

class _ConsejosBState extends State<ConsejosB> {
  bool isVisible = true;
  double top = 200.0;
  double left = 200.0;
  List<String> consejos = [
    'Suplementos: \nSi consideras tomar suplementos, asegúrate de que se alineen con tus necesidades y objetivos. Consulta con un profesional de la salud o un nutricionista antes de tomar cualquier suplemento',
    'Consume suficientes proteínas: \nSon esenciales para la reparación y el crecimiento muscular. Fuentes: carne, pescado, huevos, lácteos, legumbres, tofu, etc.',
    'Incluye carbohidratos en tu dieta: \nSon la principal fuente de energía para el ejercicio. Fuentes: arroz, pasta, pan, patatas, frutas, verduras, etc.',
    'No descuides las grasas saludables: \nAyudan en la absorción de vitaminas y en la producción de hormonas. Fuentes: aguacate, frutos secos, aceite de oliva, pescado graso, etc.',
    'Hidrátate adecuadamente: \nBebe suficiente agua antes, durante y después del ejercicio para mantener un buen rendimiento y recuperación.',
    'Planifica tus comidas: \nCome cada 3-4 horas para mantener un flujo constante de nutrientes y energía.',
    'Consume alimentos ricos en antioxidantes: \nAyudan a reducir el daño muscular y la inflamación. Fuentes: frutas, verduras, frutos secos, especias, etc.',
    'Evita los alimentos procesados y azucarados: \nOpta por alimentos naturales y evita el exceso de azúcares añadidos.',
    'No te saltes el desayuno: \nEs una comida importante que te proporciona energía para el día y para tu entrenamiento.',
    'Cuida la alimentación pre y post-entrenamiento: \nConsume carbohidratos y proteínas antes y después del ejercicio para optimizar el rendimiento y la recuperación.',
    'Consulta a un profesional: \nUn nutricionista o dietista puede ayudarte a planificar una dieta personalizada según tus objetivos y necesidades',
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
          title: const Text('Consejo:'),
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
    double buttonSize = 45.0;

    final themeProvider = Provider.of<ThemeProvider>(context);

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

                if (newTop > screenHeight - buttonSize ) {
                  newTop = screenHeight - buttonSize;
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

                Timer(const Duration(seconds: 10), () {
                  setState(() {
                    isVisible = true;
                  });
                });
              },
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      themeProvider.buttonColor1,
                      themeProvider.buttonColor2,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.flatware_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

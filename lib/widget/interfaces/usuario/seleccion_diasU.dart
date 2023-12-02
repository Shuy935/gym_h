import 'package:flutter/material.dart';
import 'package:gym_h/darkmode/theme_provider.dart';
import 'package:gym_h/widget/interfaces/widgets.dart';
import 'package:provider/provider.dart';

class DiasScrnU extends StatefulWidget {
  const DiasScrnU({super.key});

  @override
  State<DiasScrnU> createState() => _DiasScrnUState();
}

class _DiasScrnUState extends State<DiasScrnU> {
  late ThemeProvider themeProvider;
  List<String> selectedDias = [];
  final List<String> dias = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];
  List<String> filtereDia = [];

  @override
  void initState() {
    filtereDia = dias;
    super.initState();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 27,
          ),
          ListTile(
            title: Text(
              'Selecciona los días \n  en que deseas asignar tus rutinas:',
              style: TextStyle(
                fontSize: 20,
                color: themeProvider.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(margin: const EdgeInsets.only(bottom: 30)),
          Expanded(
            child: buildDiasList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleFloatingActionButton,
        backgroundColor: Colors.transparent,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                themeProvider.buttonColor1,
                themeProvider.buttonColor2,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_forward,
              color: themeProvider.iconsColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDiasList() {
    return ListView(
      children: filtereDia.map(buildDiasItem).toList(),
    );
  }

  Widget buildDiasItem(String dia) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ListTile(
      title: Text(dia),
      onTap: () => handleDiasSelection(dia),
      trailing: selectedDias.contains(dia)
          ? Icon(Icons.check_circle, color: themeProvider.checkBoxColor)
          : const Icon(Icons.check_circle_outline),
    );
  }

  void handleDiasSelection(String dia) {
    if (selectedDias.contains(dia)) {
      setState(() {
        selectedDias.remove(dia);
      });
    } else if (selectedDias.isEmpty) {
      setState(() {
        selectedDias.add(dia);
      });
    } else if (selectedDias.length == 1) {
      //Restricción de días
      setState(() {
        selectedDias.clear();
        selectedDias.add(dia);
      });
    } else {
      showSelectionError('Solo puedes seleccionar un máximo de 1 día.');
    }
  }

  void handleFloatingActionButton() {
    //acción del botón
    selectedDias.isNotEmpty
        ? navigateToMusclesScreen()
        : showSelectionError('No seleccionaste ningún día aún.');
  }

  void navigateToMusclesScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MuscleScrn(selectedDias: selectedDias),
      ),
    );
  }

  void showSelectionError(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Advertencia'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return Colors.transparent;
                  },
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      themeProvider.buttonColor1,
                      themeProvider.buttonColor2,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Aceptar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

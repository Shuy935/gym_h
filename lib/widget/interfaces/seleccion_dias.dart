import 'package:flutter/material.dart';
import 'package:gym_h/darkmode/theme_provider.dart';
import 'package:gym_h/widget/interfaces/widgets.dart';
import 'package:provider/provider.dart';

class DiasScrn extends StatefulWidget {
  final String? cliente;
  const DiasScrn({super.key, this.cliente});

  @override
  State<DiasScrn> createState() => _DiasScrnState();
}

class _DiasScrnState extends State<DiasScrn> {
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
  late BuildContext dialogContext;

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
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                themeProvider.appBarColor1,
                themeProvider.appBarColor2,
              ],
            ),
          ),
        ),
        title: const Text('Selecciona los días en que \ndeseas asignar tus rutinas:'),
      ),
      body: Column(
        children: <Widget>[
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
    } else if (selectedDias.isEmpty) {
      //Restricción de días
      setState(() {
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
        builder: (context) =>
            MuscleScrn(selectedDias: selectedDias, cliente: widget.cliente),
      ),
    );
  }

  void showSelectionError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        dialogContext = context;
        return AlertDialog(
          title: const Text('Advertencia'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states){
                    return Colors.transparent;
                  }
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
                )
              )
            ),
          ],
        );
      },
    );
  }
}

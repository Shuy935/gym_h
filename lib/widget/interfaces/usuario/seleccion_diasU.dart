import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/widgets.dart';

class DiasScrnU extends StatefulWidget {
  const DiasScrnU({super.key});

  @override
  State<DiasScrnU> createState() => _DiasScrnUState();
}

class _DiasScrnUState extends State<DiasScrnU> {
  List<String> selectedDias = [];
  final List<String> dias = [
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sabado',
    'Domingo',
  ];
  List<String> filtereDia = [];

  @override
  void initState() {
    filtereDia = dias;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona el/los dia/s \n a asignar rutina'),
      ),
      body: Column(
        children: <Widget>[
          const ListTile(
            title: Text(
              'Selecciona el/los dia/s \n a asignar rutina',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: buildDiasList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleFloatingActionButton,
        child: Icon(Icons.arrow_forward),
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
          ? Icon(Icons.check_circle, color: Colors.green)
          : Icon(Icons.check_circle_outline),
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
    } else if (selectedDias.length < 2) {
      //Restricción de días
      setState(() {
        selectedDias.add(dia);
      });
    } else {
      showSelectionError('Solo puedes seleccionar un máximo de 2 días.');
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
          title: Text('Advertencia'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

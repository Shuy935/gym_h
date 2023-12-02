import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/widgets.dart';

class DiasScrn extends StatefulWidget {
  final String? cliente;
  const DiasScrn({super.key, this.cliente});

  @override
  State<DiasScrn> createState() => _DiasScrnState();
}

class _DiasScrnState extends State<DiasScrn> {
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
    print(widget.cliente);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona el/los dia/s \n a asignar rutina'),
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
        child: const Icon(Icons.arrow_forward),
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
          ? const Icon(Icons.check_circle, color: Colors.green)
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
    } else if (selectedDias.length < 1) {
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
      builder: (context) {
        return AlertDialog(
          title: const Text('Advertencia'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
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

import 'package:flutter/material.dart';
import 'package:gym_h/widget/interfaces/ejercicios.dart';

class MuscleScrn extends StatefulWidget {
  const MuscleScrn({super.key});

  @override
  State<MuscleScrn> createState() => _MuscleScrnState();
}

class _MuscleScrnState extends State<MuscleScrn> {
  final List<String> allMusc = [
    'Bíceps',
    'Tríceps',
    'Hombro',
    'Espalda',
    'Pecho',
    'Abdomen',
    'Glúteo',
    'Cuádriceps',
    'Femoral',
    'Pantorrilla',
  ];
  List<String> selectedMusc = [];
  String searching = '';

  List<String> filteredMusc = [];

  @override
  void initState() {
    filteredMusc = allMusc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona tus músculos'),
      ),
      body: Column(
        children: <Widget>[
          // ListTile(
          //   title: const Text(
          //     'Selecciona de 1-3 músculos',
          //     style: TextStyle(
          //       fontSize: 25,
          //       fontWeight: FontWeight.w900,
          //       color: Color.fromARGB(255, 255, 255, 255),
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          Expanded(
            child: buildMuscleList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleFloatingActionButton,
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  Widget buildSearchTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: handleSearch,
        decoration: InputDecoration(
          labelText: 'Buscar Músculos',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget buildMuscleList() {
    return ListView(
      children: filteredMusc.map(buildMuscleItem).toList(),
    );
  }

  Widget buildMuscleItem(String muscle) {
    return ListTile(
      title: Text(muscle),
      onTap: () => handleMuscleSelection(muscle),
      trailing: selectedMusc.contains(muscle)
          ? Icon(Icons.check_circle, color: Colors.green)
          : Icon(Icons.check_circle_outline),
    );
  }

  void handleSearch(String value) {
    setState(() {
      searching = value;
      filteredMusc = allMusc
          .where((muscle) =>
              muscle.toLowerCase().contains(searching.toLowerCase()))
          .toList();
    });
  }

  void handleMuscleSelection(String muscle) {
    if (selectedMusc.contains(muscle)) {
      setState(() {
        selectedMusc.remove(muscle);
      });
    } else if (selectedMusc.isEmpty) {
      setState(() {
        selectedMusc.add(muscle);
      });
    } else if (selectedMusc.length < 3) {
      setState(() {
        selectedMusc.add(muscle);
      });
    } else {
      showSelectionError('Solo puedes seleccionar un máximo de 3 músculos.');
    }
  }

  void handleFloatingActionButton() {
    selectedMusc.isNotEmpty
        ? navigateToRoutineScreen()
        : showSelectionError('No seleccionaste ningún músculo aún.');
  }

  void navigateToRoutineScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Ejercicios(selectedMusc: selectedMusc),
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

import 'package:flutter/material.dart';
import 'package:gym_h/darkmode/theme_provider.dart';
import 'package:gym_h/widget/interfaces/ejercicios.dart';
import 'package:provider/provider.dart';

class MuscleScrn extends StatefulWidget {
  final List<String> selectedDias;
  final String? cliente;
  const MuscleScrn({super.key, required this.selectedDias, this.cliente});

  @override
  State<MuscleScrn> createState() => _MuscleScrnState();
}

class _MuscleScrnState extends State<MuscleScrn> {
  late ThemeProvider themeProvider;
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
    'Antebrazo',
  ];
  List<String> selectedMusc = [];
  String searching = '';

  List<String> filteredMusc = [];

  @override
  void initState() {
    filteredMusc = allMusc;
    super.initState();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona tus músculos'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                themeProvider.appBarColor1,
                themeProvider.appBarColor2,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          /* ListTile(title: const Text('Selecciona de 1-3 músculos',style: TextStyle(
                 fontSize: 25,fontWeight: FontWeight.w900,color: Color.fromARGB(255, 255, 255, 255),),textAlign: TextAlign.center,),),
          */
          Expanded(
            child: buildMuscleList(),
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

  // Widget buildSearchTextField() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: TextField(
  //       onChanged: handleSearch,
  //       decoration: InputDecoration(
  //         labelText: 'Buscar Músculos',
  //         prefixIcon: const Icon(Icons.search),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10.0),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
          ? Icon(Icons.check_circle, color: themeProvider.checkBoxColor)
          : const Icon(Icons.check_circle_outline),
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
        builder: (context) => Ejercicios(
            selectedMusc: selectedMusc,
            selectedDias: widget.selectedDias,
            cliente: widget.cliente),
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
                    fontWeight: FontWeight.bold,
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

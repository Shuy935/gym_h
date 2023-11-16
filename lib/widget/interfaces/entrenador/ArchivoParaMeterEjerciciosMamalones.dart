import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gym_h/models/exercise_model.dart';
import 'package:image_picker/image_picker.dart';

class EjerciciosAdd extends StatefulWidget {
  const EjerciciosAdd({super.key});

  @override
  State<EjerciciosAdd> createState() => _EjerciciosAdd();
}
String _difucultad = "";
class _EjerciciosAdd extends State<EjerciciosAdd> {
  final _nomEje = TextEditingController();
  final _descanso = TextEditingController();
  final _nomMusc = TextEditingController();
  final _link = TextEditingController();
  TextEditingController textController = TextEditingController(text: 'Antebrazo');
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 120,
              child: const Text('Nombre del ejercicio: '),
            ),
            Expanded(
              child: TextFormField(
                controller: _nomEje,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: 'asd'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Porfavor de poner un nombre completo correcto';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 120,
              child: const Text('Descanso recomendado: '),
            ),
            Expanded(
              child: TextFormField(
                controller: _descanso,
                textInputAction: TextInputAction.next,
                // se cambiará por un dropdown
                decoration: const InputDecoration(hintText: 'asd'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Porfavor de poner un nombre completo correcto';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 120,
              child: const Text('dificultad: '),
            ),
            Expanded(
              child: Descanso(),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 120,
              child: const Text('nombre del musculo: '),
            ),
            Expanded(
              child: TextFormField(
                controller: textController,
                textInputAction: TextInputAction.next,
                // se cambiará por un dropdown
                decoration: const InputDecoration(hintText: 'asd'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Porfavor de poner un nombre completo correcto';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 120,
              child: const Text('link de ejemplo: '),
            ),
            Expanded(
              child: TextFormField(
                controller: _link,
                textInputAction: TextInputAction.next,
                // se cambiará por un dropdown
                decoration: const InputDecoration(hintText: 'asd'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Porfavor de poner un ahhhhh correcto';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              minimumSize: const Size.fromHeight(50),
            ),
            icon: const Icon(Icons.sports_gymnastics, size: 32),
            label: const Text(
              'Subir ejercicio',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () async {
              String descanso="";
              if(_difucultad=='Facil'){
                descanso = '45 segundos';
              }else if(_difucultad=='Intermedio'){
                descanso = '1 minuto';
              }else{
                descanso = '1 minuto y medio';
              }
              ExerciseService exerciseService = ExerciseService(
                nombreEjercicio: _nomEje.text,
                descanso: descanso,
                dificuldad: _difucultad,
                nombreMusculo: textController.text,
                linkImagen: _link.text,
              );
              await exerciseCreate(exerciseService);
            }
            //recordar registrar bajo el nombre de
            ),
            Container(height: 40,),
            ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              minimumSize: const Size.fromHeight(50),
            ),
            icon: const Icon(Icons.sports_gymnastics, size: 32),
            label: const Text(
              'Limpiar',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () async {
              textController.text='Pecho';
              _nomEje.text='';
              _link.text='';
            }
            //recordar registrar bajo el nombre de
            ),
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _descanso.dispose();
    _nomEje.dispose();
    _nomMusc.dispose();
  }
}

List<String> rep = ['Facil', 'Intermedio', 'Dificil'];
class Descanso extends StatefulWidget {
  const Descanso({super.key});

  @override
  State<Descanso> createState() => _DescansoState();
}

class _DescansoState extends State<Descanso> {
  String dropdownValue = rep.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: rep.first,
      width: 100,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          _difucultad = dropdownValue;
          print(dropdownValue);
        });
      },
      dropdownMenuEntries: rep.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}

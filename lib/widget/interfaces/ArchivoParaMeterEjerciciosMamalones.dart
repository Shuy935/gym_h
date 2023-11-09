import 'package:flutter/material.dart';
import 'package:gym_h/models/exercise_model.dart';

class EjerciciosAdd extends StatefulWidget {
  const EjerciciosAdd({super.key});

  @override
  State<EjerciciosAdd> createState() => _EjerciciosAdd();
}

class _EjerciciosAdd extends State<EjerciciosAdd> {
  final _formKey = GlobalKey<FormState>();
  final _nomEje = TextEditingController();
  final _descanso = TextEditingController();
  final _difucultad = TextEditingController();
  final _nomMusc = TextEditingController();
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
                // se cambiará por un dropdown
                controller: _nomEje,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'asd',
                ),
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
                decoration: const InputDecoration(
                  hintText: 'asd',
                ),
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
              child: TextFormField(
                controller: _difucultad,
                textInputAction: TextInputAction.next,
                // se cambiará por un dropdown
                decoration: const InputDecoration(
                  hintText: 'asd',
                ),
              ),
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
                controller: _nomMusc,
                textInputAction: TextInputAction.next,
                // se cambiará por un dropdown
                decoration: const InputDecoration(
                  hintText: 'asd',
                ),
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
              if (_formKey.currentState!.validate()) {
                await exerciseCreate(
                  nombreEjercicio: _nomEje,
                  descanso: _descanso,
                  dificultad: _difucultad,
                  nombreMusculo: _nomMusc,
                );
              }
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
    _difucultad.dispose();
    _nomEje.dispose();
    _nomMusc.dispose();
  }
}

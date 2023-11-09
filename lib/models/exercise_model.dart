import 'package:firebase_database/firebase_database.dart';

class ExerciseService {
  final String? nombreEjercicio;
  final int? descanso;
  final String? dificuldad;
  final String? nombreMusculo;

  ExerciseService({
    this.nombreMusculo,
    this.dificuldad,
    this.descanso,
    this.nombreEjercicio,
  });
}

DatabaseReference db = FirebaseDatabase.instance.ref().child('excercise');
exerciseCreate({nombreEjercicio, nombreMusculo, descanso, dificultad}) async {
  try {
    await db.push().set({
      "nombreEjercicio": nombreEjercicio,
      "descanso": descanso,
      "dificultad": dificultad,
      "nombreMusculo": nombreMusculo,
    });
  } catch (e) {
    print(e);
  }
}

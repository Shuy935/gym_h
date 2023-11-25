class HistorialService {
  final String? repeticiones;
  final String? series;
  final int? fecha;
  final String? objectIdExercise;
  final String? userId;
  final String? linkImagen;
  final String? nombreMusculo;
  final String? dificultad;
  final String? descanso;
  final String? nombreEjercicio;

  HistorialService({
    this.repeticiones,
    this.series,
    this.fecha,
    this.objectIdExercise,
    this.userId,
    this.descanso,
    this.dificultad,
    this.linkImagen,
    this.nombreMusculo,
    this.nombreEjercicio,
  });
  @override
  String toString() {
    // Devuelve una cadena que representa la información de la instancia
    return '{objectIdExercise: $objectIdExercise, repeticiones: $repeticiones, series: $series, fecha: $fecha, userId: $userId, nombreEjercicio: $nombreEjercicio, descanso: $descanso, dificuldad: $dificultad, nombreMusculo: $nombreMusculo, linkImagen: $linkImagen}';
  }
}

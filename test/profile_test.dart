import 'package:flutter_test/flutter_test.dart';
import 'package:gym_h/firebase_options.dart';
// Asegúrate de importar el archivo de configuración.
void main() {
  group('Firebase Options Test', () {
    test('Firebase Options for Android', () {
      final options = DefaultFirebaseOptions.android;
      expect(options, isNotNull);
      // Puedes realizar más verificaciones según tus necesidades.
    });

    test('Firebase Options for iOS', () {
      final options = DefaultFirebaseOptions.ios;
      expect(options, isNotNull);
      // Puedes realizar más verificaciones según tus necesidades.
    });
  });
}

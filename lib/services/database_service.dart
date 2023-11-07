import 'package:gym_h/models/users_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class DatabaseService {
  // Configura las credenciales de Back4App
  static void initialize() {
    Parse().initialize(
      'your_app_id',
      'your_server_url',
      clientKey: 'your_client_key',
      debug: true,
    );
  }

  // Define métodos para interactuar con la base de datos
  static Future<void> updateUser(UserService userService) async {
    // Código para actualizar un usuario en la base de datos de Back4App
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_h/darkmode/theme_provider.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:gym_h/screens/configuraciones.dart';
import 'package:gym_h/screens/user/profile.dart';
import 'package:provider/provider.dart';

class DrawerProfile extends StatefulWidget {
  const DrawerProfile({super.key});

  @override
  State<DrawerProfile> createState() => _DrawerProfile();
}

class _DrawerProfile extends State<DrawerProfile> {
  String? username;
  String? email;
  @override
  void initState() {
    super.initState();
    // Obtén el nombre del usuario antes de construir el cajón de navegación
    getUserName();
    getUserEmail();
  }

  Future<void> getUserName() async {
    final userData = await readCompleteUser();
    if (userData != null && userData.isNotEmpty) {
      final user = userData[0]; // Suponemos que solo hay un usuario
      setState(() {
        username = user.fullname!;
      });
    }
  }

  Future<void> getUserEmail() async {
    final userData = await readCompleteUser();
    if (userData != null && userData.isNotEmpty) {
      final user = userData[0]; // Suponemos que solo hay un usuario
      setState(() {
        email = user.email!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
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
            accountName: Text(
              username ?? 'User Fullname',
              style: const TextStyle(fontSize: 19.0),
            ),
            accountEmail: Text(
              email ?? 'Email',
              style: const TextStyle(fontSize: 15.0),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Porfile'),
            onTap: () {
              final route =
                  MaterialPageRoute(builder: (context) => const TheProfile());
              Navigator.push(context, route);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurations'),
            onTap: () {
              // final route = MaterialPageRoute(builder: (context) => Page2());
              // Navigator.push(context, route);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConfiguracionesScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sing out'),
            onTap: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
    );
  }
}

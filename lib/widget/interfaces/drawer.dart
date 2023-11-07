import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:gym_h/screens/user/profile.dart';

class DrawerProfile extends StatelessWidget {
  const DrawerProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(215, 123, 255, 1),
            ),
            child: Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Porfile'),
            onTap: () {
              final route =
                  MaterialPageRoute(builder: (context) => TheProfile());
              Navigator.push(context, route);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurations'),
            onTap: () {
              readUsers();
              // final route = MaterialPageRoute(builder: (context) => Page2());
              // Navigator.push(context, route);
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

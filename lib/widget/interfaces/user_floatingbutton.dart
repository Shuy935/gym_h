import 'package:flutter/material.dart';
import 'package:gym_h/screens/user/profile.dart';

class ProfileButtom extends StatefulWidget {
  const ProfileButtom({super.key});

  @override
  State<ProfileButtom> createState() => _ProfileButtom();
}

class _ProfileButtom extends State<ProfileButtom> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: Colors.black,
      elevation: 20,
      backgroundColor: Colors.amber,
      shape: const CircleBorder(),
      splashColor: Colors.white,
      onPressed: () {
        final route = MaterialPageRoute(builder: (context) => TheProfile());
        Navigator.push(context, route);
      },
      child: const Icon(Icons.person_rounded),
    );
  }
}

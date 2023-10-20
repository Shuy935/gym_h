import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gym_h/screens/Interfaces.dart';
import 'package:gym_h/screens/auth_page.dart';
import 'package:gym_h/screens/verify_email_page.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:gym_h/widget/consejos.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConsejosBProvider()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: MyApp.title,
        theme: ThemeData.dark().copyWith(),
        home: Vacio(),
      ),
    ),
  );
}
final navigatorKey = GlobalKey <NavigatorState>();

class MyApp extends StatelessWidget {
  static final String title = 'Firebase Auth';

  @override
  Widget build(BuildContext context) => MaterialApp(
    scaffoldMessengerKey: Utils.messengerKey,
    navigatorKey: navigatorKey,
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData.dark().copyWith(
    ),
    home: Vacio(),
  );
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return VerifyEmailPage();
        }else {
          return AuthPage();
        }
      },
    ),
  );
}

class Vacio extends StatelessWidget {
  const Vacio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //quitar la madre del debug pq me estorbaba
      title: 'Gym H',
      initialRoute: 'home',
      theme: ThemeData.dark().copyWith(
    ),
      routes: {'home': (_) => Interfaces()},
    );
  }
}

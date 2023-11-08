import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gym_h/screens/login/auth_page.dart';
import 'package:gym_h/screens/login/verify_email_page.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'zJz6TnWQlErwD7qxTyvCOcCSDSX8YXrVtV2pACVG';
  const keyClientKey = 'zU1RDMBoSjHi2qiyMJzGG5YoJYPL7t6b3OMs6Pmc';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static const String title = 'Firebase Auth';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData.dark().copyWith(),
        home: const MainPage(),
      );
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const VerifyEmailPage();
            } else {
              return const AuthPage();
            }
          },
        ),
      );
}

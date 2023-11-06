import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gym_h/main.dart';
import 'package:gym_h/screens/login/forgot_password_page.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:gym_h/widget/interfaces/consejos.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:http/http.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Image.asset('assets/image/logo.png'),
            SizedBox(height: 75),
            Text(
              'Welcome Back',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            TextField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 4),
            TextField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.orange.shade300,
                  Colors.orange.shade100,
                  Colors.white
                ]),
              ),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  minimumSize: Size.fromHeight(50),
                ),
                icon: Icon(Icons.lock_open, size: 32),
                label: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: signIn,
              ),
            ),
            SizedBox(height: 24),
            GestureDetector(
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.orange.shade300,
                  fontSize: 15,
                ),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ForgotPasswordPage(),
              )),
            ),
            SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 15),
                text: 'No account?  ',
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                    text: 'Sign Up',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.orange.shade300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final userService = await userProfileGet(userCredential);
      final isAdm = userService?.isAdm;
      if (userService != null) {
        if (isAdm == true) {
          // final email = userService.email;
          // final username = userService.username;
          // print(username);
          // print(email);
          // print(isAdm);
          // print('Eres entrenador');
          // Usuario con permiso de entrenador
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   builder: (context) => TrainerScreen(), // Reemplaza con el nombre de tu pantalla de entrenador
          // ));
        } else {
          // final email = userService.email;
          // final username = userService.username;
          // print(username);
          // print(email);
          // print(isAdm);
          // print('Eres usuario');
          // Usuario normal
          //  Navigator.of(context).pushReplacement(MaterialPageRoute(
          //  builder: (context) => UserScreen(), // Reemplaza con el nombre de tu pantalla de usuario
          //));
        }
      } else {
        Utils.showSnackBar('No se pudieron obtener los datos del usuario.');
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

 // final email = userService.email;
      // final username = userService.username;
      // final isAdm = userService.isAdm;
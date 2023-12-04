import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gym_h/darkmode/theme_provider.dart';
import 'package:gym_h/main.dart';
import 'package:gym_h/screens/login/forgot_password_page.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
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
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 55),
          SizedBox(
            width: 250,
            height: 250,
            child: Image.asset('assets/image/logo.png'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Welcome Back',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: emailController,
            cursorColor: themeProvider.isDarkMode
                ? Colors.white
                : Colors.black, // Ejemplo de cambio basado en el tema
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 4),
          TextField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                themeProvider.buttonColor1,
                themeProvider.buttonColor2,
              ]),
            ),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.lock_open, size: 32),
              label: const Text(
                'Sign In',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: signIn,
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: themeProvider.textColor2,
                fontSize: 15,
              ),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ForgotPasswordPage(),
            )),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 15),
              text: 'No account?  ',
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedSignUp,
                  text: 'Sign Up',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: themeProvider.textColor2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final userServices =
          await readCompleteUser(); // Utiliza la función readUser para obtener los datos del usuario.

      if (userServices != null && userServices.isNotEmpty) {
        final userService = userServices.first;
        if (userService.isAdm == true) {
          // El usuario es un entrenador, navega a la pantalla de entrenador.
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   builder: (context) => TrainerScreen(), // Reemplaza con el nombre de tu pantalla de entrenador
          // ));
        } else {
          // El usuario no es un entrenador, navega a la pantalla de usuario.
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   builder: (context) => UserScreen(), // Reemplaza con el nombre de tu pantalla de usuario
          // ));
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

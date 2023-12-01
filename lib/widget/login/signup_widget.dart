import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gym_h/darkmode/theme_provider.dart';
import 'package:gym_h/main.dart';
import 'package:gym_h/utils/utils.dart';
import 'package:gym_h/models/users_model.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);

  return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 55),
              Container(
                width: 250,
                height: 250,
                child: Image.asset('assets/image/logo.png'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Join Us',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: emailController,
                cursorColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Email'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
              ),
              const SizedBox(height: 4),
              TextFormField(
                controller: passwordController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Enter a valid password (min. 6 characters)'
                    : null,
              ),
              const SizedBox(height: 4),
              TextFormField(
                  controller: confirmPasswordController,
                  textInputAction: TextInputAction.next,
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: (val) {
                    if (val == null) return 'Empty';
                    if (val != passwordController.text) return 'No match';
                    return null;
                  }),
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
                  icon: const Icon(Icons.arrow_forward, size: 32),
                  label: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 24, color: themeProvider.iconsColor),
                  ),
                  onPressed: signUp,
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: themeProvider.textColor, fontSize: 15),
                  text: 'Already have an account?  ',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text: 'Log In',
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
        ),
      );
    }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    UserService userService =
        UserService(email: emailController.text, isAdm: false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      addUser(userService);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

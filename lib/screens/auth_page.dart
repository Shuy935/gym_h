import 'package:flutter/cupertino.dart';
import 'package:gym_h/widget/login_widget.dart';
import 'package:gym_h/widget/signup_widget.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State <AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
  ? LoginWidget(onClickedSignUp: toggle)
  : SignUpWidget(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
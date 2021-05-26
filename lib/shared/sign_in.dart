import 'package:flutter/material.dart';
import 'package:turnkey_solution/config/theme.dart';
import 'package:turnkey_solution/model/user.dart';
import 'package:turnkey_solution/screens/main.dart';
import 'package:turnkey_solution/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatefulWidget {
  double valueState;
  SignIn(this.valueState);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email;
  String _password;
  bool showLogin = true;

  AuthService _authService = AuthService();

  Widget _input(
      Icon icon, String hint, TextEditingController controller, bool obsecure) {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obsecure,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white70),
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54, width: 1)),
              prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.white),
                    child: icon,
                  ))),
        ));
  }

  Widget _form(String label, void func()) {
    return Container(
      width: 320,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(Icon(Icons.email), "EMAIL", _emailController, false),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child:
                _input(Icon(Icons.lock), "PASSWORD", _passwordController, true),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: _button(label, func),
            ),
          ),
        ],
      ),
    );
  }

  void _loginButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) return;

    UserApp user = await _authService.signInWithEmailAndPassword(
        _email.trim(), _password.trim());
    if (user == null) {
      Fluttertoast.showToast(
          msg: "Неверный логин или пароль",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  void _registerButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) return;

    UserApp user = await _authService.registerWithEmailAndPassword(
        _email.trim(), _password.trim());
    if (user == null) {
      Fluttertoast.showToast(
          msg: "Пароль должен содержать буквы и цифры",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  Widget _button(String text, void func()) {
    return RaisedButton(
      splashColor: PlayColors.red,
      highlightColor: PlayColors.red,
      color: PlayColors.buttonBackground,
      child: Text(text,
          style: TextStyle(
              fontFamily: 'BebasBook',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30)),
      onPressed: () {
        func();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              child: this.widget.valueState == 0
                  ? _form('Войти', _loginButtonAction)
                  : _form('Регистрация', _registerButtonAction))
        ],
      ),
    );
  }
}

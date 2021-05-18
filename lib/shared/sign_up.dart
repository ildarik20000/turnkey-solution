import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turnkey_solution/config/theme.dart';
import 'package:turnkey_solution/screens/main.dart';

class SignUp extends StatefulWidget {
  SignUp();

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email;
  String _password;
  bool showLogin = true;

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
              //child: _form('Регистрация', _loginButtonAction),
              )
        ],
      ),
    );
  }
}

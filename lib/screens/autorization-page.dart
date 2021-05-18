import 'package:flutter/material.dart';
import 'package:turnkey_solution/config/theme.dart';
import 'package:turnkey_solution/shared/button_autorization.dart';
import 'package:turnkey_solution/shared/sign_in.dart';
import 'package:turnkey_solution/shared/sign_up.dart';

class AutorizationPage extends StatefulWidget {
  double value = 0;
  AutorizationPage({Key key}) : super(key: key);

  @override
  _AutorizationPageState createState() => _AutorizationPageState();
}

class _AutorizationPageState extends State<AutorizationPage> {
  final Shader linearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      PlayColors.red,
      PlayColors.background,
    ],
  ).createShader(Rect.fromLTWH(0.0, 80.0, 100.0, 28.0));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: PlayColors.background,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "готовое решение",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        fontFamily: 'BebasBold',
                        foreground: Paint()..shader = linearGradient),
                  ),
                ),
                Center(
                  heightFactor: 3,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          child: Button(
                            text: "Войти",
                            fontSizeText: 20,
                            tapDetectorSize: 59,
                            tapDetector: this.widget.value == 0,
                            onPress: () {
                              setState(() {
                                this.widget.value = 0;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 130,
                          child: Button(
                            fontSizeText: 20,
                            tapDetectorSize: 119,
                            tapDetector: this.widget.value == 1,
                            text: "Регистрация",
                            onPress: () {
                              setState(() {
                                this.widget.value = 1;
                              });
                            },
                          ),
                        )
                      ]),
                ),
                Container(
                  child: this.widget.value == 1 ? SignUp() : SignIn(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

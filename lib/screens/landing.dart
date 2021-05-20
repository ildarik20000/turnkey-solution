import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnkey_solution/model/user.dart';
import 'package:turnkey_solution/screens/autorization-page.dart';
import 'package:turnkey_solution/screens/main.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserApp user = Provider.of<UserApp>(context);
    final bool isLoggedIn = user != null;
    return isLoggedIn ? MainScreen() : AutorizationPage();
  }
}

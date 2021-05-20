import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnkey_solution/model/user.dart';
import 'package:turnkey_solution/screens/autorization-page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:turnkey_solution/screens/landing.dart';
import 'package:turnkey_solution/screens/main.dart';
import 'package:turnkey_solution/services/auth.dart';

import 'config/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamProvider<UserApp>.value(
              value: AuthService().currentUser,
              initialData: null,
              child: MaterialApp(
                title: 'Title',
                theme: playTheme,
                home: Scaffold(
                    backgroundColor: Color.fromRGBO(52, 54, 75, 1),
                    body: LandingPage()),
              ),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return null;
        });
  }
}

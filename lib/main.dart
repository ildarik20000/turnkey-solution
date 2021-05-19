import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turnkey_solution/screens/autorization-page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:turnkey_solution/screens/main.dart';
import 'package:turnkey_solution/services/controller.dart';

import 'config/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return GetMaterialApp(
              title: 'Title',
              theme: playTheme,
              home: Scaffold(
                  backgroundColor: Color.fromRGBO(52, 54, 75, 1),
                  body: controller.isLoggedIn == false
                      ? AutorizationPage()
                      : MainScreen()),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return null;
        });
  }
}

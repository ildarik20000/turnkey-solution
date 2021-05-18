import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turnkey_solution/screens/autorization-page.dart';

import 'config/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Title',
      theme: playTheme,
      home: Scaffold(
          backgroundColor: Color.fromRGBO(52, 54, 75, 1),
          body: AutorizationPage()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:turnkey_solution/screens/kasko_page.dart';
import 'package:turnkey_solution/screens/osago-page.dart';
import 'package:turnkey_solution/shared/button_icon.dart';
import 'package:turnkey_solution/shared/header.dart';

class BuyServices extends StatelessWidget {
  const BuyServices({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: ListView(
            children: [
              Header(
                "Купить полис",
                back: true,
              ),
              ButtonWithIcon(
                text: "ОСАГО",
                icon: Icons.remove,
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OsagoPage()));
                },
              ),
              ButtonWithIcon(
                text: "КАСКО",
                icon: Icons.remove,
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => KaskoPage()));
                },
              ),
              ButtonWithIcon(
                text: "ДМС",
                icon: Icons.remove,
                onPress: () {},
              ),
              ButtonWithIcon(
                text: "Страхование от несчатного случая",
                icon: Icons.remove,
                onPress: () {},
              ),
              ButtonWithIcon(
                text: "Страхование имущества",
                icon: Icons.remove,
                onPress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

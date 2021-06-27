import 'package:flutter/material.dart';
import 'package:turnkey_solution/config/theme.dart';
import 'package:turnkey_solution/screens/buy_services.dart';
import 'package:turnkey_solution/shared/button_icon.dart';
import 'package:turnkey_solution/shared/header.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Header("Услуги"),
          ButtonWithIcon(
            text: "Купить полис",
            onPress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BuyServices()));
            },
          ),
          Divider(
            height: 2,
            color: PlayColors.allWhiteText,
          ),
          _blockInfo(
              "Здоровье", "Консультация врача", "Консультация психолога"),
          Container(
            height: 8,
          ),
          _blockInfo("Авто", "Эвакуатор", "Механик"),
        ],
      ),
    );
  }
}

Widget _blockInfo(
    String blockText, String firsNumberText, String secondNumberText) {
  return Container(
    margin: EdgeInsets.only(top: 9),
    //alignment: Alignment.topLeft,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: PlayColors.allWhiteText.withOpacity(0.6),
    ),
    child: Container(
      padding: EdgeInsets.all(9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              blockText,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: ButtonWithIcon(
                color: Colors.black,
                icon: Icons.phone_callback,
                text: (firsNumberText),
                onPress: () {
                  launch("tel://${8800555555}");
                },
              ),
            ),
          ),
          Container(
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: ButtonWithIcon(
                color: Colors.black,
                icon: Icons.phone_callback,
                text: (secondNumberText),
                onPress: () {
                  launch("tel://${8800555555}");
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

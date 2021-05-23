import 'package:flutter/material.dart';
import 'package:turnkey_solution/shared/button_icon.dart';
import 'package:turnkey_solution/shared/header.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  SupportPage({Key key}) : super(key: key);
  String number = "88005555555";
  String email = "support@mail.ru";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Header("Поддержка"),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: ButtonWithIcon(
                icon: Icons.phone_callback,
                text: ("Позвонить в call-центр"),
                onPress: () {
                  launch("tel://${number.trim()}");
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: ButtonWithIcon(
                icon: Icons.mail,
                text: ("Написать в страховую компанию "),
                onPress: () {
                  launch("mailto:${email.trim()}");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

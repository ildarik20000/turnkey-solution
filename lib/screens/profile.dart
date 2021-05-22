import 'package:flutter/material.dart';
import 'package:turnkey_solution/shared/profile_info.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Профиль",
                  style: TextStyle(fontSize: 25, color: Colors.white70),
                )),
            Divider(
              height: 2,
              color: Colors.white,
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 12),
                    child: TextInfo(text: "Фамилия"),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12),
                    child: TextInfo(text: "Имя"),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12),
                    child: TextInfo(text: "Отчество"),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12),
                    child: TextInfo(text: "Телефон"),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12),
                    child: TextInfo(text: "Email"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

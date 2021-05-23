import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  String text;
  Header(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                text,
                style: TextStyle(fontSize: 25, color: Colors.white70),
              )),
          Divider(
            height: 2,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

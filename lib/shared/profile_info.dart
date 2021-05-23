import 'package:flutter/material.dart';
import 'package:turnkey_solution/shared/input.dart';

class TextInfo extends StatelessWidget {
  String text;
  String info;
  TextEditingController controller;
  TextInfo({this.text, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
              width: 100,
              child: Text(
                this.text,
                style: TextStyle(fontSize: 18, color: Colors.white),
              )),
          Container(
            padding: EdgeInsets.only(left: 8),
            width: MediaQuery.of(context).size.width - 140,
            child: Input(
              controller: this.controller,
              placeholder: this.text,
              textInputAction: TextInputAction.search,
            ),
          )
        ],
      ),
    );
  }
}

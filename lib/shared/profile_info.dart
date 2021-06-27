import 'package:flutter/material.dart';
import 'package:turnkey_solution/config/theme.dart';
import 'package:turnkey_solution/shared/input.dart';

class TextInfo extends StatelessWidget {
  String text;
  String info;
  double widthWidget;
  double widthInput;
  TextInputType keyboardType;
  TextEditingController controller;
  TextInfo(
      {this.text,
      this.controller,
      this.keyboardType,
      this.widthWidget = 100,
      this.widthInput = 140});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: widthWidget,
              child: Text(
                this.text,
                style: TextStyle(fontSize: 18, color: PlayColors.allWhiteText),
              )),
          Container(
            padding: EdgeInsets.only(left: 8),
            width: MediaQuery.of(context).size.width - widthInput,
            child: Input(
              controller: this.controller,
              placeholder: this.text,
              keyboardType: this.keyboardType,
              textInputAction: TextInputAction.search,
            ),
          )
        ],
      ),
    );
  }
}

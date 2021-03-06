import 'package:flutter/material.dart';
import 'package:turnkey_solution/config/theme.dart';

class Header extends StatelessWidget {
  String text;
  bool back = false;
  Header(this.text, {this.back = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              back
                  ? IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: PlayColors.allWhiteText,
                    )
                  : Container(),
              Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    text,
                    style:
                        TextStyle(fontSize: 25, color: PlayColors.allWhiteText),
                  )),
            ],
          ),
          Divider(
            height: 2,
            color: PlayColors.allWhiteText,
          ),
        ],
      ),
    );
  }
}

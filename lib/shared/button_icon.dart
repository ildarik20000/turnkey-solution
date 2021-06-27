import 'package:flutter/material.dart';
import 'package:turnkey_solution/config/theme.dart';

class ButtonWithIcon extends StatelessWidget {
  IconData icon;
  String text;
  Color color;
  Function onPress;
  bool hideDivider;
  Widget postfixEl;
  Color backgrondColor;

  ButtonWithIcon(
      {this.icon,
      this.text = '',
      this.color,
      this.onPress,
      this.postfixEl,
      this.backgrondColor,
      this.hideDivider = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => this.onPress(),
        splashColor:
            this.color?.withOpacity(0.1) ?? PlayColors.red.withOpacity(0.1),
        hoverColor:
            this.color?.withOpacity(0.1) ?? PlayColors.red.withOpacity(0.1),
        highlightColor:
            this.color?.withOpacity(0.1) ?? PlayColors.red.withOpacity(0.1),
        focusColor:
            this.color?.withOpacity(0.1) ?? PlayColors.red.withOpacity(0.1),
        child: Container(
          color: backgrondColor,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: !this.hideDivider
                            ? Colors.blue
                            : Colors.transparent,
                        width: 1))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                this.icon != null
                    ? Icon(
                        this.icon,
                        color: this.color ?? Colors.blue,
                      )
                    : null,
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      this.text,
                      style: TextStyle(
                          fontSize: 18,
                          color: this.color ?? Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                this.postfixEl
              ].where((e) => e != null).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

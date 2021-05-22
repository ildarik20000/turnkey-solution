import 'dart:async';

import 'package:flutter/material.dart';
import 'package:turnkey_solution/config/theme.dart';

class ButtonMenu extends StatefulWidget {
  String text;
  IconData icon;
  Function onPress;
  bool isFloating;
  bool disabled;
  Color color;
  bool active;
  bool isPale = false;
  bool tapDetector;

  ButtonMenu({
    this.text,
    this.icon,
    this.onPress,
    this.color,
    this.isPale = false,
    this.isFloating = false,
    this.disabled = false,
    this.tapDetector = true,
    this.active = false,
  });

  @override
  _ButtonMenuState createState() => _ButtonMenuState();
}

class _ButtonMenuState extends State<ButtonMenu> {
  bool _onPressed = false;
  double sizeActive = 2;

  GestureTapCallback _onPress() {
    if (!this.widget.disabled) {
      this.setState(() {
        this._onPressed = true;
      });
      Timer(Duration(milliseconds: 180), () {
        this.setState(() {
          this._onPressed = false;
        });
      });
      if (this.widget.onPress != null) {
        Future.delayed(Duration(milliseconds: 100))
            .then((c) => this.widget.onPress());
      }
    }

    this._onTapUp({});
  }

  _onTapDown(c) {
    if (!this.widget.disabled) {
      setState(() {
        this._onPressed = true;
      });
    }
  }

  GestureTapUpCallback _onTapUp(c) {
    if (!this.widget.disabled) {
      setState(() {
        this._onPressed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      child: GestureDetector(
        onTap: this._onPress,
        onTapDown: this._onTapDown,
        onTapUp: this._onTapUp,
        onTapCancel: () => this._onTapUp({}),
        child: AnimatedOpacity(
          opacity: this.widget.disabled ? 0.8 : 1,
          duration: Duration(milliseconds: 200),
          child: AnimatedContainer(
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
            child: Center(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
                transform:
                    Matrix4.translationValues(0, this._onPressed ? 5 : 0, 0),
                // margin: EdgeInsets.only(top: this._onPressed ? 10 : 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: this.widget.active ? 47 + sizeActive + 5 : 47,
                        height: this.widget.active ? 47 + sizeActive + 5 : 47,
                        decoration: BoxDecoration(
                            color: this.widget.active
                                ? PlayColors.red
                                : Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(40)),
                        child: Icon(
                          this.widget.icon,
                          color: this.widget.active
                              ? Colors.white
                              : PlayColors.black100,
                          size: this.widget.active ? 25 + sizeActive + 5 : 25,
                        ),
                      ),
                      Text(
                        this.widget.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'BebasBook',
                            color: PlayColors.black100,
                            fontSize: this.widget.active ? 10 + sizeActive : 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

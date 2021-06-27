import 'dart:async';

import 'package:flutter/material.dart';
import 'package:turnkey_solution/config/theme.dart';

class Button extends StatefulWidget {
  String text;

  Function onPress;
  bool isFloating;
  bool disabled;
  double fontSizeText;
  Color color;
  bool isPale = false;
  bool tapDetector;
  double tapDetectorSize = 0.0;

  Button({
    this.text,
    this.onPress,
    this.color,
    this.isPale = false,
    this.isFloating = false,
    this.disabled = false,
    this.tapDetector = true,
    this.fontSizeText,
    this.tapDetectorSize,
  });

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _onPressed = false;

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
    return GestureDetector(
      onTap: this._onPress,
      onTapDown: this._onTapDown,
      onTapUp: this._onTapUp,
      onTapCancel: () => this._onTapUp({}),
      child: AnimatedOpacity(
        opacity: this.widget.disabled ? 0.6 : 1,
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
              child: Column(children: [
                Text(
                  this.widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'BebasBook',
                      color: this.widget.isPale
                          ? PlayColors.red
                          : PlayColors.allWhiteText,
                      fontSize: widget.fontSizeText,
                      fontWeight: FontWeight.bold),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: this.widget.tapDetector ? widget.tapDetectorSize : 0,
                  height: 2,
                  color: PlayColors.red,
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

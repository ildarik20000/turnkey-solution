import 'package:flutter/material.dart';
import 'package:turnkey_solution/config/theme.dart';

class Input extends StatefulWidget {
  String placeholder = '';
  String label = '';
  String errorText = '';
  bool secure = false;
  bool autoFocus = false;
  Function onInput;
  TextInputType keyboardType;
  int minLines;
  int maxLines;
  Widget bottomEl;
  Function onSubmit;
  TextInputAction textInputAction;
  TextEditingController controller;

  Input({
    this.placeholder = '',
    this.label = '',
    this.errorText = '',
    this.onInput,
    this.minLines,
    this.maxLines,
    this.keyboardType,
    this.bottomEl,
    this.textInputAction,
    this.autoFocus = false,
    this.onSubmit,
    this.secure = false,
    this.controller,
  });

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  final controller2 = TextEditingController(text: '');

  bool hasFocus = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.widget.label,
          style: TextStyle(fontSize: 15),
        ),
        AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                color: PlayColors.black04,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            child: Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  TextField(
                    onSubmitted: (s) {
                      this.widget.onSubmit(
                          s, this.widget.controller ?? this.controller2);
                    },
                    autofocus: this.widget.autoFocus,
                    obscureText: this.widget.secure,
                    textInputAction: this.widget.textInputAction,
                    decoration: InputDecoration(
                        hintText: this.widget.placeholder,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: PlayColors.buttonBackground,
                                width: 2,
                                style: BorderStyle.solid)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: PlayColors.red,
                                width: 2,
                                style: BorderStyle.solid)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16)),
                    keyboardType:
                        this.widget.keyboardType ?? TextInputType.text,
                    minLines: this.widget.minLines ?? 1,
                    maxLines: this.widget.minLines == null ? 1 : null,
                    style: TextStyle(fontSize: 18, color: PlayColors.black100),
                    controller: this.widget.controller ?? this.controller2,
                    cursorColor: PlayColors.red,
                    cursorHeight: 22,
                    enableInteractiveSelection: true,
                    onChanged: this.widget.onInput != null
                        ? this.widget.onInput
                        : null,
                  ),
                ].where((e) => e != null ?? e != false).toList(),
              ),
            )),
        this.widget.bottomEl ??
            Text(
              this.widget.errorText,
              style: TextStyle(color: PlayColors.error),
            ),
      ],
    );
  }
}

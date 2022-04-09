import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shinobi_tool/styles/Css.dart';

class SnbButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isDisabled;
  SnbButton(
      {required this.text, this.isDisabled = false, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Css.fontSize * 3,
      child: ElevatedButton(
          onPressed: (this.isDisabled)
              ? null
              : () {
                  this.onPressed();
                },
          style: ButtonStyle(),
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              fontSize: Css.fontSize,
            ),
          )),
    );
  }
}

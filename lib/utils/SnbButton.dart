import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shinobi_tool/styles/Css.dart';

class SnbButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isDisabled;
  final Widget? child;
  SnbButton(
      {required this.text,
      this.child,
      this.isDisabled = false,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    bool hasChild = (this.child != null);
    Widget childWidget = (hasChild)
        ? this.child!
        : Text(text.toUpperCase(),
            style: TextStyle(
              fontSize: Css.fontSize,
            ));
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
        child: childWidget,
      ),
    );
  }
}

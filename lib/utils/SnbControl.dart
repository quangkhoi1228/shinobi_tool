import 'package:flutter/material.dart';
import 'package:shinobi_tool/styles/Css.dart';

class SnbControl extends StatelessWidget {
  final Widget child;

  const SnbControl({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Css.padding),
      child: child,
    );
  }
}

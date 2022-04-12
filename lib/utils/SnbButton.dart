import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/styles/Css.dart';

class SnbButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isDisabled;
  final Widget? child;
  final bool isLoading;
  SnbButton(
      {required this.text,
      this.isLoading = false,
      this.child,
      this.isDisabled = false,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    bool hasChild = (this.child != null);
    Widget textWidget = Text(text.toUpperCase(),
        style: TextStyle(
          fontSize: Css.fontSize,
        ));
    Widget childWidget = (hasChild)
        ? this.child!
        : (this.isLoading)
            ? Stack(children: [
                Padding(
                  padding: EdgeInsets.only(left: Css.padding),
                  child: SizedBox(
                    width: Css.fontSizeMedium,
                    child: SpinKitDualRing(
                      color: Get.theme.accentColor,
                      size: Css.fontSizeMedium,
                      lineWidth: 2,
                    ),
                  ),
                ),
                Center(child: textWidget)
              ])
            : textWidget;
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

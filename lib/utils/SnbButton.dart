import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/styles/Css.dart';

import 'SnbSize.dart';

class SnbButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isDisabled;
  final Widget? child;
  final bool isLoading;
  final SnbSize size;
  final bool isText;
  SnbButton(
      {required this.text,
      this.isLoading = false,
      this.child,
      this.size = SnbSize.normal,
      this.isDisabled = false,
      this.isText = false,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    double textSize;
    switch (size) {
      case SnbSize.large:
        textSize = Css.fontSizeLarge;
        break;
      case SnbSize.small:
        textSize = Css.fontSizeSmall;
        break;
      case SnbSize.normal:
      default:
        textSize = Css.fontSize;
        break;
    }
    bool hasChild = (this.child != null);
    Widget textWidget = Text(text.toUpperCase(),
        style: TextStyle(
          color: Get.theme.colorScheme.primaryVariant,
          fontSize: textSize,
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
      height: textSize * 3,
      child: isText
          ? TextButton(
              onPressed: (this.isDisabled)
                  ? null
                  : () {
                      this.onPressed();
                    },
              style: ButtonStyle(),
              child: childWidget,
            )
          : ElevatedButton(
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

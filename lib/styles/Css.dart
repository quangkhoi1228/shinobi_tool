import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screen {
  static width(double p, BuildContext context) {
    return MediaQuery.of(context).size.width * (p / 100);
  }

  static height(double p, BuildContext context) {
    return MediaQuery.of(context).size.height * (p / 100);
  }
}

class Css {
  static double searchHeight = 35.0;
  static double pageMenuHeight = (Platform.isAndroid) ? 50 : 50;
  static double pageTitleHeight = (Platform.isAndroid) ? 86 : 134;
  static double pageTitleAndMenuHeight = pageTitleHeight + pageMenuHeight;
  static double titleSize = 14.0;
  static double subtitleSize = 12.0;
  static double bodySize = 15.0;

  static Color modalTextColor = Colors.white;
  static Color modalAcceptButtonColor = Colors.white;
  static Color modalRejectButtonColor = Colors.white;
  static Color modalCloseButtonColor = Colors.white;

  static double padding = 15.0;
  static double paddingSmall = 5.0;
  static double paddingMedium = 20.0;
  static double paddingLarge = 25.0;
  static double paddingElement = fontSize * 1.5;
  static double paddingListBlock = 3;

  // static EdgeInsets paddingInput =
  //     EdgeInsets.only(top: 5.0, right: 10.0, bottom: 5.0, left: 10.0);
  static EdgeInsets paddingInput = EdgeInsets.all(8);
  static EdgeInsets paddingTitle = EdgeInsets.only(
      top: Css.padding * 2 / 3,
      right: Css.padding,
      bottom: Css.padding * 2 / 3,
      left: Css.padding);

  static EdgeInsets paddingTableCell = EdgeInsets.only(
      top: Css.padding * 0.75,
      right: Css.paddingSmall,
      bottom: Css.padding * 0.75,
      left: Css.paddingSmall);

  static double fontSize = 15.0;
  static double fontSizeSmall = 10.0;
  static double fontSizeSemiSmall = 13.0;
  static double fontSizeMedium = 20.0;
  static double fontSizeLarge = 25.0;
  static String font = 'roboto';
  static FontWeight fontWeight = FontWeight.w400;
  static FontWeight fontWeightLight = FontWeight.w300;
  static FontWeight fontWeightMedium = FontWeight.w500;
  static FontWeight fontWeightBold = FontWeight.w700;
  static FontWeight fontWeightBlack = FontWeight.w900;

  static double avatarBorderRadius = 30.0;
  static double avatarBorderRadiusSmall = 20.0;
  static double avatarBorderRadiusMedium = 50.0;
  static double avatarBorderRadiusLarge = 80.0;

  static BorderRadius borderRadius = BorderRadius.circular(4.0);
  static BorderRadius borderRadiusLess = BorderRadius.circular(0.0);

  static BorderRadius borderRadiusRounded =
      BorderRadius.circular(avatarBorderRadiusLarge);

  static Color primaryColor = Color(0xff243448);
  static Color secondaryColor = Color(0xff212b5f);
  static Color borderColor = Color(0xff848d95);
  static Color canvasColor = Color(0xff1e2733);
  static Color isWarning = Color(0xfff16631);
  static Color isDanger = Color(0xffff3860);
  static final Color isLight = Color(0xf5f5f5f5);
  static Color isRed = Color(0xffed3536);
  static Color isYellow = Color(0xffffd900);
  static Color isGreen = Colors.green.shade700;
  static Color isGreenDark = Color(0xff008f41);
  static Color isLink = Color(0xff7faefb);
  static Color isInfo = Color(0xff1a73e8);
  static Color color(dynamic input) {
    if (input.startsWith('#')) {
      input = int.parse(input.replaceFirst('#', '0xff'));
    }
    return Color(input);
  }

  static Color isWhite = Colors.white;
  static Color isBlack = Colors.black;
  static Color isDark = Color(0x36363636);
  static Color isLightBlack = Color(0xff6d6a6a);
  static Color isTransparent = Colors.transparent;

  static Color isGrey = Color(0xff999999);
  static Color isGreyDark = Colors.black54;

  static Color isText = Color(0x1b1b1616);

  static double navbarheight = 80.0;
  static double tabHeight = 40.0;
  static double adsHeight = 100.0;

  static Color tableOldRowColor = primaryColor;
  static Color tableEvenRowColor = Color(0xff2d394a);

  static double fontSizeNews = 18.0;

  static Color isNewsText = Color(0xffdee0e2);
  static Color isOrange = Color(0xfff16631);

  static Color primary = Color.fromRGBO(0, 35, 103, 1);
  static Color secondary = Color(0xfff16631);

  static double chartProfitHeight = 220.0;

  static var routeSetting = RouteSettings();

  static RouteSettings makeRouteSetting(String name) {
    return RouteSettings(name: name);
  }

  static BorderSide borderSide = BorderSide(color: Css.secondary, width: 2);
  static Border borderTop = Border(top: borderSide);
  static Border borderRight = Border(right: borderSide);
  static Border borderBottom = Border(bottom: borderSide);
  static Border borderLeft = Border(left: borderSide);

  static double borderWidth = 2.0;

  static double carouselHeight = 225.0;

  static double searchIconSize = 25.0;
  static double width(String input, {context}) {
    if (input.endsWith("%")) {
      @required
      var context;
      return MediaQuery.of(context).size.width *
          double.parse(input.replaceAll('%', ''));
    } else {
      return MediaQuery.of(context).size.width * double.parse(input);
    }
  }

  static MaterialColor getMaterialColor(Color color) {
    return MaterialColor(color.value, Css.getSwatch(color));
  }

  static Map<int, Color> getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;

    /// if [500] is the default color, there are at LEAST five
    /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
    /// divisor of 5 would mean [50] is a lightness of 1.0 or
    /// a color of #ffffff. A value of six would be near white
    /// but not quite.
    final lowDivisor = 6;

    /// if [500] is the default color, there are at LEAST four
    /// steps above [500]. A divisor of 4 would mean [900] is
    /// a lightness of 0.0 or color of #000000
    final highDivisor = 5;

    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;

    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }
}

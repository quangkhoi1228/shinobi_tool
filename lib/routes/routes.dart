import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/modules/BuildResource/BuildResource.dart';
import 'package:shinobi_tool/modules/ExportJar/ExportJar.dart';
import 'package:shinobi_tool/modules/Home/HomePage.dart';
import 'package:shinobi_tool/modules/SetupSource/SetupSource.dart';
import 'package:shinobi_tool/modules/Unknown/UnknownPage.dart';
import 'package:shinobi_tool/styles/Css.dart';

class RouteItem {
  String name;
  String title;
  String description;
  Widget page;
  Function icon;

  RouteItem(
      {required this.name,
      required this.title,
      required this.description,
      required this.icon,
      required this.page});
}

class Routes {
  static String homePage = '/';
  static String notFoundPage = '/notfound/';
  static String setupSourcePage = '/SetupSourcePage/';
  static String exportJarPage = '/ExportJarPage/';
  static String buildResource = '/BuildResource/';

  static List<Color> iconColor = [
    Css.color('#e668b3'),
    Css.color('#a07cc5'),
    Css.color('#f78b77'),
    Css.color('#45c4a0'),
    Css.color('#e668b3'),
    Css.color('#a07cc5'),
    Css.color('#f78b77'),
    Css.color('#45c4a0'),
    Css.color('#e668b3'),
    Css.color('#a07cc5'),
    Css.color('#f78b77'),
    Css.color('#45c4a0'),
  ];

  static Widget getIcon(
      String name, IconData iconData, bool isActive, bool hasColor, int index) {
    if (hasColor) {
      return Icon(iconData, size: Css.fontSize * 2.5, color: iconColor[index]);
    }
    return Icon(iconData,
        size: Css.fontSizeMedium,
        color: (isActive) ? Get.theme.cardColor : Get.theme.iconTheme.color);
  }

  static List<RouteItem> routes = [
    RouteItem(
        name: '/',
        icon: (bool isActive, {bool hasColor = false, int index = 0}) {
          return getIcon(Routes.homePage, FontAwesomeIcons.house, isActive,
              hasColor, index);
        },
        title: 'Home',
        description: 'Home page',
        page: new HomePage()),
    RouteItem(
        name: '/notfound/',
        icon: (bool isActive, {bool hasColor = false, int index = 0}) {
          return getIcon(
              Routes.notFoundPage, Icons.home, isActive, hasColor, index);
        },
        description: '502 Page not found',
        title: 'Not Found',
        page: UnknownPage()),
    RouteItem(
        name: '/SetupSourcePage/',
        icon: (bool isActive, {bool hasColor = false, int index = 0}) {
          return getIcon(Routes.setupSourcePage, FontAwesomeIcons.folderTree,
              isActive, hasColor, index);
        },
        description:
            'Create a folder structure and pull multiple projects at once',
        title: 'Setup Source',
        page: SetupSourcePage()),
    RouteItem(
        name: '/ExportJarPage/',
        icon: (bool isActive, {bool hasColor = false, int index = 0}) {
          return getIcon(Routes.exportJarPage, FontAwesomeIcons.fileExport,
              isActive, hasColor, index);
        },
        description:
            'Create deployable files/directory like xml, jar, lib without eclipse',
        title: 'Export Jar',
        page: ExportJarPage()),
    RouteItem(
        name: '/BuildResource/',
        icon: (bool isActive, {bool hasColor = false, int index = 0}) {
          return getIcon(Routes.buildResource, FontAwesomeIcons.fileZipper,
              isActive, hasColor, index);
        },
        description: 'Compress and optimize static files automatically',
        title: 'Build Resource',
        page: BuildResourcePage()),
  ];

  static RouteItem getRouteItemByName(String name) {
    return routes.firstWhere((RouteItem elem) => elem.name == name);
  }

  static String getRouteByName(String name) {
    RouteItem result = routes.firstWhere((RouteItem elem) => elem.name == name);
    return result.name;
  }

  static getPageByName(String name) {
    RouteItem result = routes.firstWhere((RouteItem elem) => elem.name == name);
    return createGetPageByRouteItem(result);
  }

  static GetPage createGetPageByRouteItem(RouteItem routeItem) {
    return GetPage(
      name: routeItem.name,
      page: () => routeItem.page,
    );
  }

  static List<GetPage<dynamic>> getRoutes() {
    return routes
        .map((routeItem) => createGetPageByRouteItem(routeItem))
        .toList();
  }
}

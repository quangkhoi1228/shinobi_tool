import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/modules/ExportJar/ExportJar.dart';
import 'package:shinobi_tool/modules/Home/HomePage.dart';
import 'package:shinobi_tool/modules/SetupSource/SetupSource.dart';
import 'package:shinobi_tool/modules/Unknown/UnknownPage.dart';
import 'package:shinobi_tool/styles/Css.dart';

class RouteItem {
  String name;
  String title;
  Widget page;
  Function icon;

  RouteItem(
      {required this.name,
      required this.title,
      required this.icon,
      required this.page});
}

class Routes {
  static String homePage = '/';
  static String notFoundPage = '/notfound/';
  static String setupSourcePage = '/SetupSourcePage/';
  static String exportJarPage = '/ExportJarPage/';

  static List<RouteItem> routes = [
    RouteItem(
        name: '/',
        icon: (bool isActive) {
          return Icon(Icons.home,
              size: Css.fontSizeMedium,
              color:
                  (isActive) ? Get.theme.cardColor : Get.theme.iconTheme.color);
        },
        title: 'Home',
        page: new HomePage()),
    RouteItem(
        name: '/notfound/',
        icon: (bool isActive) {
          return Icon(Icons.home,
              size: Css.fontSizeMedium,
              color:
                  (isActive) ? Get.theme.cardColor : Get.theme.iconTheme.color);
        },
        title: 'Not Found',
        page: UnknownPage()),
    RouteItem(
        name: '/SetupSourcePage/',
        icon: (bool isActive) {
          return Icon(Icons.settings,
              size: Css.fontSizeMedium,
              color:
                  (isActive) ? Get.theme.cardColor : Get.theme.iconTheme.color);
        },
        title: 'Setup Source',
        page: SetupSourcePage()),
    RouteItem(
        name: '/ExportJarPage/',
        icon: (bool isActive) {
          return Icon(Icons.exit_to_app,
              size: Css.fontSizeMedium,
              color:
                  (isActive) ? Get.theme.cardColor : Get.theme.iconTheme.color);
        },
        title: 'Export Jar',
        page: ExportJarPage()),
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

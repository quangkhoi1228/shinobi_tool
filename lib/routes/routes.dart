import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/modules/Home/HomePage.dart';
import 'package:shinobi_tool/modules/SetupSource/SetupSourcePage.dart';
import 'package:shinobi_tool/modules/Unknown/UnknownPage.dart';


class RouteItem {
  String name;
  String title;
  Widget page;
  Widget icon;
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

  static List<RouteItem> routes = [
    RouteItem(
        name: '/', icon: Icon(Icons.home), title: 'Home', page: new HomePage()),
    RouteItem(
        name: '/notfound/',
        icon: Icon(Icons.home),
        title: 'Not Found',
        page: UnknownPage()),
    RouteItem(
        name: '/SetupSourcePage/',
        icon: Icon(Icons.settings),
        title: 'Setup Source',
        page: SetupSourcePage()),
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

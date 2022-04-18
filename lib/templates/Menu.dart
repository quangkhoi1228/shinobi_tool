import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/routes/Routes.dart';
import 'package:shinobi_tool/styles/Css.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  static List<String> drawerItem = [
    Routes.homePage,
    Routes.setupSourcePage,
    Routes.buildResourcePage,
    Routes.exportJarPage,
  ];

  @override
  Widget build(BuildContext context) {
    return _buildDrawer();
  }

  Widget _buildDrawer() {
    List<Widget> children = drawerItem.map((String drawerItem) {
      RouteItem item = Routes.getRouteItemByName(drawerItem);
      bool isActive = (Get.currentRoute == drawerItem);
      Widget icon = Padding(
          padding: EdgeInsets.only(right: Css.padding),
          child: item.icon(isActive));
      return Container(
        decoration: isActive
            ? BoxDecoration(
                color: Get.theme.colorScheme.primary,
              )
            : BoxDecoration(),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: Css.fontSize * 2.5,
                  child: Row(
                    children: [
                      icon,
                    ],
                  )),
              Text(item.title,
                  style: isActive
                      ? TextStyle(color: Get.theme.cardColor)
                      : TextStyle()),
            ],
          ),
          onTap: () {
            Get.toNamed(item.name);
          },
        ),
      );
    }).toList();

    children.insert(
        0,
        Container(
          height: Css.fontSize * 7,
          child: DrawerHeader(
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: Css.fontSize * 6,
                ),
                Text(
                  "Shinobi Tool",
                  style: TextStyle(
                      color: Get.theme.colorScheme.secondary,
                      fontSize: Css.fontSizeLarge,
                      fontWeight: Css.fontWeightMedium),
                ),
              ],
            ),
          ),
        ));
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: children));
  }
}

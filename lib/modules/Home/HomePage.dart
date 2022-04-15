import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/modules/Home/controllers/HomeController.dart';
import 'package:shinobi_tool/routes/Routes.dart';
import 'package:shinobi_tool/styles/Css.dart';
import 'package:shinobi_tool/templates/Menu.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());

  @override
  Widget build(context) {
    return buildBodyWidget();
  }

  buildBodyWidget() {
    double bannerHeight = Css.fontSize * 28;
    return Scaffold(
      body: ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: Get.height,
        ),
        child: Container(
          decoration: BoxDecoration(color: Css.isLight),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: bannerHeight,
                  padding: EdgeInsets.only(top: Css.fontSize * 5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/home/background.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/logo_grey.png',
                        height: Css.fontSize * 5,
                      ),
                      Text(
                        "Shinobi Tool",
                        style: TextStyle(
                            color: Css.isWhite,
                            fontSize: Css.fontSizeLarge * 2,
                            fontWeight: Css.fontWeightMedium),
                      ),
                      Text('Extension toolkit for shinobi dev',
                          style: TextStyle(
                              color: Css.isWhite,
                              fontSize: Css.fontSizeMedium)),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: bannerHeight - Css.fontSize * 10),
                  child: Center(
                    child: Container(
                      width: Css.fontSize * 60,
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        padding: EdgeInsets.all(Css.fontSize * 2),
                        primary: true,
                        children: Menu.drawerItem.sublist(1).map((String name) {
                          return buildItem(name);
                        }).toList(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItem(String name) {
    int index = Menu.drawerItem.sublist(1).indexOf(name);
    RouteItem item = Routes.getRouteItemByName(name);
    Widget icon = item.icon(false, hasColor: true, index: index);

    var hover = false.obs;
    return InkWell(
      onHover: (isHover) {
        hover.value = isHover;
      },
      onTap: () {
        Get.toNamed(Routes.getRouteByName(name));
      },
      child: Container(
        margin: EdgeInsets.only(
            top: Css.padding,
            right: Css.padding,
            left: Css.padding,
            bottom: Css.padding),
        padding: EdgeInsets.only(
            top: Css.paddingLarge,
            right: Css.paddingLarge,
            left: Css.paddingLarge,
            bottom: Css.padding),
        decoration: BoxDecoration(
          color: Css.isWhite,
          borderRadius: Css.borderRadius,
          boxShadow: Css.boxShadow,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: Css.padding),
                  child: icon,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: Css.padding),
                  child: Text(
                    item.title,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: Css.fontSizeMedium,
                        fontWeight: Css.fontWeight),
                  ),
                ),
                Text(
                  item.description,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: Css.fontSize,
                      fontWeight: Css.fontWeight),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(top: Css.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Check it',
                      style: TextStyle(
                          // decoration: TextDecoration.underline,
                          color: Css.isInfo,
                          fontSize: Css.fontSize,
                          fontWeight: Css.fontWeightLight),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Css.paddingSmall),
                      child: Icon(
                        FontAwesomeIcons.arrowRight,
                        size: Css.fontSizeSemiSmall,
                        color: Css.isInfo,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

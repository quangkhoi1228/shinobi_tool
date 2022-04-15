import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/routes/Routes.dart';
import 'package:shinobi_tool/styles/Css.dart';
import 'package:shinobi_tool/templates/Menu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(context) {
    return buildBodyWidget();
  }

  buildBodyWidget() {
    double bannerHeight = Css.fontSize * 25;
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter:
                          ColorFilter.mode(Css.isGrey, BlendMode.lighten),
                      image: AssetImage(
                        "assets/home/background.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Shinobi Tool",
                        style: TextStyle(
                            color: Css.isWhite,
                            fontSize: Css.fontSizeLarge * 2,
                            fontWeight: Css.fontWeightMedium),
                      ),
                      Text('Extension toolkit for shinobi dev',
                          style: TextStyle(
                              color: Css.isWhite, fontSize: Css.fontSizeMedium))
                    ],
                  )),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: bannerHeight - Css.fontSize * 8),
                  child: Center(
                    child: Container(
                      width: Css.fontSize * 40,
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        padding: EdgeInsets.all(Css.fontSize * 2),
                        primary: true,
                        children: Menu.drawerItem.sublist(1).map((String name) {
                          int index = Menu.drawerItem.sublist(1).indexOf(name);
                          RouteItem item = Routes.getRouteItemByName(name);
                          Widget icon =
                              item.icon(false, hasColor: true, index: index);
                          return Container(
                            margin: EdgeInsets.only(
                                top: Css.padding,
                                right: Css.padding,
                                left: Css.padding,
                                bottom: Css.padding),
                            padding: EdgeInsets.all(Css.paddingLarge),
                            decoration: BoxDecoration(
                              color: Css.isWhite,
                              borderRadius: Css.borderRadius,
                              boxShadow: Css.boxShadow,
                            ),
                            child: Column(
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
                                )
                              ],
                            ),
                          );
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
}

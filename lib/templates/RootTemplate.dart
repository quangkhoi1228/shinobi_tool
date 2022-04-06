import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/routes/routes.dart';
import 'package:shinobi_tool/styles/Css.dart';

class RootTemplate extends StatefulWidget {
  final String title;
  final Widget child;
  const RootTemplate({Key? key, required this.child, required this.title})
      : super(key: key);

  @override
  State<RootTemplate> createState() => _RootTemplateState();
}

class _RootTemplateState extends State<RootTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: _buildDrawer(),
        body: Center(
          child: Container(
              padding: EdgeInsets.all(Css.padding), child: widget.child),
        ));
  }

  Widget _buildDrawer() {
    List<String> drawerItem = [Routes.homePage, Routes.setupSourcePage];

    List<Widget> children = drawerItem.map((String drawerItem) {
      RouteItem item = Routes.getRouteItemByName(drawerItem);
      return ListTile(
        title: Row(
          children: [
            Text(item.title),
          ],
        ),
        onTap: () {
          Get.toNamed(item.name);
        },
      );
    }).toList();

    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: children));
  }
}

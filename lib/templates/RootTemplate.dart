import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/routes/routes.dart';
import 'package:shinobi_tool/styles/Css.dart';
import 'package:shinobi_tool/templates/controller/RootTemplateController.dart';

class RootTemplate extends StatefulWidget {
  final String title;
  final Widget child;

  const RootTemplate({Key? key, required this.child, required this.title})
      : super(key: key);

  @override
  State<RootTemplate> createState() => _RootTemplateState();
}

class _RootTemplateState extends State<RootTemplate> {
  final rootTemplateController = Get.put(RootTemplateController());

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () {
                  rootTemplateController.toggleDarkMode();
                },
                icon: GetX<RootTemplateController>(
                    builder: (_) => Icon(
                        rootTemplateController.isDarkMode.isFalse
                            ? Icons.light_mode
                            : Icons.dark_mode)))
          ],
        ),
        drawer: _buildDrawer(),
        body: Container(
            padding: EdgeInsets.all(Css.padding), child: widget.child));
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

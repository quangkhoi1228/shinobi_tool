import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/styles/Css.dart';
import 'package:shinobi_tool/templates/RootTemplate.dart';
import 'package:shinobi_tool/utils/LocalStorage.dart';
import 'package:shinobi_tool/utils/SnbJson.dart';

import 'controllers/PageTemplateController.dart';

class PageTemplatePage extends StatelessWidget {
  PageTemplatePage({Key? key}) : super(key: key);
  final controller = Get.put(PageTemplateController());
  final LocalStorage storage = LocalStorage.instance();

  @override
  Widget build(context) {
    preload();
    return RootTemplate(
      title: 'Setup Source',
      child: buildBodyWidget(),
    );
  }

  void preload() {
    storage.getJsonAllData().then((SnbJson data) {});
  }

  Widget buildBodyWidget() {
    return Container();
  }

  Widget control({required Widget child}) {
    return Container(
      margin: EdgeInsets.only(bottom: Css.padding),
      child: child,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/routes/Routes.dart';
import 'package:shinobi_tool/styles/Css.dart';
import 'package:shinobi_tool/templates/RootTemplate.dart';
import 'package:shinobi_tool/templates/controller/RootTemplateController.dart';
import 'package:shinobi_tool/utils/LocalStorage.dart';
import 'package:shinobi_tool/utils/SnbButton.dart';
import 'package:shinobi_tool/utils/SnbJson.dart';

import 'controllers/BuildResourceController.dart';

class BuildResourcePage extends StatelessWidget {
  BuildResourcePage({Key? key}) : super(key: key);
  final controller = Get.put(BuildResourceController());
  final LocalStorage storage = LocalStorage.instance();

  @override
  Widget build(context) {
    preload();

    return RootTemplate(
      title: 'Build Resource',
      child: buildBodyWidget(),
    );
  }

  void preload() {
    RootTemplateController.setCurrentPage(Routes.buildResourcePage);
    storage.getJsonAllData().then((SnbJson data) {});
  }

  Widget buildBodyWidget() {
    return Container(
      child: SnbButton(
          text: 'adawdaw',
          onPressed: () {
            controller.process();
          }),
    );
  }

  Widget control({required Widget child}) {
    return Container(
      margin: EdgeInsets.only(bottom: Css.padding),
      child: child,
    );
  }
}

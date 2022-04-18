import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/modules/BuildResource/components/CompressCssTab.dart';
import 'package:shinobi_tool/routes/Routes.dart';
import 'package:shinobi_tool/templates/RootTemplate.dart';
import 'package:shinobi_tool/templates/controller/RootTemplateController.dart';
import 'package:shinobi_tool/utils/LocalStorage.dart';
import 'package:shinobi_tool/utils/SnbJson.dart';
import 'package:shinobi_tool/utils/SnbTab.dart';

import 'components/GeneralTab.dart';
import 'controllers/BuildResourceController.dart';

class BuildResourcePage extends StatelessWidget {
  BuildResourcePage({Key? key}) : super(key: key);
  final controller = Get.put(BuildResourceController());
  final LocalStorage storage = LocalStorage.instance();

  final TextEditingController projectDirectoryController =
      new TextEditingController();

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
    return SnbTab(tabs: [
      SnbTabItem(name: 'Css', child: CompressCssTab()),
      SnbTabItem(name: 'General', child: GeneralTab()),
      SnbTabItem(name: 'JS', child: GeneralTab()),
      SnbTabItem(name: 'SASS', child: GeneralTab()),
    ]);
  }
}

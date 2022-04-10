import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/styles/Css.dart';
import 'package:shinobi_tool/templates/RootTemplate.dart';
import 'package:shinobi_tool/utils/LocalStorage.dart';
import 'package:shinobi_tool/utils/SnbButton.dart';
import 'package:shinobi_tool/utils/SnbFileInput.dart';
import 'package:shinobi_tool/utils/SnbJson.dart';

import 'controllers/ExportJarController.dart';

class ExportJarPage extends StatelessWidget {
  ExportJarPage({Key? key}) : super(key: key);
  final controller = Get.put(ExportJarController());
  final LocalStorage storage = LocalStorage.instance();

  final TextEditingController projectDirectoryController =
      new TextEditingController();
  final TextEditingController projectNameController =
      new TextEditingController();
  final TextEditingController mainClassController = new TextEditingController();
  final TextEditingController workspaceController = new TextEditingController();
  final TextEditingController outputController = new TextEditingController();
  final TextEditingController shinobiServerController =
      new TextEditingController();

  @override
  Widget build(context) {
    preload();
    return RootTemplate(
      title: 'Export Jar',
      child: buildBodyWidget(),
    );
  }

  void preload() {
    storage.getJsonAllData().then((SnbJson data) {
      projectDirectoryController.text =
          data.getString('exportJar_projectDirectory');
      projectNameController.text = data.getString('exportJar_projectName');
      mainClassController.text = data.getString('exportJar_mainClass');
      workspaceController.text = data.getString('exportJar_workspace');
      outputController.text = data.getString('exportJar_output');
    });
  }

  void onChangeProjectName(String value) {
    projectNameController.text = value;
    storage.setItem('exportJar_projectName', value);
  }

  void onChangeProjectOutput(String value) {
    outputController.text = value;
    storage.setItem('exportJar_output', value);
  }

  void onChangeProjectDirectory(String directory) {
    storage.setItem('exportJar_projectDirectory', directory);
    onChangeProjectName(directory.split('/').last);
    workspaceController.text = directory;
    onChangeProjectOutput(
        directory.substring(0, directory.indexOf('/git')) + '/deploy');
  }

  Widget buildBodyWidget() {
    return Container(
        padding: EdgeInsets.only(right: Css.paddingLarge, left: Css.padding),
        child: Column(children: [
          control(
            child: SnbFileInput(
              controller: projectDirectoryController,
              labelText: 'Project Directory',
              isPickDirectory: true,
              onChanged: (String directory) {
                onChangeProjectDirectory(directory);
              },
            ),
          ),
          control(
            child: TextField(
              controller: projectNameController,
              onChanged: (value) => onChangeProjectName(value),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Project Name',
              ),
            ),
          ),
          control(
            child: SnbFileInput(
              controller: mainClassController,
              allowedExtensions: ['java'],
              labelText: 'Main Class',
              onChanged: (String path) {
                String mainPackage = path
                    .substring(path.indexOf('com'))
                    .replaceAll('/', '.')
                    .replaceAll('.java', '');
                mainClassController.text = mainPackage;
                storage.setItem('exportJar_mainClass', mainPackage);
              },
            ),
          ),
          control(
            child: SnbFileInput(
              controller: workspaceController,
              labelText: 'Workspace',
              isPickDirectory: true,
              onChanged: (String directory) {
                storage.setItem(
                    'exportJar_workspace', workspaceController.text);
              },
            ),
          ),
          control(
            child: SnbFileInput(
              controller: outputController,
              isPickDirectory: true,
              labelText: 'Output Directory',
              onChanged: (String directory) {
                onChangeProjectOutput(outputController.text);
              },
            ),
          ),
          control(
              child: GetX<ExportJarController>(
            builder: (_) => Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: Css.paddingSmall),
                  child: InkWell(
                    onTap: () {
                      controller.onChangeUseShinobiServer(
                          !controller.isUseShinobiServer.isTrue);
                      storage.setItem('exportJar_useShinobiServer',
                          !controller.isUseShinobiServer.isTrue);
                    },
                    child: Row(
                      children: [
                        Container(
                          height: Css.fontSize * 2,
                          child: Checkbox(
                            value: controller.isUseShinobiServer.isTrue,
                            fillColor: Get.theme.checkboxTheme.checkColor,
                            onChanged: (value) {
                              controller
                                  .onChangeUseShinobiServer(value ?? false);
                              storage.setItem(
                                  'exportJar_useShinobiServer', value);
                            },
                          ),
                        ),
                        Text('Use shinobiserver.jar')
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.isUseShinobiServer.isTrue,
                  child: SnbFileInput(
                    controller: shinobiServerController,
                    allowedExtensions: ['jar'],
                    labelText: 'shinobiserver.jar path',
                    onChanged: (String directory) {},
                  ),
                ),
              ],
            ),
          )),
          control(
              child: SnbButton(
                  text: "Export",
                  // isDisabled:
                  //     selectedItems.length == 0 || controller.hasProcessingItem(),
                  onPressed: () {}))
        ]));
  }

  Widget control({required Widget child}) {
    return Container(
      margin: EdgeInsets.only(bottom: Css.padding),
      child: child,
    );
  }
}

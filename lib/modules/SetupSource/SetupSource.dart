import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/styles/Css.dart';
import 'package:shinobi_tool/templates/RootTemplate.dart';
import 'package:shinobi_tool/utils/LocalStorage.dart';
import 'package:shinobi_tool/utils/SnbButton.dart';
import 'package:shinobi_tool/utils/SnbFileInput.dart';
import 'package:shinobi_tool/utils/SnbJson.dart';

import 'controllers/SetupSourceController.dart';

class SetupSourcePage extends StatelessWidget {
  SetupSourcePage({Key? key}) : super(key: key);
  final controller = Get.put(SetupSourceController());
  final LocalStorage storage = LocalStorage.instance();
  final TextEditingController projectDirectoryController =
      new TextEditingController();
  final TextEditingController gitUsernameController =
      new TextEditingController();
  final TextEditingController gitPasswordController =
      new TextEditingController();

  @override
  Widget build(context) {
    preload();
    return RootTemplate(
      title: 'Setup Source',
      child: buildBodyWidget(),
    );
  }

  void preload() {
    storage.getJsonAllData().then((SnbJson data) {
      gitUsernameController.text = data.getString('gitUsername');
      gitPasswordController.text = data.getString('gitPassword');
      projectDirectoryController.text = data.getString('projectDirectory');
    });
  }

  Widget buildBodyWidget() {
    return Container(
      child: Row(
        children: [
          Flexible(flex: 5, child: renderLoginInfo()),
          Container(width: Css.fontSize * 20, child: renderProjectList()),
        ],
      ),
    );
  }

  Widget control({required Widget child}) {
    return Container(
      margin: EdgeInsets.only(bottom: Css.padding),
      child: child,
    );
  }

  Widget renderProjectList() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: control(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Project list",
                  style: TextStyle(
                      fontSize: Css.fontSizeMedium,
                      fontWeight: Css.fontWeightBold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Css.paddingSmall),
                  child: Text(
                    "All project are presented below",
                    style: TextStyle(
                        fontSize: Css.fontSizeSemiSmall,
                        fontWeight: Css.fontWeightLight),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: Css.fontSize * 4),
          decoration:
              BoxDecoration(color: Css.isDark, borderRadius: Css.borderRadius),
          height: double.infinity,
          child: GetX<SetupSourceController>(
              builder: (_) => ListView.builder(
                  itemCount: controller.projectList.length,
                  itemBuilder: (context, index) {
                    SnbJson data = controller.projectList[index];
                    return buildProjectItem(data);
                  })),
        )
      ],
    );
  }

  Widget buildProjectItem(SnbJson data) {
    Color progressColor = Get.theme.hintColor;

    Widget progressIcon = Container();
    switch (data.getString('messageType')) {
      case 'loading':
        progressColor = Get.theme.hintColor;
        progressIcon = SpinKitDualRing(
          color: Get.theme.accentColor,
          size: Css.fontSizeSmall,
          lineWidth: 1,
        );
        break;
      case 'error':
        progressColor = Get.theme.errorColor;
        progressIcon = Icon(
          Icons.error_outline,
          color: progressColor,
          size: Css.fontSize,
        );
        break;
      case 'success':
        progressColor = Css.isGreen;
        progressIcon = Icon(
          Icons.check_circle_outline,
          color: progressColor,
          size: Css.fontSize,
        );
        break;
      default:
        break;
    }

    return InkWell(
      child: Container(
          padding: EdgeInsets.all(Css.paddingSmall),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: (data.containsKey('selected') &&
                            data.getBool('selected') == true),
                        onChanged: (value) {
                          onChangeProject(data);
                        },
                      ),
                      Text(data.getString('name'),
                          style: TextStyle(
                              fontSize: Css.fontSize,
                              fontWeight: Css.fontWeightBold)),
                    ],
                  ),
                  Text(data.getString('branch'),
                      style: TextStyle(fontWeight: Css.fontWeightLight))
                ],
              ),
              Container(
                child: (controller.isProcessing.isTrue &&
                        data.getBool('selected') == true)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Css.paddingSmall,
                                    right: Css.paddingSmall),
                                child: progressIcon,
                              ),
                              Text(
                                data.getString('message'),
                                style: TextStyle(
                                    fontSize: Css.fontSizeSemiSmall,
                                    color: progressColor),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: Css.paddingSmall),
                            child: Text(data.getString('progress') + '%',
                                style: TextStyle(
                                    fontSize: Css.fontSizeSemiSmall,
                                    color: Get.theme.hintColor)),
                          ),
                        ],
                      )
                    : Container(),
              )
            ],
          )),
      onTap: () {
        onChangeProject(data);
      },
    );
  }

  void onChangeProject(data) {
    if (controller.isProcessing.isFalse) {
      data.set(
          'selected',
          (!(data.containsKey('selected') && data.getBool('selected') == true))
              .toString());
      controller.updateProjectInfo(data);
    }
  }

  Widget renderLoginInfo() {
    return Container(
      padding: EdgeInsets.only(right: Css.paddingLarge, left: Css.padding),
      child: Column(
        children: [
          control(
            child: TextField(
              controller: gitUsernameController,
              onChanged: (value) => storage.setItem('gitUsername', value),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Git Username',
              ),
            ),
          ),
          control(
            child: TextField(
              controller: gitPasswordController,
              onChanged: (value) =>
                  storage.setItem('gitPassword', gitPasswordController.text),
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Git Password',
              ),
            ),
          ),
          control(
            child: SnbFileInput(
              controller: projectDirectoryController,
              isPickDirectory: true,
              onChanged: (String directory) {
                storage.setItem(
                    'projectDirectory', projectDirectoryController.text);
                this.projectDirectoryController.text = directory;
                print(directory);
              },
            ),
          ),
          control(child: GetX<SetupSourceController>(builder: (_) {
            List<SnbJson> selectedItems = controller.getSelectedProjectList();
            String text = "";
            if (selectedItems.length == 0) {
              text = 'Choose project to setup';
            }
            if (selectedItems.length == 1) {
              text = 'Setup project ' + selectedItems[0].getString('name');
            }
            if (selectedItems.length > 1) {
              text = 'Setup ${selectedItems.length} projects';
            }
            return SnbButton(
                text: text,
                isDisabled: selectedItems.length == 0,
                onPressed: () {
                  print("1" + projectDirectoryController.text);
                  controller.setupList(
                      username: gitUsernameController.text,
                      password: gitPasswordController.text,
                      projectDirectory: projectDirectoryController.text,
                      listProject: controller.getSelectedProjectList());
                });
          }))
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/styles/Css.dart';
import 'package:shinobi_tool/templates/RootTemplate.dart';
import 'package:shinobi_tool/utils/SnbJson.dart';

import 'controllers/SetupSourceController.dart';

class SetupSourcePage extends StatelessWidget {
  SetupSourcePage({Key? key}) : super(key: key);
  final controller = Get.put(SetupSourceController());

  @override
  Widget build(context) {
    return RootTemplate(
      title: 'Setup Source',
      child: buildBodyWidget(),
    );
  }

  Widget buildBodyWidget() {
    return Container(
      child: Row(
        children: [
          Flexible(flex: 5, child: renderLoginInfo()),
          Expanded(flex: 5, child: renderProjectList()),
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
    controller.buildProjectList();
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: control(
            child: Text(
              "Project list",
              style: TextStyle(fontSize: Css.fontSize),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: Css.fontSize * 2),
          height: double.infinity,
          child: GetX<SetupSourceController>(
              builder: (_) => ListView.builder(
                  itemCount: controller.projectList.length,
                  itemBuilder: (context, index) {
                    SnbJson data = controller.projectList[index];
                    data.printJson();
                    return InkWell(
                      child: Container(
                          padding: EdgeInsets.only(
                              top: Css.paddingSmall, bottom: Css.paddingSmall),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: data.containsKey('selected') &&
                                        data.getBool('selected') == true,
                                    onChanged: (value) {},
                                  ),
                                  Text(data.getString('name')),
                                ],
                              ),
                              Text(data.getString('branch'))
                            ],
                          )),
                          
                    );
                  })),
        )
      ],
    );
  }

  Widget renderLoginInfo() {
    return Padding(
      padding: EdgeInsets.only(right: Css.padding),
      child: Column(
        children: [
          control(
            child: Text(
              "Git login info",
              style: TextStyle(fontSize: Css.fontSize),
            ),
          ),
          control(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
          ),
          control(
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          )
        ],
      ),
    );
  }
}

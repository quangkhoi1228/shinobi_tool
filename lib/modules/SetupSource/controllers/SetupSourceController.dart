import 'dart:convert';

import 'package:get/get.dart';
import 'package:shinobi_tool/utils/FileUtil.dart';
import 'package:shinobi_tool/utils/SnbJson.dart';
import 'package:shinobi_tool/utils/SnbNotification.dart';

class SetupSourceController extends GetxController {
  var count = 0.obs;
  List projectList = [].obs;
  var isProcessing = false.obs;
  @override
  void onInit() {
    buildProjectList();
    super.onInit();
  }

  void setProjectList(List<SnbJson> list) {
    projectList.assignAll(list);
  }

  void updateProjectInfo(SnbJson data) {
    projectList.asMap().forEach((index, value) {
      if (value.getString('name') == data.getString('name')) {
        projectList[index] = data;
      }
    });
  }

  void buildProjectList() async {
    FileUtil.readFileFromAsset('assets/project-list.json')
        .then((String fileContent) {
      SnbJson content = SnbJson(fileContent);
      List<SnbJson> list = [];
      content.keys.forEach((key) {
        SnbJson item = content.getJson(key);
        list.add(SnbJson({
          "name": key,
          "git": item.getString('git'),
          "branch": item.getString('branch')
        }));
      });
      setProjectList(list);
    });
  }

  List<SnbJson> getSelectedProjectList() {
    List<SnbJson> result = [];
    projectList.forEach((element) {
      SnbJson item = SnbJson(json.encode(element));
      if (item.containsKey('selected') && item.getBool('selected') == true) {
        result.add(item);
      }
    });
    return result;
  }

  void setupList(
      {required String username,
      required String password,
      required String projectDirectory,
      required List<SnbJson> listProject}) {
    isProcessing.value = true;
    if (username == "" || password == "") {
      SnbNotification.error("Username or Password empty");
      return;
    }

    if (projectDirectory == '') {
      print(projectDirectory);

      SnbNotification.error("Project directory empty");
      return;
    }

    if (listProject.length == 0) {
      SnbNotification.error("Project list empty");
      return;
    }
    listProject.forEach((element) {
      setupProject(username, password, projectDirectory, element);
    });

    // isProcessing.value = false;
  }

  void updateProjectProgress(
      SnbJson project, int progress, String message, String messageType) {
    project.set('progress', progress);
    project.set("message", message);
    project.set("messageType", messageType);
    updateProjectInfo(project);
  }

  void setupProject(String username, String password, String projectDirectory,
      SnbJson project) {
    String projectName = project.getString('name');
    int progress = 0;
    //create project folder 10
    updateProjectProgress(
        project, progress, 'Create project directory', "loading");

    FileUtil.createFolder('$projectDirectory/$projectName', onExist: () {
      updateProjectProgress(
          project, progress, 'Directory already exists', "error");
      return;
    }, onNotExist: () {
      progress = 10;
      updateProjectProgress(project, progress, 'Done', "loading");
    });

    //create git folder 20
    updateProjectProgress(project, progress, 'Create git directory', "loading");

    FileUtil.createFolder('$projectDirectory/$projectName/git', onExist: () {
      updateProjectProgress(
          project, progress, 'Directory already exists', "error");
      return;
    }, onNotExist: () {
      progress = 20;
      updateProjectProgress(project, progress, 'Done', "loading");
    });

    //git config 50

    //git clone 70
    //git change to correct branch 100
    //done
    progress = 100;
    updateProjectProgress(project, progress, 'Done', "success");

    project.printJson();
  }
}

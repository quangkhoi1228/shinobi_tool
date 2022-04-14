import 'dart:convert';

import 'package:get/get.dart';
import 'package:process_run/shell.dart';
import 'package:shinobi_tool/utils/FileUtil.dart';
import 'package:shinobi_tool/utils/SnbJson.dart';
import 'package:shinobi_tool/utils/SnbNotification.dart';

class SetupSourceController extends GetxController {
  var count = 0.obs;
  List projectList = [].obs;
  var isProcessing = false.obs;
  var shell = Shell();
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
    FileUtil.readFileFromAsset('assets/setup-source/project-list.json')
        .then((String fileContent) {
      SnbJson content = SnbJson(fileContent);
      List<SnbJson> list = [];
      content.keys.forEach((key) {
        SnbJson item = content.getJson(key);
        list.add(SnbJson({
          "name": key,
          "git": item.getString('git'),
          "branch": item.getString('branch'),
          "selected": false,
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

  bool hasProcessingItem() {
    bool result = false;
    projectList.forEach((element) {
      SnbJson item = SnbJson(json.encode(element));
      if (item.getBool('selected') &&
          item.getString('messageType') == 'loading') {
        result = true;
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
  }

  void updateProjectProgress(
      SnbJson project, int progress, String message, String messageType) {
    project.set('progress', progress);
    project.set("message", message);
    project.set("messageType", messageType);
    updateProjectInfo(project);
    isProcessing.value = hasProcessingItem();
  }

  void setupProject(String username, String password, String projectDirectory,
      SnbJson project) {
    if (project.getString('messageType') == 'success') {
      isProcessing.value = hasProcessingItem();
      return;
    }
    String projectName = project.getString('name');
    String projectDirectoryFolder = "$projectDirectory/$projectName";
    String gitFolder = "$projectDirectoryFolder/git";
    int progress = 0;
    String messageType = 'loading';

    //create project folder 10
    void createProjectFolder({required Function next}) {
      updateProjectProgress(
          project, progress, 'Create project directory', messageType);

      if (messageType != 'error') {
        FileUtil.createFolder(projectDirectoryFolder, onExist: () {
          messageType = 'error';
          updateProjectProgress(
              project, progress, 'Directory already exists', messageType);
        }, onNotExist: () {
          progress = 10;
          messageType = 'loading';
          updateProjectProgress(project, progress, 'Done', messageType);
          next();
        });
      }
    }

    void createGitFolder({required Function next}) {
      //create git folder 20
      messageType = 'loading';
      updateProjectProgress(
          project, progress, 'Create git directory', messageType);
      FileUtil.createFolder(gitFolder, onExist: () {
        messageType = 'error';
        updateProjectProgress(
            project, progress, 'Directory already exists', messageType);
      }, onNotExist: () {
        messageType = 'loading';
        progress = 20;
        updateProjectProgress(project, progress, 'Done', messageType);
        next();
      });
    }

    //git config 50
    void gitConfig({required Function next}) {
      messageType = 'loading';
      updateProjectProgress(project, progress, 'Configuring git', messageType);
      var shell = Shell();

      shell.run('''
        cd $gitFolder
        git config --global user.name "$username"
        git config --global user.email "$username"
        git config --global user.password "$password"
        ''').then((value) {
        messageType = 'loading';
        progress = 50;
        updateProjectProgress(
            project, progress, 'Git config successfully', messageType);
        next();
      }).catchError((result) {
        print(result);
        messageType = 'error';
        updateProjectProgress(
            project, progress, 'Git config failure', messageType);
      });
    }

    //git clone 100
    void gitClone({required Function next}) {
      var shell = Shell();
      messageType = 'loading';
      updateProjectProgress(project, progress, 'Cloning git', messageType);
      String gitUrl = project.getString('git');
      String gitBranch = project.getString('branch');

      shell.run('''
        git clone -b $gitBranch $gitUrl $gitFolder/$projectName
        ''').then((value) {
        messageType = 'loading';
        progress = 100;
        updateProjectProgress(
            project, progress, 'Git clone successfully', messageType);
        next();
      }).catchError((result) {
        print(result);
        messageType = 'error';
        updateProjectProgress(
            project, progress, 'Git clone failure', messageType);
      });
    }

    //done
    void done() {
      messageType = 'success';
      progress = 100;
      updateProjectProgress(project, progress, 'Done', messageType);
      isProcessing.value = false;
    }

    //run
    createProjectFolder(next: () {
      createGitFolder(next: () {
        gitConfig(next: () {
          gitClone(next: () {
            done();
          });
        });
      });
    });
  }
}

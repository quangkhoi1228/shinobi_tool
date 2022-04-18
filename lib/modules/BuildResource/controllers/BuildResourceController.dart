import 'dart:io';

import 'package:get/get.dart';
import 'package:shinobi_tool/utils/FileUtil.dart';
import 'package:shinobi_tool/utils/LocalStorage.dart';
import 'package:shinobi_tool/utils/SnbNotification.dart';
import 'package:path/path.dart';

class BuildResourceController extends GetxController {
  LocalStorage storage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
  }

  void checkProjectDirectoryValid(String projectDirectory, Function callback) {
    if (projectDirectory == '') {
      SnbNotification.error('Project directory empty');
      return;
    }

    List<FileSystemEntity> fileSystemEntityList = FileUtil.getListFilesFromDir(
      projectDirectory,
      folderOnly: true,
    );

    bool hasWebFolder = false;

    fileSystemEntityList.forEach((element) {
      if (basename(element.path) == 'web') {
        hasWebFolder = true;
      }
    });

    if (hasWebFolder) {
      callback();
    } else {
      SnbNotification.error('Project directory not contain web folder');
      return;
    }
  }

  void createDefaultSetting(String projectDirectory) {
    checkProjectDirectoryValid(projectDirectory, () {
    });
  }

  void process() {
//     SnbTerminal.runCmd(
//       '''
// pwd
// chmod +x closure-compiler-v20190215.jar
// java -jar closure-compiler-v20190215.jar --js  shinobi_all.js --js_output_file  shinobi_all_min.js

// ''',
//       workingDirectory:
//           '/Volumes/home/Project/shinobi_tool/assets/build-resource/',
//       onSuccess: (results) {},
//       onError: (result) {},
//     );
  }
}

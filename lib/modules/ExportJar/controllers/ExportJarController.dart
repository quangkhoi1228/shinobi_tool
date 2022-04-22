import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:shinobi_tool/utils/FileUtil.dart';
import 'package:shinobi_tool/utils/LocalStorage.dart';
import 'package:shinobi_tool/utils/SnbNotification.dart';
import 'package:shinobi_tool/utils/SnbTerminal.dart';

class ExportJarController extends GetxController {
  RxBool isProcessing = false.obs;
  RxBool isUseShinobiServer = false.obs;
  LocalStorage storage = LocalStorage.instance();
  List logs = [].obs;

  @override
  void onInit() {
    storage.getJsonAllData().then((data) {
      onChangeUseShinobiServer(data.getBool('exportJar_useShinobiServer'));
    });
    super.onInit();
  }

  void onChangeUseShinobiServer(bool value) {
    isUseShinobiServer.value = value;
  }

  void checkProcessSuccessfully(
      {String? projectDirectory,
      required String projectName,
      String? mainClass,
      String? workspace,
      required String outputDirectory,
      bool? isUseShinobiServer,
      String? shinobiServerDirectory}) {
    String buildJarFilePath = '$outputDirectory/$projectName.jar';
    Timer.periodic(new Duration(seconds: 2), (Timer timer) {
      File file = File(buildJarFilePath);
      file.exists().then((value) {
        print(value);
        if (value) {
          isProcessing.value = false;
          timer.cancel();
          SnbNotification.success('Export jar file successfully');
        }
      });
    });
  }

  void procesing(
      {required String projectDirectory,
      required String projectName,
      required String mainClass,
      required String workspace,
      required String outputDirectory,
      required bool isUseShinobiServer,
      required String shinobiServerDirectory}) {
    print(projectDirectory +
        projectName +
        mainClass +
        workspace +
        outputDirectory +
        isUseShinobiServer.toString());
    isProcessing.value = true;
    if ([projectDirectory, projectName, mainClass, workspace, outputDirectory]
        .contains("")) {
      SnbNotification.error('Fill in all the information ');
      isProcessing.value = false;
      return;
    }

    if (isUseShinobiServer && shinobiServerDirectory == '') {
      SnbNotification.error('Enter the shinobiserver.jar path');
      isProcessing.value = false;
      return;
    }

    void createExportJarFile(String declareContent) {
      // FileUtil.readFileFromAsset('assets/export-jar/declare.sh')
      //     .then((declareContent) {
      FileUtil.readFileFromAsset('assets/export-jar/export-xml.sh')
          .then((exportXmlContent) {
        FileUtil.copyFile(
            'assets/export-jar/template.xml', '$outputDirectory/template.xml',
            isAssetSource: true);

        String script = '''
$declareContent
$exportXmlContent
''';

        FileUtil.writeFileFromAsset(
            '$outputDirectory/export-jar-file.command', script);

        SnbTerminal.runCmd('''
chmod +x $outputDirectory/export-jar-file.command
open $outputDirectory/export-jar-file.command

''', onSuccess: (results) {
          checkProcessSuccessfully(
              outputDirectory: outputDirectory, projectName: projectName);
        }, onError: (error) {
          SnbNotification.error(error.toString());
          isProcessing.value = false;
        });
      });
      // });
      //
    }

    FileUtil.readFileFromAsset('assets/export-jar/declare_template.sh')
        .then((String content) {
      content = content
          .replaceAll('{project_name}', projectName)
          .replaceAll('{project_dir}', projectDirectory)
          .replaceAll('{main_class}', mainClass)
          .replaceAll('{output_dir}', outputDirectory)
          .replaceAll('{workspace}', workspace)
          .replaceAll('{shinobi_server}', shinobiServerDirectory);

      FileUtil.writeFileFromAsset('assets/export-jar/declare.sh', content);
      createExportJarFile(content);
    });
  }
}

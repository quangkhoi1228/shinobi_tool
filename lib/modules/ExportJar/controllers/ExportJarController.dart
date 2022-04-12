import 'package:get/get.dart';
import 'package:process_run/shell.dart';
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
      data.printJson();
      onChangeUseShinobiServer(data.getBool('exportJar_useShinobiServer'));
    });
    super.onInit();
  }

  void onChangeUseShinobiServer(bool value) {
    isUseShinobiServer.value = value;
  }

  void procesing(
      {required String projectDirectory,
      required String projectName,
      required String mainClass,
      required String workspace,
      required String outputDirectory,
      required bool isUseShinobiServer,
      required String shinobiServerDirectory}) {
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

    void createExportJarFile() {
      FileUtil.readFileFromAsset('assets/export-jar/declare.sh')
          .then((declareContent) {
        FileUtil.readFileFromAsset('assets/export-jar/export-xml.sh')
            .then((exportXmlContent) {
          FileUtil.copyFile('assets/export-jar/template.xml',
              '$outputDirectory/template.xml');

          String script = '''
$declareContent
$exportXmlContent
''';

          FileUtil.writeFileFromAsset(
              '$outputDirectory/export-jar-file.sh', script);

          SnbTerminal.runCmd('''
sh $outputDirectory/export-jar-file.sh
''', onSuccess: (results) {
            results.forEach((element) {
              SnbNotification.success('Create export jar file successfully');
              isProcessing.value = false;
            });
          }, onError: (error) {
            SnbNotification.error(error.toString());
            isProcessing.value = false;
          });
        });
      });
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

      SnbTerminal.runCmd('''
rm $outputDirectory/template.xml
rm $outputDirectory/export-jar-file.sh
''', onSuccess: (results) {
        createExportJarFile();
      }, onError: (error) {
        createExportJarFile();
      });
    });
  }
}

import 'package:get/get.dart';
import 'package:shinobi_tool/utils/SnbTerminal.dart';

class BuildResourceController extends GetxController {
  var count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void process() {
    SnbTerminal.runCmd(
      '''
pwd
chmod +x closure-compiler-v20190215.jar
java -jar closure-compiler-v20190215.jar --js  shinobi_all.js --js_output_file  shinobi_all_min.js

''',
      workingDirectory:
          '/Volumes/home/Project/shinobi_tool/assets/build-resource/',
      onSuccess: (results) {},
      onError: (result) {},
    );
  }
}

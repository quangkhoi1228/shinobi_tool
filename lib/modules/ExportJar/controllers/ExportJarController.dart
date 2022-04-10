import 'package:get/get.dart';
import 'package:shinobi_tool/utils/LocalStorage.dart';

class ExportJarController extends GetxController {
  RxBool isProcessing = false.obs;
  RxBool isUseShinobiServer = false.obs;
  LocalStorage storage = LocalStorage.instance();

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

  void procesing() {
    isProcessing.value = true;
    
  }
}

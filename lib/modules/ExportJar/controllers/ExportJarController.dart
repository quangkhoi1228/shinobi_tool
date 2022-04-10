import 'package:get/get.dart';

class ExportJarController extends GetxController {
  var count = 0.obs;
  RxBool isUseShinobiServer = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onChangeUseShinobiServer(bool value) {
    isUseShinobiServer.value = value;
  }
}

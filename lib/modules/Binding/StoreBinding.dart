import 'package:get/get.dart';
import 'package:shinobi_tool/modules/SetupSource/controllers/SetupSourceController.dart';

class StoreBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => SetupSourceController());
  }
}

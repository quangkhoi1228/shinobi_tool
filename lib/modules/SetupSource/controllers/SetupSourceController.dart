import 'package:get/get.dart';
import 'package:shinobi_tool/utils/FileUtil.dart';
import 'package:shinobi_tool/utils/SnbJson.dart';

class SetupSourceController extends GetxController {
  var count = 0.obs;
  List projectList = [].obs;

  @override
  void onInit() {
    buildProjectList();
    super.onInit();
  }

  void setProjectList(List<SnbJson> list) {
    projectList.assignAll(list);
  }

  void onChangeSelectProject(SnbJson data) {
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
}

import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:task_app_2/model/section.dart';
import '../services/section_web_services.dart';
import '../utils/database_helper.dart';

class SectionController extends GetxController {
  var allSections = <Section>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSections();
  }

  Future<void> fetchSections() async {
    isLoading(true);
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        var sectionTemp = await SectionWebService.fetchSection('20');
        if (sectionTemp != null) {
          allSections(sectionTemp);
          await insertSectionsToDb(sectionTemp);
        }
      } else {
        var sectionsFromDb = await DatabaseHelper.db.getSectionList();
        allSections(sectionsFromDb);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> insertSectionsToDb(List<Section> sections) async {
    await deleteAllSectionsFromDb();
    for (Section s in sections) {
      await DatabaseHelper.db.insertSection(s);
    }
  }

  Future<void> deleteAllSectionsFromDb() async {
    await DatabaseHelper.db.deleteAllSection();
  }
}


import 'package:get/get.dart';
import 'package:task_app_2/model/section.dart';
import '../services/section_web_services.dart';
import '../utils/database_helper.dart';

class SectionController extends GetxController {
  var allSections = <Section>[].obs;
  var allSectionsFromDb = <Section>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSections();
  }

  fetchSectionsFromDb() async {
    var temp =  await DatabaseHelper.db.getSectionList();
    allSectionsFromDb(temp);
  }

  insertSectionsToDb(List<Section> sections) async {
    for (Section s in sections){
      await DatabaseHelper.db.insertSection(s);
    }
  }

  void fetchSections() async {
    isLoading(true);
    try {
      isLoading(true);
      var sectionTemp = await SectionWebService.fetchSection('20');
      if (sectionTemp != null) {
        allSections(sectionTemp);
        if (allSectionsFromDb.isEmpty){
          insertSectionsToDb(sectionTemp);
        }
      }
      else {
        fetchSectionsFromDb();
      }
    } finally {
      isLoading(false);
    }
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/section.dart';

class SectionWebService {
  static var client = http.Client();

  static Future<List<Section>?> fetchSection(String courseId) async {
    var response = await client.post(
      Uri.parse(
          'https://shukhi-dompoti-dev.mpower-social.com/local/mpower_api/course_section/data_service.php?service=get_course_sections'),
      body: {'courseid': courseId},
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print(jsonData);
      return (jsonData['response'] as List)
          .map((e) => Section.fromJson(e))
          .toList();
    } else {
      return null;
    }
  }
}

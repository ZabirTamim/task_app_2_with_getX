import 'dart:convert';


/// ================ Model for multiple sections ================

Sections sectionsFromMap(String str) => Sections.fromMap(json.decode(str));
String sectionsToMap(Sections data) => json.encode(data.toMap());

class Sections {
  List<Section> sections;

  Sections({
    required this.sections,
  });

  factory Sections.fromMap(Map<String, dynamic> json) => Sections(
    sections: List<Section>.from(json["response"].map((x) => Section.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "sections": List<dynamic>.from(sections.map((x) => x.toMap())),
  };
}


/// =========== Model for single Section ===========

Section sectionFromMap(String str) => Section.fromMap(json.decode(str));
String sectionToMap(Section data) => json.encode(data.toMap());

List<Section> sectionFromJson(String str) => List<Section>.from(json
    .decode(str)['response']
    .map((x) => Section.fromJson(Map<String, dynamic>.from(x))));

class Section {
  String moduleId;
  String? availability;
  String instance;
  String moduleType;
  String sectionTitle;
  String sectionImage;

  Section({
    required this.moduleId,
    this.availability,
    required this.instance,
    required this.moduleType,
    required this.sectionTitle,
    required this.sectionImage,
  });

  factory Section.fromMap(Map<String, dynamic> json) => Section(
    moduleId: json["moduleid"],
    availability: json["availability"],
    instance: json["instance"],
    moduleType: json["moduletype"],
    sectionTitle: json["sectiontitle"],
    sectionImage: json["sectionimage"],
  );
  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      moduleId: json['moduleid'],
      availability: json['availability'],
      instance: json['instance'],
      moduleType: json['moduletype'],
      sectionTitle: json['sectiontitle'],
      sectionImage: json['sectionimage'],
    );
  }

  Map<String, dynamic> toMap() => {
    "moduleid": moduleId,
    "availability": availability,
    "instance": instance,
    "moduletype": moduleType,
    "sectiontitle": sectionTitle,
    "sectionimage": sectionImage,
  };
  Map<String, dynamic> toJson() {
    return {
      'moduleid': moduleId,
      'availability': availability,
      'instance': instance,
      'moduletype': moduleType,
      'sectiontitle': sectionTitle,
      'sectionimage': sectionImage,
    };
  }
}

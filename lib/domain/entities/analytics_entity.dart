import 'package:rao_academy/domain/entities/date_filter_entity.dart';
import 'package:rao_academy/domain/entities/subject_list_entity.dart';

class AnalyticsEntity {
  AnalyticsEntity(
      {this.accuracy,
      this.allAccuracy,
      this.allCoins,
      this.allConfidence,
      this.allHours,
      this.allPerformance,
      this.allScore,
      this.allTests,
      this.coins,
      this.conceptBased,
      this.confidence,
      this.custom,
      this.dateFilter,
      this.hours,
      this.loop,
      this.other,
      this.performance,
      this.score,
      this.subjectList,
      this.tests});

  AnalyticsEntity.fromJson(Map<String, dynamic> json) {
    accuracy = json['accuracy'] as int?;
    allAccuracy = json['allAccuracy'] as int?;
    allCoins = json['allCoins'] as int?;
    allConfidence = json['allConfidence'] as int?;
    allHours = json['allHours'] as int?;
    allPerformance = json['allPerformance'] as int?;
    allScore = json['allScore'] as int?;
    allTests = json['allTests'] as int?;
    coins = json['coins'] as int?;
    conceptBased = json['conceptBased'] as int?;
    confidence = json['confidence'] as int?;
    custom = json['custom'] as int?;
    dateFilter = json['dateFilter'] != null
        ? DateFilter.fromJson(json['dateFilter'] as Map<String, dynamic>)
        : null;
    hours = json['hours'] as int?;
    loop = json['loop'] as int?;
    other = json['other'] as int?;
    performance = json['performance'] as int?;
    score = json['score'] as int?;
    if (json['subjectList'] != null) {
      subjectList = <SubjectList>[];
      (json['subjectList'] as List).forEach((v) {
        subjectList!.add(SubjectList.fromJson(v as Map<String, dynamic>));
      });
    }
    tests = json['tests'] as int?;
    strongSubject = json['strong subject'] as String?;
    strongSubjectImage = json['strong subject Image'] as String?;
    weakSubject = json['weak subject'] as String?;
    weakSubjectImage = json['weak subject Image'] as String?;
  }

  int? accuracy;
  int? allAccuracy;
  int? allCoins;
  int? allConfidence;
  int? allHours;
  int? allPerformance;
  int? allScore;
  int? allTests;
  int? coins;
  int? conceptBased;
  int? confidence;
  int? custom;
  DateFilter? dateFilter;
  int? hours;
  int? loop;
  int? other;
  int? performance;
  int? score;
  List<SubjectList>? subjectList;
  int? tests;
  String? strongSubject;
  String? strongSubjectImage;
  String? weakSubject;
  String? weakSubjectImage;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accuracy'] = accuracy;
    data['allAccuracy'] = allAccuracy;
    data['allCoins'] = allCoins;
    data['allConfidence'] = allConfidence;
    data['allHours'] = allHours;
    data['allPerformance'] = allPerformance;
    data['allScore'] = allScore;
    data['allTests'] = allTests;
    data['coins'] = coins;
    data['conceptBased'] = conceptBased;
    data['confidence'] = confidence;
    data['custom'] = custom;
    if (dateFilter != null) {
      data['dateFilter'] = dateFilter!.toJson();
    }
    data['hours'] = hours;
    data['loop'] = loop;
    data['other'] = other;
    data['performance'] = performance;
    data['score'] = score;
    if (subjectList != null) {
      data['subjectList'] = subjectList!.map((v) => v.toJson()).toList();
    }
    data['tests'] = tests;
    data['strong subject'] = strongSubject;
    data['strong subject Image'] = strongSubjectImage;
    data['weak subject'] = weakSubject;
    data['weak subject Image'] = weakSubjectImage;
    return data;
  }
}

import 'package:rao_academy/domain/entities/loops_entity.dart';
import 'package:rao_academy/domain/entities/progress_entity.dart';
import 'package:rao_academy/domain/entities/recommendations_entity.dart';
import 'package:rao_academy/domain/entities/report_entity.dart';

class HomeEntity {
  HomeEntity({
    // this.activity,
    this.banner,
    this.defaultSubjectId,
    this.name,
    this.newBadge,
    this.newSubscription,
    this.newTests,
    this.newWeeklyReports,
    this.reports,
    this.progress,
    this.recommendations,
    this.loops,
    this.referralNumber,
    // this.notifyForNewBadge,
    // this.notifyForNewTest,
    // this.notifyForNewWeeklyReport,
    // this.notifyForSubscription,
    this.message,
    this.notifyList
  });

  HomeEntity.fromJson(Map<String, dynamic> json) {
    /*  activity = json['activity'] != null
        ? Activity.fromJson(json['activity'] as Map<String, dynamic>)
        : null; */
    banner = (json['banner'] as List).cast<String>();
    defaultSubjectId = json['defaultSubjectId'] as num?;
    name = json['name'] as String?;
    notifyList = json['notifyList'] as List<dynamic>;
    newTests = json['newTests'] as String?;
    newSubscription = json['newSubscription'] as String?;
    message = json['message'] as String?;
    newBadge = json['newBadge'] as String?;
    newWeeklyReports = json['newWeeklyReports'] as String?;
    reports = json['reports'] != null
        ? Report.fromJson(json['reports'] as Map<String, dynamic>)
        : null;
    progress = json['progress'] != null
        ? Progress.fromJson(json['progress'] as Map<String, dynamic>)
        : null;
    if (json['recommendations'] != null) {
      recommendations = <TestEntity>[];

      (json['recommendations'] as List).forEach((v) {
        recommendations!.add(TestEntity.fromJson(v as Map<String, dynamic>));
      });
    }

    if (json['loops'] != null) {
      loops = <LoopsEntity>[];
      (json['loops'] as List).forEach((v) {
        loops!.add(LoopsEntity.fromJson(v as Map<String, dynamic>));
      });
    }

    // notifyForNewBadge = json['notifyForNewBadge'] as bool?;
    // notifyForNewWeeklyReport = json['notifyForNewWeeklyReport'] as bool?;
    // notifyForNewTest = json['notifyForNewTest'] as bool?;
    // notifyForSubscription = json['notifyForSubscription'] as bool?;

    referralNumber = json['referralNumber'] as String?;
  }

  // Activity? activity;
  List<String>? banner; //.
  List<dynamic>? notifyList;
  num? defaultSubjectId; //.
  String? name; //.
  String? newBadge; //.
  String? newSubscription; //.
  String? newTests; //.
  String? message;
  String? newWeeklyReports; //.
  // bool? notifyForNewBadge;
  // bool? notifyForNewWeeklyReport;
  // bool? notifyForNewTest;
  // bool? notifyForSubscription;
  Progress? progress;
  Report? reports; //.
  List<TestEntity>? recommendations; //.
  List<LoopsEntity>? loops; //.
  String? referralNumber; //.

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    /*if (activity != null) {
      data['activity'] = activity!.toJson();
    } */
    if (loops != null) {
      data['loops'] = loops!.map((v) => v.toJson()).toList();
    }

    data['banner'] = banner;
    data['notifyList'] = notifyList;
    data['defaultSubjectId'] = defaultSubjectId;
    data['name'] = name;
    data['newTests'] = newTests;
    data['newWeeklyReports'] = newWeeklyReports;
    data['message'] = message;
    if (reports != null) {
      data['performance'] = reports!.toJson();
    }
    if (progress != null) {
      data['progress'] = progress!.toJson();
    }
    if (recommendations != null) {
      data['recommendations'] =
          recommendations!.map((v) => v.toJson()).toList();
    }
    data['referralNumber'] = referralNumber;
    // data['notifyForNewBadge'] = notifyForNewBadge;
    // data['notifyForNewTest'] = notifyForNewTest;
    // data['notifyForSubscription'] = notifyForSubscription;
    // data['notifyForNewWeeklyReport'] = notifyForNewWeeklyReport;
    return data;
  }
}

/* class Performance {
  Performance(
      {this.friday,
      this.monday,
      this.saturday,
      this.sunday,
      this.thursday,
      this.tuesday,
      this.wednesday});

  Performance.fromJson(Map<String, dynamic> json) {
    friday = json['Friday'] as num?;
    monday = json['Monday'] as num?;
    saturday = json['Saturday'] as num?;
    sunday = json['Sunday'] as num?;
    thursday = json['Thursday'] as num?;
    tuesday = json['Tuesday'] as num?;
    wednesday = json['Wednesday'] as num?;
  }

  num? friday;
  num? monday;
  num? saturday;
  num? sunday;
  num? thursday;
  num? tuesday;
  num? wednesday;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Friday'] = friday;
    data['Monday'] = monday;
    data['Saturday'] = saturday;
    data['Sunday'] = sunday;
    data['Thursday'] = thursday;
    data['Tuesday'] = tuesday;
    data['Wednesday'] = wednesday;
    return data;
  }
}
 */

class DaySubject {
  DaySubject(
      {this.biology,
      this.chemistry,
      this.economics,
      this.general,
      this.geography,
      this.history,
      this.maths,
      this.physics,
      this.politicalScience});

  DaySubject.fromJson(Map<String, dynamic> json) {
    biology = json['Biology'] as num?;
    chemistry = json['Chemistry'] as num?;
    economics = json['Economics'] as num?;
    general = json['General'] as num?;
    geography = json['Geography'] as num?;
    history = json['History'] as num?;
    maths = json['Maths'] as num?;
    physics = json['Physics'] as num?;
    politicalScience = json['Political Science'] as num?;
  }

  num? biology;
  num? chemistry;
  num? economics;
  num? general;
  num? geography;
  num? history;
  num? maths;
  num? physics;
  num? politicalScience;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Biology'] = biology;
    data['Chemistry'] = chemistry;
    data['Economics'] = economics;
    data['General'] = general;
    data['Geography'] = geography;
    data['History'] = history;
    data['Maths'] = maths;
    data['Physics'] = physics;
    data['Political Science'] = politicalScience;
    return data;
  }
}

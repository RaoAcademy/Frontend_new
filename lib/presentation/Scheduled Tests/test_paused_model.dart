// To parse this JSON data, do
//
//     final testPausedModel = testPausedModelFromJson(jsonString);

import 'dart:convert';

TestPausedModel testPausedModelFromJson(String str) => TestPausedModel.fromJson(json.decode(str) as Map<String,dynamic>);

String testPausedModelToJson(TestPausedModel data) => json.encode(data.toJson());

class TestPausedModel {
  List<TestPausedModelTest> tests = [];

  TestPausedModel({
    required this.tests,
  });

  factory TestPausedModel.fromJson(Map<String, dynamic> json) => TestPausedModel(
    tests: (json["tests"] as List<dynamic>)
        .map((x) => TestPausedModelTest.fromJson(x as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    "tests": List<dynamic>.from(tests.map((x) => x.toJson())),
  };
}

class TestPausedModelTest {
  String? month;
  List<TestTest> tests = [];

  TestPausedModelTest({
    this.month,
    required this.tests,
  });

  factory TestPausedModelTest.fromJson(Map<String, dynamic> json) => TestPausedModelTest(
    month: json["month"] as String,
    tests: List<TestTest>.from((json["tests"] as List<dynamic>).map((x) => TestTest.fromJson(x as Map<String, dynamic>)).toList()),
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "tests": List<dynamic>.from(tests.map((x) => x.toJson())),
  };
}

class TestTest {
  int? noOfQs;
  int? coins;
  String? date;
  String? endTime;
  dynamic formats;
  String? imagePath;
  String? leftTop;
  dynamic levels;
  int? maxTime;
  int? missed;
  bool? results;
  bool? resume;
  int? resumeQuesId;
  dynamic rightTop;
  String? startTime;
  String? syllabus;
  int? testId;
  String? text1;
  String? text2;
  String? text3;
  String? userTestId;

  TestTest({
    this.noOfQs,
    this.coins,
    this.date,
    this.endTime,
    this.formats,
    this.imagePath,
    this.leftTop,
    this.levels,
    this.maxTime,
    this.missed,
    this.results,
    this.resume,
    this.resumeQuesId,
    this.rightTop,
    this.startTime,
    this.syllabus,
    this.testId,
    this.text1,
    this.text2,
    this.text3,
    this.userTestId
  });

  factory TestTest.fromJson(Map<String, dynamic> json) => TestTest(
    noOfQs: json["NoOfQs"] as int?,
    coins: json["coins"] as int?,
    date: json["date"] as String?,
    endTime: json["endTime"] as String?,
    formats: json["formats"] as String?,
    imagePath: json["imagePath"] as String?,
    leftTop: json["leftTop"] as String?,
    levels: json["levels"] as String?,
    maxTime: json["maxTime"] as int?,
    missed: json["missed"] as int?,
    results: json["results"] as bool?,
    resume: json["resume"] as bool?,
    resumeQuesId: json["resumeQuesId"] as int?,
    rightTop: json["rightTop"] as String?,
    startTime: json["startTime"] as String?,
    syllabus: json["syllabus"] as String?,
    testId: json["testId"] as int?,
    text1: json["text1"] as String?,
    text2: json["text2"] as String?,
    text3: json["text3"] as String?,
    userTestId: json["userTestId"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "NoOfQs": noOfQs,
    "coins": coins,
    "date": date,
    "endTime": endTime,
    "formats": formats,
    "imagePath": imagePath,
    "leftTop": leftTop,
    "levels": levels,
    "maxTime": maxTime,
    "missed": missed,
    "results": results,
    "resume": resume,
    "resumeQuesId": resumeQuesId,
    "rightTop": rightTop,
    "startTime": startTime,
    "syllabus": syllabus,
    "testId": testId,
    "text1": text1,
    "text2": text2,
    "text3": text3,
    "userTestId": userTestId,
  };
}

// To parse this JSON data, do
//
//     final testModel = testModelFromJson(jsonString);

import 'dart:convert';

TestModel testModelFromJson(String str) => TestModel.fromJson(json.decode(str) as Map<String,dynamic>);

String testModelToJson(TestModel data) => json.encode(data.toJson());

class TestModel {
  List<TestM> tests =[];

  TestModel({
    required this.tests,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
    tests: List<TestM>.from(json["tests"].map((x) => TestM.fromJson(x as Map<String,dynamic>)) as List<TestM>),
  );

  Map<String, dynamic> toJson() => {
    "tests": List<dynamic>.from(tests.map((x) => x.toJson())),
  };
}

class TestM {
  int? noOfQs;
  int? coins;
  DateTime? date;
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

  TestM({
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
  });

  factory TestM.fromJson(Map<String, dynamic> json) => TestM(
    noOfQs: json["NoOfQs"] as int,
    coins: json["coins"] as int,
    date: DateTime.parse(json["date"] as String),
    endTime: json["endTime"] as String,
    formats: json["formats"] as String,
    imagePath: json["imagePath"] as String,
    leftTop: json["leftTop"] as String,
    levels: json["levels"] as String,
    maxTime: json["maxTime"] as int,
    missed: json["missed"] as int,
    results: json["results"] as bool,
    resume: json["resume"] as bool,
    resumeQuesId: json["resumeQuesId"] as int,
    rightTop: json["rightTop"] as String,
    startTime: json["startTime"] as String,
    syllabus: json["syllabus"] as String,
    testId: json["testId"] as int,
    text1: json["text1"] as String,
    text2: json["text2"] as String,
    text3: json["text3"] as String,
  );

  Map<String, dynamic> toJson() => {
    "NoOfQs": noOfQs,
    "coins": coins,
    "date": "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
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
  };
}

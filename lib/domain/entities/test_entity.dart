class Test {
  Test(
      {this.date,
      this.resume,
      this.result,
      // this.subjectId,
      this.testId,
      this.testType,
      this.text1,
      this.text2,
      this.text3,
      this.userTestId,
      this.chapterIds,
      this.conceptIds,
      this.formats,
      this.levels,
      this.questionIds,
      this.practice});

  Test.fromJson(Map<String, dynamic> json) {
    date = json['date'] as String?;
    chapterIds = json['chapterIds'] as String?;
    conceptIds = json['conceptIds'] as String?;
    formats = json['formats'] as String?;
    levels = json['levels'] as String?;
    questionIds = json['questionIds'] as String?;
    resume = json['resume'] as bool?;
    result = json['results'] as bool?;
    // subjectId = json['progress'] as num?;
    testId = json['testId'] as num?;
    testType = json['testType'] as String?;
    text1 = json['text1'] as String?;
    text2 = json['text2'] as String?;
    text3 = json['text3'] as String?;
    userTestId = json['userTestId'] as num?;
    practice = json['practice'] as bool?;
  }

  String? date;
  String? chapterIds;
  String? conceptIds;
  String? formats;
  String? levels;
  String? questionIds;
  bool? resume;
  bool? result;
  num? testId;
  // num? subjectId;
  String? testType;
  String? text1;
  String? text2;
  String? text3;
  num? userTestId;
  bool? practice;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['resume'] = resume;
    data['chapterIds'] = chapterIds;
    data['conceptIds'] = conceptIds;
    data['formats'] = formats;
    data['levels'] = levels;
    data['questionIds'] = questionIds;
    data['result'] = result;
    data['testId'] = testId;
    // data['subjectId'] = subjectId;
    data['testType'] = testType;
    data['text1'] = text1;
    data['text2'] = text2;
    data['text3'] = text3;
    data['userTestId'] = userTestId;
    data['practice'] = practice;
    return data;
  }
}

class TestStart {
  TestStart({
    this.poorPerformanceMessage,
    this.resumeQuesId,
    this.userTestId,
    this.question,
    this.testType,
  });

  factory TestStart.fromMap(Map<String, dynamic> map) {
    final TestStart testStart = TestStart(
      poorPerformanceMessage: map['msg'] as String?,
      testType: map['testType'] as String?,
      resumeQuesId: map['resumeQuesId'] as int?,
      userTestId: map['userTestId'] != null
          ? int.parse(map['userTestId'].toString())
          : 0,
      question: map['question'] != null
          ? List<Question>.from((map['question'] as List)
              .map((x) => Question.fromJson(x as Map<String, dynamic>)))
          : null,
    );
    return testStart;
  }
  String? poorPerformanceMessage;
  String? testType;
  int? resumeQuesId;
  num? userTestId;
  List<Question>? question;
}

class Question {
  Question({
    this.ansExpImage,
    this.ansExplanation,
    this.answer,
    this.choice1,
    this.choice1ImagePath,
    this.choice2,
    this.choice2ImagePath,
    this.choice3,
    this.choice3ImagePath,
    this.choice4,
    this.choice4ImagePath,
    this.format,
    this.hints,
    this.previousYearApearance,
    this.questionId,
    this.questionImagePath,
    this.questionTags,
    this.questionText,
    this.leftChoice1,
    this.leftChoice1ImagePath,
    this.leftChoice2,
    this.leftChoice2ImagePath,
    this.leftChoice3,
    this.leftChoice3ImagePath,
    this.leftChoice4,
    this.leftChoice4ImagePath,
    this.rightChoice1,
    this.rightChoice1ImagePath,
    this.rightChoice2,
    this.rightChoice2ImagePath,
    this.rightChoice3,
    this.rightChoice3ImagePath,
    this.rightChoice4,
    this.rightChoice4ImagePath,
  });

  Question.fromJson(Map<String, dynamic> json) {
    ansExpImage = json['ansExpImage'] as String?;
    ansExplanation = json['ansExplanation'] as String?;
    answer = json['answer'] as String?;
    choice1 = json['choice1'] as String?;
    choice1ImagePath = json['choice1ImagePath'] as String?;
    choice2 = json['choice2'] as String?;
    choice2ImagePath = json['choice2ImagePath'] as String?;
    choice3 = json['choice3'] as String?;
    choice3ImagePath = json['choice3ImagePath'] as String?;
    choice4 = json['choice4'] as String?;
    choice4ImagePath = json['choice4ImagePath'] as String?;

    leftChoice1 = json['leftChoice1'] as String?;
    leftChoice1ImagePath = json['leftChoice1ImagePath'] as String?;
    leftChoice2 = json['leftChoice2'] as String?;
    leftChoice2ImagePath = json['leftChoice2ImagePath'] as String?;
    leftChoice3 = json['leftChoice3'] as String?;
    leftChoice3ImagePath = json['leftChoice3ImagePath'] as String?;
    leftChoice4 = json['leftChoice4'] as String?;
    leftChoice4ImagePath = json['leftChoice4ImagePath'] as String?;

    rightChoice1 = json['rightChoice1'] as String?;
    rightChoice1ImagePath = json['rightChoice1ImagePath'] as String?;
    rightChoice2 = json['rightChoice2'] as String?;
    rightChoice2ImagePath = json['rightChoice2ImagePath'] as String?;
    rightChoice3 = json['rightChoice3'] as String?;
    rightChoice3ImagePath = json['rightChoice3ImagePath'] as String?;
    rightChoice4 = json['rightChoice4'] as String?;
    rightChoice4ImagePath = json['rightChoice4ImagePath'] as String?;

    format = json['format'] as String?;
    hints = json['hints'] as String?;
    previousYearApearance = json['previousYearApearance'] as String?;
    questionId = json['questionId'] as num?;
    questionImagePath = json['questionImagePath'] as String?;
    questionTags = json['questionTags'] as String?;
    questionText = json['questionText'] as String?;
  }
  String? ansExpImage;
  String? ansExplanation;
  String? answer;
  String? choice1;
  String? choice1ImagePath;
  String? choice2;
  String? choice2ImagePath;
  String? choice3;
  String? choice3ImagePath;
  String? choice4;
  String? choice4ImagePath;

  String? leftChoice1;
  String? leftChoice1ImagePath;
  String? leftChoice2;
  String? leftChoice2ImagePath;
  String? leftChoice3;
  String? leftChoice3ImagePath;
  String? leftChoice4;
  String? leftChoice4ImagePath;

  String? rightChoice1;
  String? rightChoice1ImagePath;
  String? rightChoice2;
  String? rightChoice2ImagePath;
  String? rightChoice3;
  String? rightChoice3ImagePath;
  String? rightChoice4;
  String? rightChoice4ImagePath;

  String? format;
  String? hints;
  String? previousYearApearance;
  num? questionId;
  String? questionImagePath;
  String? questionTags;
  String? questionText;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ansExpImage'] = ansExpImage;
    data['ansExplanation'] = ansExplanation;
    data['answer'] = answer;
    data['choice1'] = choice1;
    data['choice1ImagePath'] = choice1ImagePath;
    data['choice2'] = choice2;
    data['choice2ImagePath'] = choice2ImagePath;
    data['choice3'] = choice3;
    data['choice3ImagePath'] = choice3ImagePath;
    data['choice4'] = choice4;
    data['choice4ImagePath'] = choice4ImagePath;
    data['format'] = format;
    data['hints'] = hints;
    data['previousYearApearance'] = previousYearApearance;
    data['questionId'] = questionId;
    data['questionImagePath'] = questionImagePath;
    data['questionTags'] = questionTags;
    data['questionText'] = questionText;
    return data;
  }
}

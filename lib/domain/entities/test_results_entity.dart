import 'package:flutter/foundation.dart';
import 'package:EdTestz/domain/entities/concept_entity.dart';
import 'package:EdTestz/domain/entities/difficulty_level_entity.dart';
import 'package:EdTestz/domain/entities/overall_entity.dart';
import 'package:EdTestz/domain/entities/question_format_entity.dart';

class TestResultsEntity {
  TestResultsEntity(
      {this.accuracy,
      this.coinsEarned,
      this.concept,
      this.difficultyLevel,
      this.overall,
      this.performance,
      this.practiceTest,
      this.practiceTestUserTestId,
      this.questionFormat,
      this.score,
      this.testIdForRepeat});

  TestResultsEntity.fromJson(Map<String, dynamic> json) {
    accuracy = json['accuracy'] as num?;
    coinsEarned = json['coinsEarned'] as String?;

    if (json['concept'] != null) {
      concept = <Concept>[];
      (json['concept'] as List).forEach((v) {
        concept!.add(Concept.fromJson(v as Map<String, dynamic>));
      });
    }
    if (kDebugMode) {
      print("1>");
    }
    if (json['difficultyLevel'] != null) {
      difficultyLevel = <DifficultyLevel>[];
      (json['difficultyLevel'] as List).forEach((v) {
        difficultyLevel!
            .add(DifficultyLevel.fromJson(v as Map<String, dynamic>));
      });
    }
    if (kDebugMode) {
      print("2>");
    }
    overall = json['overall'] != null
        ? Overall.fromJson(json['overall'] as Map<String, dynamic>)
        : null;
    performance = json['performance'] as String?;
    practiceTestUserTestId = json['practiceTestUserTestId'] as num?;
    practiceTest = json['practiceTestId'] as int?;
    if (json['questionFormat'] != null) {
      questionFormat = <QuestionFormat>[];
      (json['questionFormat'] as List).forEach((v) {
        questionFormat!.add(QuestionFormat.fromJson(v as Map<String, dynamic>));
      });
    }
    if (kDebugMode) {
      print("3>");
    }
    score = json['score'] as String?;
    testIdForRepeat = json['testIdForRepeat'] as num?;
  }

  num? accuracy;
  String? coinsEarned;
  List<Concept>? concept;
  List<DifficultyLevel>? difficultyLevel;
  Overall? overall;
  String? performance;
  int? practiceTest;
  num? practiceTestUserTestId;
  List<QuestionFormat>? questionFormat;
  String? score;
  num? testIdForRepeat;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accuracy'] = accuracy;
    data['coinsEarned'] = coinsEarned;
    if (concept != null) {
      data['concept'] = concept!.map((v) => v.toJson()).toList();
    }
    if (difficultyLevel != null) {
      data['difficultyLevel'] =
          difficultyLevel!.map((v) => v.toJson()).toList();
    }
    if (overall != null) {
      data['overall'] = overall!.toJson();
    }
    data['performance'] = performance;
    data['practiceTestUserTestId'] = practiceTestUserTestId;
    data['practiceTestId'] = practiceTest;
    if (questionFormat != null) {
      data['questionFormat'] = questionFormat!.map((v) => v.toJson()).toList();
    }
    data['score'] = score;
    data['testIdForRepeat'] = testIdForRepeat;
    return data;
  }
}

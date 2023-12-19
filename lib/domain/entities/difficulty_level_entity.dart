
import 'package:flutter/foundation.dart';

class DifficultyLevel {
  DifficultyLevel(
      {this.accuracy,
      this.correct,
      this.correctTotal,
      this.level,
      this.incorrect,
      this.incorrectTotal,
      this.notAnswered,
      this.notAnsweredTotal,
      this.partial,
      this.partialTotal,
      this.time,
      this.totalQuestions});

  DifficultyLevel.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print("TEST");
    }
    accuracy = json['accuracy'] as int?;
    if (kDebugMode) {
      print("TEST AFTER");
    }
    correct = json['correct'] as String?;
    correctTotal = json['correctTotal'] as num?;
    level = json['level'] as String?;
    incorrect = json['incorrect'] as String?;
    incorrectTotal = json['incorrectTotal'] as num?;
    notAnswered = json['notAnswered'] as String?;
    notAnsweredTotal = json['notAnsweredTotal'] as num?;
    partial = json['partial'] as String?;
    partialTotal = json['partialTotal'] as num?;
    time = json['time'] as int?;
    totalQuestions = json['totalQuestions'] as num?;
  }
  int? accuracy;
  String? correct;
  num? correctTotal;
  String? level;
  String? incorrect;
  num? incorrectTotal;
  String? notAnswered;
  num? notAnsweredTotal;
  String? partial;
  num? partialTotal;
  int? time;
  num? totalQuestions;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accuracy'] = accuracy;
    data['correct'] = correct;
    data['correctTotal'] = correctTotal;
    data['level'] = level;
    data['incorrect'] = incorrect;
    data['incorrectTotal'] = incorrectTotal;
    data['notAnswered'] = notAnswered;
    data['notAnsweredTotal'] = notAnsweredTotal;
    data['partial'] = partial;
    data['partialTotal'] = partialTotal;
    data['time'] = time;
    data['totalQuestions'] = totalQuestions;
    return data;
  }
}

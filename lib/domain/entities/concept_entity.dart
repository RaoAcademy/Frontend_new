class Concept {
  Concept(
      {this.conceptName,
      this.correct,
      this.correctTotal,
      this.incorrect,
      this.incorrectTotal,
      this.notAnswered,
      this.notAnsweredTotal,
      this.partial,
      this.partialTotal,
      this.score,
      this.scoreTotal,
      this.totalQuestions});

  Concept.fromJson(Map<String, dynamic> json) {
    conceptName = json['conceptName'] as String?;
    correct = json['correct'] as String?;
    correctTotal = json['correctTotal'] as num?;
    incorrect = json['incorrect'] as String?;
    incorrectTotal = json['incorrectTotal'] as num?;
    notAnswered = json['notAnswered'] as String?;
    notAnsweredTotal = json['notAnsweredTotal'] as num?;
    partial = json['partial'] as String?;
    partialTotal = json['partialTotal'] as num?;
    score = json['score'] as num?;
    scoreTotal = json['scoreTotal'] as num?;
    totalQuestions = json['totalQuestions'] as num?;
  }

  String? conceptName;
  String? correct;
  num? correctTotal;
  String? incorrect;
  num? incorrectTotal;
  String? notAnswered;
  num? notAnsweredTotal;
  String? partial;
  num? partialTotal;
  num? score;
  num? scoreTotal;
  num? totalQuestions;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conceptName'] = conceptName;
    data['correct'] = correct;
    data['correctTotal'] = correctTotal;
    data['incorrect'] = incorrect;
    data['incorrectTotal'] = incorrectTotal;
    data['notAnswered'] = notAnswered;
    data['notAnsweredTotal'] = notAnsweredTotal;
    data['partial'] = partial;
    data['partialTotal'] = partialTotal;
    data['score'] = score;
    data['scoreTotal'] = scoreTotal;
    data['totalQuestions'] = totalQuestions;
    return data;
  }
}

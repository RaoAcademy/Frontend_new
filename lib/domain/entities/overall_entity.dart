class Overall {
  Overall(
      {this.correct,
      this.correctTotal,
      this.incorrect,
      this.incorrectTotal,
      this.notAnswered,
      this.notAnsweredTotal,
      this.partial,
      this.partitalTotal});

  Overall.fromJson(Map<String, dynamic> json) {
    correct = json['correct'] as String?;
    correctTotal = json['correctTotal'] as num?;
    incorrect = json['incorrect'] as String;
    incorrectTotal = json['incorrectTotal'] as num?;
    notAnswered = json['notAnswered'] as String?;
    notAnsweredTotal = json['notAnsweredTotal'] as num?;
    partial = json['partial'] as String?;
    partitalTotal = json['partitalTotal'] as num?;
  }

  String? correct;
  num? correctTotal;
  String? incorrect;
  num? incorrectTotal;
  String? notAnswered;
  num? notAnsweredTotal;
  String? partial;
  num? partitalTotal;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['correct'] = correct;
    data['correctTotal'] = correctTotal;
    data['incorrect'] = incorrect;
    data['incorrectTotal'] = incorrectTotal;
    data['notAnswered'] = notAnswered;
    data['notAnsweredTotal'] = notAnsweredTotal;
    data['partial'] = partial;
    data['partitalTotal'] = partitalTotal;
    return data;
  }
}

class LoopTestList {
  LoopTestList(
      {this.confidence,
      this.knowledge,
      this.name,
      this.performance,
      this.persistance,
      this.score});

  LoopTestList.fromJson(Map<String, dynamic> json) {
    confidence = json['confidence'] as num?;
    knowledge = json['knowledge'] as num?;
    name = json['name'] as String?;
    performance = json['performance'] as num?;
    persistance = json['persistance'] as num?;
    score = json['score'] as num?;
  }

  num? confidence;
  num? knowledge;
  String? name;
  num? performance;
  num? persistance;
  num? score;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['confidence'] = confidence;
    data['knowledge'] = knowledge;
    data['name'] = name;
    data['performance'] = performance;
    data['persistance'] = persistance;
    data['score'] = score;
    return data;
  }
}

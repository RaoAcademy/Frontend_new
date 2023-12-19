class ConceptList {
  ConceptList(
      {this.confidence,
      this.knowledge,
      this.name,
      this.performance,
      this.persistance,
        this.accuracy,
      this.score});

  ConceptList.fromJson(Map<String, dynamic> json) {
    confidence = json['confidence'] as num?;
    knowledge = json['knowledge'] as num?;
    name = json['name'] as String?;
    performance = json['performance'] as num?;
    persistance = json['persistance'] as num?;
    score = json['score'] as num?;
    accuracy = json['accuracy'] as num?;
  }

  num? confidence;
  num? knowledge;
  String? name;
  num? performance;
  num? persistance;
  num? score;
  num? accuracy;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['confidence'] = confidence;
    data['knowledge'] = knowledge;
    data['name'] = name;
    data['performance'] = performance;
    data['persistance'] = persistance;
    data['score'] = score;
    data['accuracy'] = accuracy;
    return data;
  }
}

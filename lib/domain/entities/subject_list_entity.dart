class SubjectList {
  int? accuracy;
  int? conceptBased;
  int? confidence;
  int? custom;
  int? id;
  int? loop;
  String? name;
  int? other;
  int? performance;
  int? score;
  int? tests;

  SubjectList({
    this.accuracy,
    this.conceptBased,
    this.confidence,
    this.custom,
    this.id,
    this.loop,
    this.name,
    this.other,
    this.performance,
    this.score,
    this.tests,
  });

  factory SubjectList.fromJson(Map<String, dynamic> json) => SubjectList(
    accuracy: json["accuracy"] as int?,
    conceptBased: json["conceptBased"] as int?,
    confidence: json["confidence"] as int?,
    custom: json["custom"] as int?,
    id: json["id"] as int?,
    loop: json["loop"] as int?,
    name: json["name"] as String?,
    other: json["other"] as int?,
    performance: json["performance"] as int?,
    score: json["score"] as int?,
    tests: json["tests"] as int?,
  );

  Map<String, dynamic> toJson() => {
    "accuracy": accuracy,
    "conceptBased": conceptBased,
    "confidence": confidence,
    "custom": custom,
    "id": id,
    "loop": loop,
    "name": name,
    "other": other,
    "performance": performance,
    "score": score,
    "tests": tests,
  };
}
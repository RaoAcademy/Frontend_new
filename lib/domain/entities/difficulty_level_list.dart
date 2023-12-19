class DifficultyLevelList {
  DifficultyLevelList({this.name, this.score, this.scoreTotal});

  DifficultyLevelList.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    score = json['score'] as num?;
    scoreTotal = json['scoreTotal'] as num?;
  }
  String? name;
  num? score;
  num? scoreTotal;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['score'] = score;
    data['scoreTotal'] = scoreTotal;
    return data;
  }
}

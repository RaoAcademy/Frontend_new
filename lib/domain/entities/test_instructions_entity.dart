class TestInstructionsEntity {
  TestInstructionsEntity(
      {this.description,
      // this.format,
      // this.level,
      this.marksDistribution,
      this.name,
      this.preparedBy,
      this.subscriptionExpired,
      this.syllabus,
      this.tags});

  TestInstructionsEntity.fromJson(Map<String, dynamic> json) {
    description = json['description'] as String?;
    // format = json['format'];
    // level = json['level'];
    marksDistribution = json['marksDistribution'] != null
        ? MarksDistribution.fromJson(
            json['marksDistribution'] as Map<String, dynamic>)
        : null;
    name = json['name'] as String?;
    preparedBy = json['preparedBy'] as String?;
    subscriptionExpired = json['subscriptionExpired'] as bool?;
    syllabus = json['syllabus'] as String?;
    tags = json['tags'] as String?;
  }

  String? description;
  // Null? format;
  // Null? level;
  MarksDistribution? marksDistribution;
  String? name;
  String? preparedBy;
  bool? subscriptionExpired;
  String? syllabus;
  String? tags;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    // data['format'] = this.format;
    // data['level'] = this.level;
    if (marksDistribution != null) {
      data['marksDistribution'] = marksDistribution!.toJson();
    }
    data['name'] = name;
    data['preparedBy'] = preparedBy;
    data['subscriptionExpired'] = subscriptionExpired;
    data['syllabus'] = syllabus;
    data['tags'] = tags;
    return data;
  }
}

class MarksDistribution {
  MarksDistribution({this.easy, this.hard, this.medium});

  MarksDistribution.fromJson(Map<String, dynamic> json) {
    easy = (json['easy'] as List).cast<num>();
    hard = (json['hard'] as List).cast<num>();
    medium = (json['medium'] as List).cast<num>();
  }
  List<num>? easy;
  List<num>? hard;
  List<num>? medium;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['easy'] = easy;
    data['hard'] = hard;
    data['medium'] = medium;
    return data;
  }
}

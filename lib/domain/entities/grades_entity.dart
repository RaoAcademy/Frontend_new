class Grades {
  Grades({this.grade, this.id});

  Grades.fromJson(Map<String, dynamic> json) {
    grade = json['grade'] as num?;
    id = json['id'] as num?;
  }
  num? grade;
  num? id;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grade'] = grade;
    data['id'] = id;
    return data;
  }
}

class SchoolExistEntity {
  SchoolExistEntity({this.school, this.schoolId});

  SchoolExistEntity.fromJson(Map<String, dynamic> json) {
    school = json['school'] as String?;
    schoolId = json['schoolId'] as num?;
  }

  String? school;
  num? schoolId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['school'] = school;
    data['schoolId'] = schoolId;
    return data;
  }
}

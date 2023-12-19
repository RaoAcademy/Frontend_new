class Schools {
  Schools({this.id, this.school});

  Schools.fromJson(Map<String, dynamic> json) {
    id = json['id'] as num?;
    school = json['school'] as String?;
  }

  num? id;
  String? school;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['school'] = school;
    return data;
  }
}

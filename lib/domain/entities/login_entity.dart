class LoginEntity {
  LoginEntity({this.newUser, this.userId});

  LoginEntity.fromJson(Map<String, dynamic> json) {
    newUser = json['newUser'] as bool?;
    userId = json['userId'] as num?;
    token = json['token'] as String?;
  }
  bool? newUser;
  num? userId;
  String? token;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newUser'] = newUser;
    data['userId'] = userId;
    data['token'] = userId;
    return data;
  }
}

class Profile {
  Profile(
      {this.avatarImagePath,
      this.badge,
      this.coins,
      this.defaultSubjectId,
      this.grade,
      this.name});

  Profile.fromJson(Map<String, dynamic> json) {
    avatarImagePath = json['avatarImagePath']?.toString();
    badge = json['badge']?.toString();
    coins = int.parse(json['coins']?.toString() ?? '0');
    defaultSubjectId = int.parse(json['defaultSubjectId']?.toString() ?? '0');
    grade = int.parse(json['grade']?.toString() ?? '0');
    name = json['name']?.toString();
  }
  String? avatarImagePath;
  String? badge;
  num? coins;
  num? defaultSubjectId;
  num? grade;
  String? name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatarImagePath'] = avatarImagePath;
    data['badge'] = badge;
    data['coins'] = coins;
    data['defaultSubjectId'] = defaultSubjectId;
    data['grade'] = grade;
    data['name'] = name;
    return data;
  }
}

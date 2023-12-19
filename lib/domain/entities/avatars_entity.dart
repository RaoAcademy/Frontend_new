class AvatarsEntity {
  AvatarsEntity({this.avatars, this.updated});

  AvatarsEntity.fromJson(Map<String, dynamic> json) {
    if (json['avatars'] != null) {
      avatars = <Avatars>[];
      (json['avatars'] as List).forEach((v) {
        avatars!.add(Avatars.fromJson(v as Map<String, dynamic>));
      });
    }
    updated = json['updated'] as bool?;
  }
  List<Avatars>? avatars;
  bool? updated;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (avatars != null) {
      data['avatars'] = avatars!.map((v) => v.toJson()).toList();
    }
    data['updated'] = updated;
    return data;
  }
}

class Avatars {
  Avatars({this.id, this.imagePath});

  Avatars.fromJson(Map<String, dynamic> json) {
    id = json['id'] as num?;
    imagePath = json['imagePath'] as String?;
  }
  num? id;
  String? imagePath;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['imagePath'] = imagePath;
    return data;
  }
}

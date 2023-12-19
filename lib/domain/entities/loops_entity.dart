class LoopsEntity {
  LoopsEntity({this.chapterId, this.id, this.imagePath, this.name});

  LoopsEntity.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapterId'] as num?;
    id = json['id'] as num?;
    imagePath = json['imagePath'] as String?;
    name = json['name'] as String?;
  }
  num? chapterId;
  num? id;
  String? imagePath;
  String? name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapterId'] = chapterId;
    data['id'] = id;
    data['imagePath'] = imagePath;
    data['name'] = name;
    return data;
  }
}

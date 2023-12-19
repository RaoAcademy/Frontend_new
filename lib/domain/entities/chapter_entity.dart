class TestChapters {
  TestChapters({
    this.subectName,
    this.chapter,
  });

  factory TestChapters.fromMap(Map<String, dynamic> map) {
    return TestChapters(
      subectName: map['subjectName'] as String?,
      chapter: map['chapter'] != null
          ? List<ChapterEntity>.from((map['chapter'] as List<dynamic>)
              .map((x) => ChapterEntity.fromJson(x as Map<String, dynamic>)))
          : null,
    );
  }
  String? subectName;
  List<ChapterEntity>? chapter;
}

class ChapterEntity {
  ChapterEntity({this.caption, this.id, this.imagePath, this.name});

  ChapterEntity.fromJson(Map<String, dynamic> json) {
    caption = json['caption'] as String?;
    id = json['id'] as num?;
    imagePath = json['imagePath'] as String?;
    name = json['name'] as String?;
  }
  String? caption;
  num? id;
  String? imagePath;
  String? name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caption'] = caption;
    data['id'] = id;
    data['imagePath'] = imagePath;
    data['name'] = name;
    return data;
  }
}

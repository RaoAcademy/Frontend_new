import 'package:EdTestz/domain/entities/recommendations_entity.dart';

class TestChapterConcept {
  TestChapterConcept(
      {this.description, this.imagePath, this.name, this.tags, this.test});

  TestChapterConcept.fromJson(Map<String, dynamic> json) {
    description = json['description'] as String?;
    imagePath = json['imagePath'] as String?;
    name = json['name'] as String?;
    tags = (json['tags'] as List).cast<String>();
    if (json['test'] != null) {
      test = <TestEntity>[];
      (json['test'] as List).forEach((v) {
        test!.add(TestEntity.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  String? description;
  String? imagePath;
  String? name;
  List<String>? tags;
  List<TestEntity>? test;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['imagePath'] = imagePath;
    data['name'] = name;
    data['tags'] = tags;
    if (test != null) {
      data['test'] = test!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

import 'package:rao_academy/domain/entities/recommendations_entity.dart';
import 'package:rao_academy/domain/entities/subjects_entity.dart';

class TestHomeEntity {
  TestHomeEntity(
      {this.recent, this.recommendations, this.subjects, this.testCategories});

  TestHomeEntity.fromJson(Map<String, dynamic> json) {
    if (json['recent'] != null) {
      recent = <TestEntity>[];
      (json['recent'] as List).forEach((v) {
        recent!.add(TestEntity.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['recommendations'] != null) {
      recommendations = <TestEntity>[];

      (json['recommendations'] as List).forEach((v) {
        recommendations!.add(TestEntity.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      (json['subjects'] as List).forEach((v) {
        subjects!.add(Subjects.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['testCategories'] != null) {
      testCategories = <TestCategories>[];
      (json['testCategories'] as List).forEach((v) {
        testCategories!.add(TestCategories.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  List<TestEntity>? recent;
  List<TestEntity>? recommendations;
  List<Subjects>? subjects;
  List<TestCategories>? testCategories;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recent != null) {
      // data['recent'] = this.recent!.map((v) => v.toJson()).toList();
    }
    if (recommendations != null) {
      data['recommendations'] =
          recommendations!.map((v) => v.toJson()).toList();
    }
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    if (testCategories != null) {
      data['testCategories'] = testCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestCategories {
  TestCategories({this.caption, this.id, this.imagePath, this.name});

  TestCategories.fromJson(Map<String, dynamic> json) {
    caption = json['caption'] as String?;
    id = json['id'] as num?;
    imagePath = json['imagePath'] as String?;
    name = json['name'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caption'] = caption;
    data['id'] = id;
    data['imagePath'] = imagePath;
    data['name'] = name;
    return data;
  }

  String? caption;
  num? id;
  String? imagePath;
  String? name;
}

import 'package:EdTestz/domain/entities/boards_entity.dart';
import 'package:EdTestz/domain/entities/grades_entity.dart';

class SignUpEntity {
  SignUpEntity({this.added, this.boards, this.grades});

  SignUpEntity.fromJson(Map<String, dynamic> json) {
    added = json['Added'] as bool?;
    if (json['boards'] != null) {
      boards = <Boards>[];
      (json['boards'] as List).forEach((v) {
        boards!.add(Boards.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['grades'] != null) {
      grades = <Grades>[];
      (json['grades'] as List).forEach((v) {
        grades!.add(Grades.fromJson(v as Map<String, dynamic>));
      });
    }
    // if (json['schools'] != null) {
    //   schools = <Schools>[];
    //   (json['schools'] as List).forEach((v) {
    //     schools!.add(Schools.fromJson(v as Map<String, dynamic>));
    //   });
    // }
  }

  bool? added;
  List<Boards>? boards;
  List<Grades>? grades;
  // List<Schools>? schools;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Added'] = added;
    if (boards != null) {
      data['boards'] = boards!.map((v) => v.toJson()).toList();
    }
    if (grades != null) {
      data['grades'] = grades!.map((v) => v.toJson()).toList();
    }
    // if (schools != null) {
    //   data['schools'] = schools!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

import 'package:rao_academy/domain/entities/boards_entity.dart';
import 'package:rao_academy/domain/entities/grades_entity.dart';
import 'package:rao_academy/domain/entities/schools_entity.dart';

class ProfileUpdateEntity {
  ProfileUpdateEntity(
      {this.grade,
      this.parentMobile,
      this.parentName,
      this.previousClassPercentageGPA,
      this.board,
      this.boards,
      this.city,
      this.dob,
      this.email,
      this.firstname,
      this.gender,
      this.grades,
      this.lastname,
      this.mobile,
      this.school,
      this.schools,
      this.updated});

  ProfileUpdateEntity.fromJson(Map<String, dynamic> json) {
    grade = json['Grade'] as num?;
    parentMobile = json['Parent Mobile'] as String?;
    parentName = json['Parent Name'] as String?;
    previousClassPercentageGPA = json['Previous Class Percentage/GPA'] as num?;
    board = json['board'] as int?;
    if (json['boards'] != null) {
      boards = <Boards>[];
      (json['boards'] as List).forEach((v) {
        boards!.add(Boards.fromJson(v as Map<String, dynamic>));
      });
    }
    city = json['city'] as String?;
    dob = json['dob'] as String?;
    email = json['email'] as String?;
    firstname = json['firstname'] as String?;
    gender = json['gender'] as String?;
    if (json['grades'] != null) {
      grades = <Grades>[];
      (json['grades'] as List).forEach((v) {
        grades!.add(Grades.fromJson(v as Map<String, dynamic>));
      });
    }
    lastname = json['lastname'] as String?;
    mobile = json['mobile'] as String?;
    school = json['school'] as String?;
    if (json['schools'] != null) {
      schools = <Schools>[];
      (json['schools'] as List).forEach((v) {
        schools!.add(Schools.fromJson(v as Map<String, dynamic>));
      });
    }
    updated = json['updated'] as bool?;
  }

  num? grade;
  num? userId;
  String? parentMobile;
  String? parentName;
  num? previousClassPercentageGPA;
  int? board;
  List<Boards>? boards;
  String? city;
  String? dob;
  String? email;
  String? firstname;
  String? gender;
  List<Grades>? grades;
  String? lastname;
  String? mobile;
  String? school;
  int? school_id;
  List<Schools>? schools;
  bool? updated;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['grade'] = grade;
    data['parentMobile'] = parentMobile ?? "";
    data['parentName'] = parentName ?? "";
    data['lastYearResults'] = previousClassPercentageGPA;
    data['board'] = board;
    if (boards != null) {
      data['boards'] = boards!.map((v) => v.toJson()).toList();
    }
    data['city'] = city ?? '';
    data['dob'] = dob;
    data['email'] = email ?? "";
    data['firstname'] = firstname;
    data['gender'] = gender;
    if (grades != null) {
      data['grades'] = grades!.map((v) => v.toJson()).toList();
    }
    data['lastname'] = lastname;
    data['mobile'] = mobile;
    data['school'] = school;
    if (schools != null) {
      data['schools'] = schools!.map((v) => v.toJson()).toList();
    }
    data['update'] = updated;
    return data;
  }
}

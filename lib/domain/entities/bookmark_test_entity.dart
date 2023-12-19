import 'package:rao_academy/domain/entities/subject_list_entity.dart';

class BookmarkTestEntity {
  BookmarkTestEntity({this.subjects, this.userTests});

  BookmarkTestEntity.fromJson(Map<String, dynamic> json) {
    if (json['subjects'] != null) {
      subjects = <SubjectList>[];
      (json['subjects'] as List).forEach((v) {
        subjects!.add(SubjectList.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['userTests'] != null) {
      userTests = <UserTests>[];
      (json['userTests'] as List).forEach((v) {
        userTests!.add(UserTests.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  List<SubjectList>? subjects;
  List<UserTests>? userTests;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    if (userTests != null) {
      data['userTests'] = userTests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserTests {
  String? leftTop;
  Null? rightTop;
  String? text1;
  String? text2;
  String? text3;
  int? userTestId;
  String? imagePath;
  int? coins;

  UserTests(
      {this.leftTop,
      this.rightTop,
      this.text1,
      this.text2,
      this.text3,
      this.userTestId,
      this.imagePath,
      this.coins});

  UserTests copyWith({
    String? leftTop,
    Null? rightTop,
    String? text1,
    String? text2,
    String? text3,
    int? userTestId,
    String? imagePath,
    int? coins,
  }) {
    return UserTests(
        leftTop: leftTop ?? this.leftTop,
        rightTop: rightTop ?? this.rightTop,
        text1: text1 ?? this.text1,
        text2: text2 ?? this.text2,
        text3: text3 ?? this.text3,
        userTestId: userTestId ?? this.userTestId,
        imagePath: this.imagePath,
        coins: this.coins);
  }

  Map<String, dynamic> toJson() {
    return {
      'leftTop': leftTop,
      'rightTop': rightTop,
      'text1': text1,
      'text2': text2,
      'text3': text3,
      'userTestId': userTestId,
      'imagePath': imagePath,
      'coins': coins
    };
  }

  factory UserTests.fromJson(Map<String, dynamic> json) {
    return UserTests(
        leftTop: json['leftTop'] as String?,
        rightTop: json['rightTop'] as Null?,
        text1: json['text1'] as String?,
        text2: json['text2'] as String?,
        text3: json['text3'] as String?,
        userTestId: json['userTestId'] as int?,
        imagePath: json['imagePath'] as String?,
        coins: json['coins'] as int?);
  }
}

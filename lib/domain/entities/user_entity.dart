import 'dart:convert';

class UserEntity {
  UserEntity({
    this.firstname,
    this.lastname,
    this.gender,
    this.dob,
    this.board,
    this.grade,
    this.school,
    this.mobile,
    this.peerReferral,
    this.update,
  });
  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      firstname: map['firstname'] as String?,
      lastname: map['lastname'] as String?,
      gender: map['gender'] as String?,
      dob: map['dob'] as String?,
      board: map['board'] as num?,
      grade: map['grade'] as num?,
      school: map['school'] as num?,
      mobile: map['mobile'] as String?,
      peerReferral: map['peerReferral'] as String?,
      update: map['update'] as bool?,
    );
  }
  String? firstname;
  String? lastname;
  String? gender;
  String? dob;
  num? board;
  num? grade;
  num? school;
  String? mobile;
  String? peerReferral;
  bool? update;
  UserEntity copyWith({
    String? firstname,
    String? lastname,
    String? gender,
    String? dob,
    num? board,
    num? grade,
    num? school,
    String? mobile,
    String? peerReferral,
    bool? update,
  }) {
    return UserEntity(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      board: board ?? this.board,
      grade: grade ?? this.grade,
      school: school ?? this.school,
      mobile: mobile ?? this.mobile,
      peerReferral: peerReferral ?? this.peerReferral,
      update: update ?? this.update,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'gender': gender,
      'dob': dob,
      'board': board,
      'grade': grade,
      'school': school,
      'mobile': mobile,
      'peerReferral': peerReferral,
      'update': update,
    };
  }

  String toJson() => json.encode(toMap());
}

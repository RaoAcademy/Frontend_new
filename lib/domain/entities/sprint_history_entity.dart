import 'package:EdTestz/domain/entities/sprint_entity.dart';

class SprintHistoryEntity {
  SprintHistoryEntity({this.loopAchieved, this.loopTarget, this.sprint});

  SprintHistoryEntity.fromJson(Map<String, dynamic> json) {
    loopAchieved = json['loopAchieved'] as num?;
    nextSprintUserTestId = json['nextSprintUserTestId'] as num?;
    chapterName = json['chapter name'] as String?;
    loopTarget = json['loopTarget'] as num?;
    if (json['sprint'] != null) {
      sprint = <Sprint>[];
      (json['sprint'] as List).forEach((v) {
        sprint!.add(Sprint.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  String? chapterName;
  num? loopAchieved;
  num? nextSprintUserTestId;
  num? loopTarget;
  List<Sprint>? sprint;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapter name'] = chapterName;
    data['loopAchieved'] = loopAchieved;
    data['nextSprintUserTestId'] = nextSprintUserTestId;

    data['loopTarget'] = loopTarget;
    if (sprint != null) {
      data['sprint'] = sprint!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

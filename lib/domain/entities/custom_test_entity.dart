class CustomTestEntity {
  CustomTestEntity(
      {this.chapterIds,
      this.conceptIds,
      this.count,
      this.customName,
      this.format,
      this.level,
      this.questionIds,
      this.subjectId});

  CustomTestEntity.fromJson(Map<String, dynamic> json) {
    hideLevelAndFormat = json['hideLevelAndFormat'] as bool?;
    dissapperingMsg = json['dissapperingMsg'] as String?;
    chapterIds = json['chapterIds'] as String?;
    suggestedFormat = json['suggestedFormat'] as String?;
    conceptIds = json['conceptIds'] as String?;
    count = json['count'] as num?;
    customName = json['customName'] as String?;
    format = json['format'] as String?;
    level = json['level'] as String?;
    questionIds = json['questionIds'] as String?;
    subjectId = json['subjectId'] as String?;
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      (json['chapters'] as List).forEach((v) {
        chapters!.add(Chapters.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['concepts'] != null) {
      concepts = <Chapters>[];
      (json['concepts'] as List).forEach((v) {
        concepts!.add(Chapters.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['levels'] != null) {
      levels = <Levels>[];
      (json['levels'] as List).forEach((v) {
        levels!.add(Levels.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['formats'] != null) {
      formats = <Formats>[];
      (json['formats'] as List).forEach((v) {
        formats!.add(Formats.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  bool? hideLevelAndFormat;
  String? chapterIds;
  List<Chapters>? chapters;
  String? conceptIds;
  List<Chapters>? concepts;
  num? count;
  String? customName;
  String? dissapperingMsg;
  String? format;
  List<Formats>? formats;
  String? level;
  List<Levels>? levels;
  String? questionIds;
  String? subjectId;
  String? suggestedFormat;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapterIds'] = chapterIds;
    data['conceptIds'] = conceptIds;
    data['count'] = count;
    data['customName'] = customName;
    data['format'] = format;
    data['level'] = level;
    data['questionIds'] = questionIds;
    data['subjectId'] = subjectId;
    return data;
  }
}

class Chapters {
  Chapters({this.id, this.name});

  Chapters.fromJson(Map<String, dynamic> json) {
    id = json['id'] as num?;
    name = json['name'] as String?;
  }
  num? id;
  String? name;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Formats {
  Formats({this.format, this.id});

  Formats.fromJson(Map<String, dynamic> json) {
    format = json['format'] as String?;
    id = json['id'] as num?;
  }

  String? format;
  num? id;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['format'] = format;
    data['id'] = id;
    return data;
  }
}

class Levels {
  Levels({this.id, this.level});

  Levels.fromJson(Map<String, dynamic> json) {
    id = json['id'] as num?;
    level = json['level'] as String?;
  }
  num? id;
  String? level;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['level'] = level;
    return data;
  }
}

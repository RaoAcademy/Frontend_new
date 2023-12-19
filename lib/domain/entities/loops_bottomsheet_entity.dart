class LoopsBottomSheetEntity {
  LoopsBottomSheetEntity({
    this.achieved,
    this.description,
    this.id,
    this.imagePath,
    this.name,
    this.preparedBy,
    this.results,
    this.resume,
    this.retake,
    this.start,
    this.tags,
    this.target,
    this.userTestId,
  });

  LoopsBottomSheetEntity.fromJson(Map<String, dynamic> json) {
    achieved = json['achieved'] as num?;
    description = json['description'] as String?;
    id = json['id'] as num?;
    imagePath = json['imagePath'] as String?;
    name = json['name'] as String?;
    preparedBy = json['preparedBy'] as String?;
    results = json['results'] as bool?;
    resume = json['resume'] as bool?;
    retake = json['retake'] as bool?;
    start = json['start'] as bool?;
    tags = json['tags'] as String?;
    target = json['target'] as num?;
    userTestId = json['userTestId'] as num?;
  }

  num? achieved;
  String? description;
  num? id;
  num? userTestId;
  String? imagePath;
  String? name;
  String? preparedBy;
  bool? results;
  bool? resume;
  bool? retake;
  bool? start;
  String? tags;
  num? target;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['achieved'] = achieved;
    data['description'] = description;
    data['id'] = id;
    data['userTestId'] = userTestId;
    data['imagePath'] = imagePath;
    data['name'] = name;
    data['preparedBy'] = preparedBy;
    data['results'] = results;
    data['resume'] = resume;
    data['retake'] = retake;
    data['start'] = start;
    data['tags'] = tags;
    data['target'] = target;
    return data;
  }
}

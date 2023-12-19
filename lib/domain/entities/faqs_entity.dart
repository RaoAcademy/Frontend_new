class FAQsEntity {
  FAQsEntity({this.answer, this.imagePath, this.question, this.type});

  FAQsEntity.fromJson(Map<String, dynamic> json) {
    answer = json['answer'] as String?;
    imagePath = json['imagePath'] as String?;
    question = json['question'] as String?;
    type = json['type'] as String?;
  }

  String? answer;
  String? imagePath;
  String? question;
  String? type;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer'] = answer;
    data['imagePath'] = imagePath;
    data['question'] = question;
    data['type'] = type;
    return data;
  }
}

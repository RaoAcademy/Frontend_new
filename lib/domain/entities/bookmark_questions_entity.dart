import 'package:EdTestz/domain/entities/subject_list_entity.dart';

class BookmarkQuestionsEntity {
  BookmarkQuestionsEntity({this.questions, this.subjects});

  BookmarkQuestionsEntity.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <QuestionsBookmark>[];
      (json['questions'] as List).forEach((v) {
        questions!.add(QuestionsBookmark.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['subjects'] != null) {
      subjects = <SubjectList>[];
      (json['subjects'] as List).forEach((v) {
        subjects!.add(SubjectList.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  List<QuestionsBookmark>? questions;
  List<SubjectList>? subjects;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionsBookmark {
  String? conceptName;
  String? format;
  String? question;
  int? questionId;

  QuestionsBookmark({
    this.conceptName,
    this.format,
    this.question,
    this.questionId,
  });

  QuestionsBookmark copyWith({
    String? conceptName,
    String? format,
    String? question,
    int? questionId,
  }) {
    return QuestionsBookmark(
      conceptName: conceptName ?? this.conceptName,
      format: format ?? this.format,
      question: question ?? this.question,
      questionId: questionId ?? this.questionId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conceptName': conceptName,
      'format': format,
      'question': question,
      'questionId': questionId,
    };
  }

  factory QuestionsBookmark.fromJson(Map<String, dynamic> json) {
    return QuestionsBookmark(
      conceptName: json['conceptName'] as String?,
      format: json['format'] as String?,
      question: json['question'] as String?,
      questionId: json['questionId'] as int?,
    );
  }
}

class TestSummaryEntity {
  TestSummaryEntity(
      {this.answered,
      this.answeredAndMarkedForReview,
      this.markedForReview,
      this.notAnswered,
      this.notVisited,
      this.totalQuestions});

  TestSummaryEntity.fromJson(Map<String, dynamic> json) {
    answered = json['answered'] as num?;
    answeredAndMarkedForReview = json['answeredAndMarkedForReview'] as num?;
    markedForReview = json['markedForReview'] as num?;
    notAnswered = json['notAnswered'] as num?;
    notVisited = json['notVisited'] as num?;
    totalQuestions = json['totalQuestions'] as num?;
  }
  num? answered;
  num? answeredAndMarkedForReview;
  num? markedForReview;
  num? notAnswered;
  num? notVisited;
  num? totalQuestions;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answered'] = answered;
    data['answeredAndMarkedForReview'] = answeredAndMarkedForReview;
    data['markedForReview'] = markedForReview;
    data['notAnswered'] = notAnswered;
    data['notVisited'] = notVisited;
    data['totalQuestions'] = totalQuestions;
    return data;
  }
}

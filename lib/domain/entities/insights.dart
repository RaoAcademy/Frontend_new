class Insights {
  Insights({this.badBehaviour, this.goodBehaviour});

  Insights.fromJson(Map<String, dynamic> json) {
    badBehaviour = (json['bad behaviour'] as List).cast<String>();
    goodBehaviour = (json['good behaviour'] as List).cast<String>();
  }
  List<String>? badBehaviour;
  List<String>? goodBehaviour;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bad behaviour'] = badBehaviour;
    data['good behaviour'] = goodBehaviour;
    return data;
  }
}

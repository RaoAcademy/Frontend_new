class ActivePlans {
  ActivePlans(
      {this.expiryDate,
      this.numberOfTests,
      this.subsName,
      this.testsRemaining});

  ActivePlans.fromJson(Map<String, dynamic> json) {
    expiryDate = json['expiryDate'] as String?;
    numberOfTests = json['numberOfTests'] as num?;
    subsName = json['subsName'] as String?;
    testsRemaining = json['testsRemaining'] as num?;
  }
  String? expiryDate;
  num? numberOfTests;
  String? subsName;
  num? testsRemaining;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expiryDate'] = expiryDate;
    data['numberOfTests'] = numberOfTests;
    data['subsName'] = subsName;
    data['testsRemaining'] = testsRemaining;
    return data;
  }
}

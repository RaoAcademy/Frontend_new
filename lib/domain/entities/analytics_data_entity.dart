class AnalyticData {
  AnalyticData(this.day, this.tests);

  factory AnalyticData.fromMap(Map<String, dynamic> map) {
    return AnalyticData(
      map['day'] as String,
      map['tests'] as double,
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'tests': tests,
    };
  }

  final String day;
  final double tests;
}

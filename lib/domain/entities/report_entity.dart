import 'package:rao_academy/domain/entities/performance_entity.dart';
import 'package:rao_academy/domain/entities/progress_entity.dart';

class Report {
  Report(
      {this.activity,
      this.noOfPracticeTests,
      this.noOfTests,
      this.performance,
      this.progress,
      this.time});

  Report.fromJson(Map<String, dynamic> json) {
    activity = json['Activity'] != null
        ? Performance.fromJson(json['Activity'] as Map<String, dynamic>)
        : null;
    noOfPracticeTests = json['NoOfPracticeTests'] as num?;
    noOfTests = json['NoOfTests'] as num?;
    performance = json['Performance'] != null
        ? Performance.fromJson(json['Performance'] as Map<String, dynamic>)
        : null;
    progress = json['Progress'] != null
        ? Progress.fromJson(json['Progress'] as Map<String, dynamic>)
        : null;
    time = json['time'] as num?;
  }

  Performance? activity;
  num? noOfPracticeTests;
  num? noOfTests;
  Performance? performance;
  Progress? progress;
  num? time;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (activity != null) {
      data['Activity'] = activity!.toJson();
    }
    data['NoOfPracticeTests'] = noOfPracticeTests;
    data['NoOfTests'] = noOfTests;
    if (performance != null) {
      data['Performance'] = performance!.toJson();
    }
    if (progress != null) {
      data['Progress'] = progress!.toJson();
    }
    data['time'] = time;
    return data;
  }
}

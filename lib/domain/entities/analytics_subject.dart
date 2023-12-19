import 'package:rao_academy/domain/entities/date_filter_entity.dart';
import 'package:rao_academy/domain/entities/subjects_entity.dart';
import 'package:rao_academy/domain/entities/values.dart';

class AnalyticsSubject {
  AnalyticsSubject({this.dateFilter, this.subjects, this.values});

  AnalyticsSubject.fromJson(Map<String, dynamic> json) {
    dateFilter = json['dateFilter'] != null
        ? DateFilter.fromJson(json['dateFilter'] as Map<String, dynamic>)
        : null;
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      (json['subjects'] as List).forEach((v) {
        subjects!.add(Subjects.fromJson(v as Map<String, dynamic>));
      });
    }
    values = json['values'] != null
        ? Values.fromJson(json['values'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dateFilter != null) {
      data['dateFilter'] = dateFilter!.toJson();
    }
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    if (values != null) {
      data['values'] = values!.toJson();
    }
    return data;
  }

  DateFilter? dateFilter;
  List<Subjects>? subjects;
  Values? values;
}

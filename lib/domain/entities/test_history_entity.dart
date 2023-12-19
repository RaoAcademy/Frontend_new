import 'package:flutter/foundation.dart';
import 'package:rao_academy/domain/entities/monthwise_test.dart';
import 'package:rao_academy/domain/entities/subjects_entity.dart';

class TestHistoryEntity {
  TestHistoryEntity({this.subjects, required this.test});

  TestHistoryEntity.fromJson(Map<String, dynamic> json) {
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      (json['subjects'] as List).forEach((v) {
        subjects!.add(Subjects.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['filter1'] != null) {
      filter1 = <String>[];
      (json['filter1'] as List).forEach((v) {
        filter1!.add(v.toString());
      });
    }
    if (kDebugMode) {
      print("FILTER_TEST");
      print(filter1);
    }

    if (json['test'] != null) {
      // test = MonthWiseTests.fromJson(json['test'][0] as Map<String, dynamic>);
      test = List<MonthWiseTests>.from(
        (json['test'] as List<dynamic>).map(
          (x) => MonthWiseTests.fromJson(x as Map<String, dynamic>),
        ),
      );
      // final testsJson = json['test'] as List<dynamic>;
      // final month = testsJson.first['month'] as String;
      // final tests = testsJson
      //     .map((testJson) => Test.fromJson(testJson as Map<String, dynamic>))
      //     .toList();
      // test = MonthWiseTests(month: month, tests: tests);
      if (kDebugMode) {
        print("CHECK222");
        //   print(test?.tests?.first.date);
      }
      // test = MonthWiseTests.fromJson(json['test'] as Map<String, dynamic>);
      // test = <MonthWiseTests>[] as MonthWiseTests?;
      // (json['test'] as List).forEach((v) {
      //   // test!.add(MonthWiseTests.fromJson(v as Map<String, dynamic>));
      //   final testsJson = json['test'] as List<dynamic>;
      //   final month = testsJson.first['month'] as String;
      //   final tests = <Test>[];
      //   for (final testJson in testsJson) {
      //     final test = Test.fromJson(testJson as Map<String, dynamic>);
      //     tests.add(test);
      //   }
      //   test = MonthWiseTests(month: month, tests: tests);
      //   if (kDebugMode) {
      //     print("CHECK222");
      //     print(test?.tests?.first.date);
      //   }
      // });

      // //

      // // if (kDebugMode) {
      // //   print("KEY_DEBUG");
      // //   print(testsJson[0]);
      // // }
      // test = MonthWiseTests(month: month, tests: tests);
    }
  }

  List<Subjects>? subjects;
  // MonthWiseTests? test;
  List<MonthWiseTests> test = [];
  List<String>? filter1;

  /*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    if (test != null) {
      data['test'] = test!((v) => v.toJson()).toList();
    }
    return data;
  } */
}

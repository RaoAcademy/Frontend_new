import 'package:flutter/foundation.dart';
import 'package:EdTestz/domain/entities/test_entity.dart';

class MonthWiseTests {
  MonthWiseTests({
    this.month,
    required this.tests,
  });

  factory MonthWiseTests.fromJson(Map<String, dynamic> map) {
    // String? month = map[map.keys.first];
    if (kDebugMode) {
      print("FUNC TEST");
      print(map.keys.first);

      print(map['tests']);
    }
    return MonthWiseTests(
      month: map[map.keys.first].toString(),
      tests: map['tests'] != null
          ? List<Test>.from(
              (map['tests'] as List<dynamic>).map<Test?>(
                (x) => Test.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
  String? month;
  List<Test>? tests;

  MonthWiseTests copyWith({
    String? month,
    List<Test>? tests,
  }) {
    return MonthWiseTests(
      month: month ?? this.month,
      tests: tests ?? this.tests,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'month': month,
      'tests': tests?.map((x) => x.toJson()).toList(),
    };
  }
}

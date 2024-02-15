import 'package:EdTestz/domain/entities/concept_list.dart';
import 'package:EdTestz/domain/entities/difficulty_level_list.dart';
import 'package:EdTestz/domain/entities/loop_test_list.dart';

class Values {
  Values(
      {this.accuracy,
      this.chapterList,
      this.chaptersStrong,
      this.chaptersWeak,
      this.conceptBased,
      this.conceptList,
      this.conceptsStrong,
      this.conceptsWeak,
      this.confidence,
      this.custom,
      this.customTestList,
      this.difficultyLevelList,
      this.difficultyLevelStrong,
      this.difficultyLevelWeak,
      this.dynamicTestList,
      this.id,
      this.loop,
      this.loopTestList,
      this.name,
      this.other,
      this.performance,
      this.questionFormatList,
      this.questionFormatStrong,
      this.questionFormatWeak,
      this.score,
      this.staticTestList,
      this.testCategoryList,
      this.testList,
      this.tests,
      this.testsStrong,
      this.testsWeak});

  Values.fromJson(Map<String, dynamic> json) {
    accuracy = json['accuracy'] as num?;
    if (json['chapterList'] != null) {
      chapterList = <ConceptList>[];
      (json['chapterList'] as List).forEach((v) {
        chapterList!.add(ConceptList.fromJson(v as Map<String, dynamic>));
      });
    }
    chaptersStrong = (json['chaptersStrong'] as List).cast<String>();
    chaptersWeak = (json['chaptersWeak'] as List).cast<String>();
    conceptBased = json['conceptBased'] as num?;
    if (json['conceptList'] != null) {
      conceptList = <ConceptList>[];
      (json['conceptList'] as List).forEach((v) {
        conceptList!.add(ConceptList.fromJson(v as Map<String, dynamic>));
      });
    }
    conceptsStrong = (json['conceptsStrong'] as List).cast<String>();
    conceptsWeak = (json['conceptsWeak'] as List).cast<String>();
    confidence = json['confidence'] as num?;
    custom = json['custom'] as num?;
    if (json['customTestList'] != null) {
      customTestList = <Null>[];
      /* (json['customTestList'] as List).forEach((v) {
        customTestList!.add(Null.fromJson(v as Map<String, dynamic>));
      }); */
    }
    if (json['difficultyLevelList'] != null) {
      difficultyLevelList = <DifficultyLevelList>[];
      (json['difficultyLevelList'] as List).forEach((v) {
        difficultyLevelList!
            .add(DifficultyLevelList.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['difficultyLevelStrong'] != null) {
      difficultyLevelStrong = <String>[];
      (json['difficultyLevelStrong'] as List).forEach((v) {
        difficultyLevelStrong!.add(v.toString());
      });
    }
    difficultyLevelWeak = (json['difficultyLevelWeak'] as List).cast<String>();
    if (json['dynamicTestList'] != null) {
      dynamicTestList = <Null>[];
      /* (json['dynamicTestList'] as List).forEach((v) {
        dynamicTestList!.add(Null.fromJson(v as Map<String, dynamic>));
      }); */
    }
    id = json['id'] as num?;
    loop = json['loop'] as num?;
    if (json['loopTestList'] != null) {
      loopTestList = <LoopTestList>[];
      (json['loopTestList'] as List).forEach((v) {
        loopTestList!.add(LoopTestList.fromJson(v as Map<String, dynamic>));
      });
    }
    name = json['name'] as String?;
    other = json['other'] as num?;
    performance = json['performance'].toString() as String?;
    if (json['questionFormatList'] != null) {
      questionFormatList = <DifficultyLevelList>[];
      (json['questionFormatList'] as List).forEach((v) {
        questionFormatList!
            .add(DifficultyLevelList.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['questionFormatStrong'] != null) {
      questionFormatStrong = <String>[];
      (json['questionFormatStrong'] as List).forEach((v) {
        questionFormatStrong!.add(v.toString());
      });
    }
    questionFormatWeak = (json['questionFormatWeak'] as List).cast<String>();
    score = json['score'] as num?;
    if (json['staticTestList'] != null) {
      staticTestList = <Null>[];
      /* (json['staticTestList'] as List).forEach((v) {
        staticTestList!.add(Null.fromJson(v as Map<String, dynamic>));
      }); */
    }
    if (json['testCategoryList'] != null) {
      testCategoryList = <ConceptList>[];
      (json['testCategoryList'] as List).forEach((v) {
        testCategoryList!.add(ConceptList.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['testList'] != null) {
      testList = <ConceptList>[];
      (json['testList'] as List).forEach((v) {
        testList!.add(ConceptList.fromJson(v as Map<String, dynamic>));
      });
    }
    tests = json['tests'] as num?;
    if (json['testsStrong'] != null) {
      testsStrong = <String>[];
      (json['testsStrong'] as List).forEach((v) {
        testsStrong!.add(v.toString());
      });
    }
    testsWeak = (json['testsWeak'] as List).cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accuracy'] = accuracy;
    if (chapterList != null) {
      data['chapterList'] = chapterList!.map((v) => v.toJson()).toList();
    }
    data['chaptersStrong'] = chaptersStrong;
    data['chaptersWeak'] = chaptersWeak;
    data['conceptBased'] = conceptBased;
    if (conceptList != null) {
      data['conceptList'] = conceptList!.map((v) => v.toJson()).toList();
    }
    data['conceptsStrong'] = conceptsStrong;
    data['conceptsWeak'] = conceptsWeak;
    data['confidence'] = confidence;
    data['custom'] = custom;
    if (customTestList != null) {
      /* data['customTestList'] =
          customTestList!.map((v) => v.toJson()).toList(); */
    }
    if (difficultyLevelList != null) {
      data['difficultyLevelList'] =
          difficultyLevelList!.map((v) => v.toJson()).toList();
    }
    if (difficultyLevelStrong != null) {
      /* data['difficultyLevelStrong'] =
          difficultyLevelStrong!.map((v) => v.toJson()).toList(); */
    }
    data['difficultyLevelWeak'] = difficultyLevelWeak;
    if (dynamicTestList != null) {
      /* data['dynamicTestList'] =
          dynamicTestList!.map((v) => v.toJson()).toList(); */
    }
    data['id'] = id;
    data['loop'] = loop;
    if (loopTestList != null) {
      data['loopTestList'] = loopTestList!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['other'] = other;
    data['performance'] = performance;
    if (questionFormatList != null) {
      data['questionFormatList'] =
          questionFormatList!.map((v) => v.toJson()).toList();
    }
    if (questionFormatStrong != null) {
      /* data['questionFormatStrong'] =
          questionFormatStrong!.map((v) => v.toJson()).toList(); */
    }
    data['questionFormatWeak'] = questionFormatWeak;
    data['score'] = score;
    if (staticTestList != null) {
      /* data['staticTestList'] =
          staticTestList!.map((v) => v.toJson()).toList(); */
    }
    if (testCategoryList != null) {
      data['testCategoryList'] =
          testCategoryList!.map((v) => v.toJson()).toList();
    }
    if (testList != null) {
      data['testList'] = testList!.map((v) => v.toJson()).toList();
    }
    data['tests'] = tests;
    if (testsStrong != null) {
      /* data['testsStrong'] = testsStrong!.map((v) => v.toJson()).toList(); */
    }
    data['testsWeak'] = testsWeak;
    return data;
  }

  num? accuracy;
  List<ConceptList>? chapterList;
  List<String>? chaptersStrong;
  List<String>? chaptersWeak;
  num? conceptBased;
  List<ConceptList>? conceptList;
  List<String>? conceptsStrong;
  List<String>? conceptsWeak;
  num? confidence;
  num? custom;
  List<void>? customTestList;
  List<DifficultyLevelList>? difficultyLevelList;
  List<String>? difficultyLevelStrong;
  List<String>? difficultyLevelWeak;
  List<void>? dynamicTestList;
  num? id;
  num? loop;
  List<LoopTestList>? loopTestList;
  String? name;
  num? other;
  String? performance;
  List<DifficultyLevelList>? questionFormatList;
  List<String>? questionFormatStrong;
  List<String>? questionFormatWeak;
  num? score;
  List<void>? staticTestList;
  List<ConceptList>? testCategoryList;
  List<ConceptList>? testList;
  num? tests;
  List<String>? testsStrong;
  List<String>? testsWeak;
}

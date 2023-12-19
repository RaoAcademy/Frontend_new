// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/core/utli/api_client.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/domain/entities/analytics_entity.dart';
import 'package:rao_academy/domain/entities/analytics_subject.dart';
import 'package:rao_academy/domain/entities/chapter_entity.dart';
import 'package:rao_academy/domain/entities/custom_test_entity.dart';
import 'package:rao_academy/domain/entities/loops_bottomsheet_entity.dart';
import 'package:rao_academy/domain/entities/loops_home_entity.dart';
import 'package:rao_academy/domain/entities/reports_entity.dart';
import 'package:rao_academy/domain/entities/sprint_history_entity.dart';
import 'package:rao_academy/domain/entities/test_chapter_concepts.dart';
import 'package:rao_academy/domain/entities/test_history_entity.dart';
import 'package:rao_academy/domain/entities/test_home_entity.dart';
import 'package:rao_academy/domain/entities/test_instructions_entity.dart';
import 'package:rao_academy/domain/entities/test_results_entity.dart';
import 'package:rao_academy/domain/entities/test_start_entity.dart';
import 'package:rao_academy/domain/entities/test_summary_entity.dart';
import 'package:rao_academy/domain/test_x/test_repo.dart';
import 'package:rao_academy/main.dart';

import '../../application/test/test_provider.dart';

@LazySingleton(as: TestRepo)
class ImpTestRepo extends TestRepo {
  ImpTestRepo();
  final APIClient _apiClient = APIClient();

  @override
  Future<TestStart> ftestStart({
    int? testID,
    int? loopTarget,
    int? userTestId,
    String? customName,
    int? subjectId,
    String? chapterIds,
    String? customConceptIds,
    String? customLevels,
    String? customFormats,
    String? questionIds,
    String? practiceId
  }) async {
    // String _chapterIds = '';
    // if (chapterIds != null) {
    //   chapterIds.forEach((element) {
    //     _chapterIds += element.toString();
    //     if (chapterIds.last != element) {
    //       _chapterIds += ',';
    //     }
    //   });
    // }
    //
    // String _conceptIds = '';
    // if (customConceptIds != null) {
    //   customConceptIds.forEach((element) {
    //     _conceptIds += element.toString();
    //     if (customConceptIds.last != element) {
    //       _conceptIds += ',';
    //     }
    //   });
    // }
    //
    // String _level = '';
    // if (customLevels != null) {
    //   customLevels.forEach((element) {
    //     _level += element.toString();
    //     if (customLevels.last != element) {
    //       _level += ',';
    //     }
    //   });
    // }
    //
    // String _format = '';
    // if (customFormats != null) {
    //   customFormats.forEach((element) {
    //     _format += element.toString();
    //     if (customFormats.last != element) {
    //       _format += ',';
    //     }
    //   });
    // }
    if(kDebugMode){
      print('------------------call ftestStart-----------------------------');
    }
    final result = await _apiClient.post(LoopsUrls.ftestStart, data: {
      'userId': await _apiClient.getUserId(),
      if (testID != null &&
          testID != 0 &&
          (userTestId == null || userTestId == 0))
        'testId': testID == 0 ? 1 : testID,
      if(practiceId != null) 'userTestId' : practiceId,
      if (practiceId == null && userTestId != null && userTestId != 0) 'userTestId': userTestId,
      if (loopTarget != null) 'loopTarget': loopTarget,
      if (customName != null) 'customName': customName,
      if (chapterIds != null && chapterIds.isNotEmpty)
        'chapterIds': chapterIds,
      if (customConceptIds != null && customConceptIds.isNotEmpty)
        'conceptIds': customConceptIds,
      if (customLevels != null && customLevels.isNotEmpty)
        'level': customLevels,
      if (customFormats != null && customFormats.isNotEmpty)
        'format': customFormats,
      if (subjectId != null) 'subjectId': subjectId,
      if (questionIds != null) 'questionIds': questionIds,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return TestStart.fromMap(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<TestChapters> ftestChapters(int subjectId) async {
    final result = await _apiClient.post(LoopsUrls.ftestChapters, data: {
      'userId': await _apiClient.getUserId(),
      'subjectId': subjectId,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return TestChapters.fromMap(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<TestSummaryEntity> ftestSummary(int userTestId) async {
    final result = await _apiClient
        .post(LoopsUrls.ftestSummary, data: {'userTestId': userTestId});
    if (result.statusCode == 200 || result.statusCode == 201) {
      return TestSummaryEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<CustomTestEntity> fcustomTest(
      {List<int>? chapterIds,
      List<int>? conceptIds,
      List<int>? level,
      List<int>? format,
      required num subjectId,
      num? testId}) async {
    String _chapterIds = '';
    if (chapterIds != null) {
      chapterIds.forEach((element) {
        _chapterIds += element.toString();
        if (chapterIds.last != element) {
          _chapterIds += ',';
        }
      });
    }

    String _conceptIds = '';
    if (conceptIds != null) {
      conceptIds.forEach((element) {
        _conceptIds += element.toString();
        if (conceptIds.last != element) {
          _conceptIds += ',';
        }
      });
    }

    String _level = '';
    if (level != null) {
      level.forEach((element) {
        _level += element.toString();
        if (level.last != element) {
          _level += ',';
        }
      });
    }

    String _format = '';
    if (format != null) {
      format.forEach((element) {
        _format += element.toString();
        if (format.last != element) {
          _format += ',';
        }
      });
    }
    final result = await _apiClient.post(LoopsUrls.fcustomTest, data: {
      'userId': await _apiClient.getUserId(),
      'subjectId': subjectId,
      if (chapterIds != null && chapterIds.isNotEmpty)
        'chapterIds': _chapterIds,
      if (conceptIds != null && conceptIds.isNotEmpty)
        'conceptIds': _conceptIds,
      if (level != null && level.isNotEmpty) 'level': _level,
      if (format != null && format.isNotEmpty) 'format': _format,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return CustomTestEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<TestChapterConcept> ftestChapterConcept(
      int subjectId, int chapterId) async {
    final result = await _apiClient.post(LoopsUrls.ftestChapterConcept, data: {
      'userId': await _apiClient.getUserId(),
      'subjectId': subjectId,
      'chapterId': chapterId,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return TestChapterConcept.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<AnalyticsEntity> fanalytics(String time) async {
    final result = await _apiClient.post(LoopsUrls.fanalytics, data: {
      'userId': await _apiClient.getUserId(),
      'time': time,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return AnalyticsEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<LoopsHomeEntity> floopsHome(int subjectId) async {
    final result = await _apiClient.post(LoopsUrls.floopsHome, data: {
      'userId': await _apiClient.getUserId(),
      'subjectId': subjectId,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return LoopsHomeEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<SprintHistoryEntity> fsprintHistory(int userTestId) async {
    final result = await _apiClient.post(LoopsUrls.fsprintHistory, data: {
      'userId': await _apiClient.getUserId(),
      'userTestId': userTestId,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return SprintHistoryEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<TestHistoryEntity> ftestHistory(String? startDate, String? endDate,
      String? subjectName, String? searchConceptName, String? filter1,) async {
    var uId = await _apiClient.getUserId();
    final result = await _apiClient.post(LoopsUrls.ftestHistory,
        data: {
      'userId': uId,
          // 'practice' : practice,
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
      // if (subjectName != null) 'subjectName': subjectName,
     'search': searchConceptName != null ?searchConceptName : '',
      // if (filter1 != null) 'filter1': filter1,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      if (kDebugMode) {
        print("RESULTS");
        print(result.data);
      }
      return TestHistoryEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<TestHomeEntity> ftestHome(int subjectId) async {
    final result = await _apiClient.post(LoopsUrls.ftestHome, data: {
      'userId': await _apiClient.getUserId(),
      'subjectId': subjectId,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return TestHomeEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<TestInstructionsEntity> ftestInstructions({
    int? testID,
    num? userTestId,
    String? customName,
    String? customConceptIds,
    String? customLevels,
    String? customFormats,
    String? questionsId,
    String? chaptersId,
    String? practiceId,
  }) async {
    // String _conceptIds = '';
    // if (customConceptIds != null) {
    //   customConceptIds.forEach((element) {
    //     _conceptIds += element.toString();
    //     if (customConceptIds.last != element) {
    //       _conceptIds += ',';
    //     }
    //   });
    // }
    //
    // String _level = '';
    // if (customLevels != null) {
    //   customLevels.forEach((element) {
    //     _level += element.toString();
    //     if (customLevels.last != element) {
    //       _level += ',';
    //     }
    //   });
    // }
    //
    // String _format = '';
    // if (customFormats != null) {
    //   customFormats.forEach((element) {
    //     _format += element.toString();
    //     if (customFormats.last != element) {
    //       _format += ',';
    //     }
    //   });
    // }
    final result = await _apiClient.post(LoopsUrls.ftestInstructions, data: {
      'userId': await _apiClient.getUserId(),
      // if (testID != null &&
      //     testID != 0 &&
      //     (userTestId == null || userTestId == 0) &&
      //     (customName == null))
        if (testID != 0) 'testId': testID == 0 ? 1 : testID,
       if(practiceId == null) if (userTestId != 0) 'userTestId': userTestId,
       if(practiceId != null)  'userTestId': practiceId,
      if (customName != null) 'customName': customName,
      /*  if (chapterIds != null && chapterIds.isNotEmpty)
        'chapterIds': _chapterIds, */
      if (customConceptIds != null && customConceptIds.isNotEmpty)
        'customConceptIds': customConceptIds,
      if (customLevels != null && customLevels.isNotEmpty)
        'customLevels': customLevels,
      if (customFormats != null && customFormats.isNotEmpty)
        'customFormats': customFormats,
      if (customFormats != null && customFormats.isNotEmpty)
        'questionsId': customFormats,
      if (customFormats != null && customFormats.isNotEmpty)
        'chapterIds': customFormats,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return TestInstructionsEntity.fromJson(
          result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<LoopsBottomSheetEntity> floopsBottomSheet(
      {required int testID}) async {
    final result = await _apiClient.post(LoopsUrls.floopsBottomSheet, data: {
      'userId': await _apiClient.getUserId(),
      'testId': testID == 0 ? 1 : testID,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return LoopsBottomSheetEntity.fromJson(
          result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }



  @override
  Future<void> fquestionBookmark(int questionId) async {
    var uId = await _apiClient.getUserId();
    final result = await _apiClient.post(LoopsUrls.fquestionBookmark, data: {
      'userId': uId,
      'questionId': questionId,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return;
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<Either<Unit, TestStart>> fquestionNext(
      int userTestId, int questionId, String response, int timetaken,
      {bool? review}) async {
    final result = await _apiClient.post(LoopsUrls.fquestionNext, data: {
      'userTestId': userTestId,
      'questionId': questionId,
       'response': response == '' ? null : response,
      'timetaken': timetaken,
      if (review != null && review) 'review': review,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      if (result.data != null || result.data != {}) {
        if(result.data['poorPerformanceMessage'] != null){
          Provider.of<TestProvider>(navigatorKey.currentContext!, listen: false).testStart.poorPerformanceMessage = result.data['poorPerformanceMessage'].toString();
          await Fluttertoast.showToast(msg: result.data['poorPerformanceMessage'].toString(),toastLength: Toast.LENGTH_LONG,
          textColor: Colors.black,backgroundColor: Colors.white,
          );

          //Provider.of<TestProvider>(navigatorKey.currentContext!, listen: false).testStart.poorPerformanceMessage = result.data['poorPerformanceMessage'].toString();

        }
        return right(TestStart.fromMap(result.data as Map<String, dynamic>));
      } else {
        return left(unit);
      }
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<void> ftestBookmark(int userTestId) async {
    final result = await _apiClient.post(LoopsUrls.ftestBookmark, data: {
      'userTestId': userTestId,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return;
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<void> ftestPaused(int userTestId, int questionIdNum) async {
    final result = await _apiClient.post(LoopsUrls.ftestPaused,
        data: {'userTestId': userTestId, 'resumeQuesId': questionIdNum});
    if (result.statusCode == 200 || result.statusCode == 201) {
      return;
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<TestResultsEntity> ftestResults(int userTestId) async {
    if (kDebugMode) {
      print("QUERY");
      print(userTestId);
    }
    final result = await _apiClient.post(LoopsUrls.ftestResults, data: {
      'userTestId': userTestId,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return TestResultsEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<void> ftestSubmit(int userTestId) async {
    final result = await _apiClient.post(LoopsUrls.ftestSubmit, data: {
      'userTestId': userTestId,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return;
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<AnalyticsSubject> fanalyticsSubject(int subjectId, String time) async {
    final result = await _apiClient.post(LoopsUrls.fanalyticsSubject, data: {
      'userId': await _apiClient.getUserId(),
      'subjectId': subjectId,
      'time': time,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return AnalyticsSubject.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }

  @override
  Future<ReportsEntity> freports(String time) async {
    final result = await _apiClient.post(LoopsUrls.freports, data: {
      'userId': await _apiClient.getUserId(),
      'time': time,
    });
    if (result.statusCode == 200 || result.statusCode == 201) {
      return ReportsEntity.fromJson(result.data as Map<String, dynamic>);
    } else {
      throw result.statusMessage!;
    }
  }
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:EdTestz/domain/entities/analytics_data_entity.dart';
import 'package:EdTestz/domain/entities/analytics_entity.dart';
import 'package:EdTestz/domain/entities/analytics_subject.dart';
import 'package:EdTestz/domain/entities/chapter_entity.dart';
import 'package:EdTestz/domain/entities/custom_test_entity.dart';
import 'package:EdTestz/domain/entities/loops_bottomsheet_entity.dart';
import 'package:EdTestz/domain/entities/loops_entity.dart';
import 'package:EdTestz/domain/entities/loops_home_entity.dart';
import 'package:EdTestz/domain/entities/recommendations_entity.dart';
import 'package:EdTestz/domain/entities/reports_entity.dart';
import 'package:EdTestz/domain/entities/sprint_history_entity.dart';
import 'package:EdTestz/domain/entities/subject_list_entity.dart';
import 'package:EdTestz/domain/entities/test_chapter_concepts.dart';
import 'package:EdTestz/domain/entities/test_history_entity.dart';
import 'package:EdTestz/domain/entities/test_home_entity.dart';
import 'package:EdTestz/domain/entities/test_instructions_entity.dart';
import 'package:EdTestz/domain/entities/test_results_entity.dart';
import 'package:EdTestz/domain/entities/test_start_entity.dart';
import 'package:EdTestz/domain/entities/test_summary_entity.dart';
import 'package:EdTestz/domain/test_x/test_repo.dart';

/* final StreamController<List<double>> _testwiseValueStream =
    StreamController<List<double>>.broadcast();
StreamSink<List<double>> testperformancesink = _testwiseValueStream.sink;
Stream<List<double>> testperformancestram = _testwiseValueStream.stream; */

@injectable
class TestProvider with ChangeNotifier {
  TestProvider(this.repo);

  final TestRepo repo;

  TestStart testStart = TestStart();
  TestChapters testChapters = TestChapters();
  TestSummaryEntity testSummaryEntity = TestSummaryEntity();
  CustomTestEntity customTestEntity = CustomTestEntity();
  TestEntity testEntity = TestEntity();
  TestChapterConcept testChapterConcept = TestChapterConcept();
  TestHomeEntity testHomeEntity = TestHomeEntity();
  TestInstructionsEntity testInstructionsEntity = TestInstructionsEntity();
  LoopsHomeEntity loopsHomeEntity = LoopsHomeEntity();
  SprintHistoryEntity sprintHistoryEntity = SprintHistoryEntity();
  TestHistoryEntity testHistoryEntity = TestHistoryEntity(test: []);
  AnalyticsEntity analyticsEntity = AnalyticsEntity();
  LoopsBottomSheetEntity loopsBottomSheetEntity = LoopsBottomSheetEntity();
  TestResultsEntity testResultsEntity = TestResultsEntity();
  AnalyticsSubject analyticsSubject = AnalyticsSubject();
  ReportsEntity reportsEntity = ReportsEntity();

  int subjectId = 0;
  int chapterId = 0;
  // int _userTestId = 0;
  int? loopTarget;
  bool? practice = false;
  bool showAnswer = false;
  bool refresh = false;
  Question question = Question();
  int index = 0;

/*   set userTestId(int number) {
    logger.wtf('Setting userItestID: $number');
    _userTestId = number;
  }

  int get userTestId => _userTestId; */

  int questionId = 0;
  String response = '';
  int timetaken = 0;
  bool? review = false;
  bool? fromCustomTest = false;
  int currentQuestionPageIndex = 0;
  int indexOfAcceptedItem = -1;
  bool bookmarked = false;

  final PageController _pageController = PageController(viewportFraction: 0.2);

  PageController get pageController => _pageController;

  final List<List<AnalyticData>> questionTypeAccuracy = [];

  final List<List<AnalyticData>> difficultyTypeAccuracy = [];

  resetAnswer() {
    refresh = true;
    notifyListeners();
  }

  // Map to store selected options for each question
  Map<int, int> selectedOptions = {};

  // Method to update selected option for a question
  void updateSelectedOption(int questionId, int selectedOption) {
    selectedOptions[questionId] = selectedOption;
    notifyListeners();
  }

  // Method to get selected option for a question
  int getSelectedOption(int questionId) {
    return selectedOptions[questionId] ?? -1;
  }

  List<String> subjectListx = [
    'Confidence',
    'Score',
    'Tests',
    'Performance',
    'Accuracy',
  ];
  List<String> subjectTestListx = [
    'Confidence',
    'Score',
    'Performance',
    'Accuracy',
  ];

  Map<String, dynamic> subjectMap = {
    'Confidence': 0,
    'Score': 0,
    'Tests': 0,
    'Performance': 0,
    'Accuracy': 0,
  };

  Map<String, dynamic> subjectMapAll = {
    'Confidence': 0,
    'Score': 0,
    'Tests': 0,
    'Performance': 0,
    'Accuracy': 0,
  };

  String selectedTime = 'This week';

  List<double> subjectwisePerformanceValues = [];

  List<String> subjectwisePerformanceKeys = [
    'Loops',
    'Individual Tests',
    'Custom Tests',
    'Other Tests',
  ];

  List<int> timeTake = List.filled(1000, 0);
  List<bool> bookmarkQuestion = List.filled(1000, false);
  List<int> selectedChoice = List.filled(1000, -1);
  List<String> filledAnswer = List.filled(1000, '');
  List<bool?> boolChoice = List.filled(1000, null);
  List<List<int>> selectedChoices = List.filled(1000, List.filled(1000, -1));

  Future<void> ftestStart(
      {TestEntity? testEntity,
      String? customName,
      String? chapterIds,
      String? conceptIds,
      String? customConceptIds,
      String? customLevels,
      String? customFormats,
      String? questionIds,
      String? practiceId}) async {
    if (testEntity != null) {
      this.testEntity = testEntity;
    }

    testStart = await repo.ftestStart(
        testID: testEntity?.testId?.toInt(),
        userTestId: testEntity?.userTestId?.toInt(),
        loopTarget: loopTarget,
        chapterIds: chapterIds,
        customConceptIds: customConceptIds,
        customFormats: customFormats,
        customLevels: customLevels,
        subjectId: subjectId,
        customName: customName,
        questionIds: questionIds,
        practiceId: practiceId);
    timeTake = List.filled(1000, 0);
    bookmarkQuestion = List.filled(1000, false);
    selectedChoice = List.filled(1000, -1);
    selectedChoices = List.filled(1000, List.filled(1000, -1));

    notifyListeners();
  }

  Future<void> ftestChapters() async {
    testChapters = await repo.ftestChapters(subjectId);
    notifyListeners();
  }

  Future<void> ftestSummary(int userTestId) async {
    testSummaryEntity = await repo.ftestSummary(userTestId);
    notifyListeners();
  }

  Future<void> fcustomTest(
      {List<int>? chapterIds,
      List<int>? conceptIds,
      List<int>? level,
      List<int>? format,
      num? testId}) async {
    customTestEntity = await repo.fcustomTest(
      subjectId: subjectId,
      level: level,
      format: format,
      chapterIds: chapterIds,
      conceptIds: conceptIds,
    );
    notifyListeners();
  }

  Future<void> ftestChapterConcept() async {
    testChapterConcept = await repo.ftestChapterConcept(subjectId, chapterId);
    notifyListeners();
  }

  Future<void> ftestHome() async {
    testHomeEntity = await repo.ftestHome(subjectId);
    notifyListeners();
  }

  Future<void> ftestInstructions({
    String? customName,
    String? customConceptIds,
    String? customLevels,
    String? customFormats,
    TestEntity? testEntity,
    String? questionsId,
    String? chaptersId,
    String? testType,
    String? practiceId,
  }) async {
    if (testEntity != null) {
      this.testEntity = testEntity;
    }
    testInstructionsEntity = await repo.ftestInstructions(
        userTestId: testEntity?.leftTop?.toUpperCase().trim() == 'PRACTICE' ||
                testType?.toUpperCase().trim() == "PRACTICE" ||
                testType == "Concept based" ||
                testType == "Custom Test"
            ? practiceId == null
                ? testEntity?.userTestId
                : int.parse(practiceId)
            : null,
        // testID:testType?.toUpperCase().trim() != "PRACTICE" ?  !(testEntity?.leftTop?.toUpperCase().trim() == 'PRACTICE')
        //     ? testEntity?.testId?.toInt()
        //     : null : null,
        testID: testEntity?.testId?.toInt() ?? null,
        customName: customName,
        customConceptIds: customConceptIds,
        customFormats: customFormats,
        customLevels: customLevels,
        chaptersId: chaptersId,
        questionsId: questionsId,
        practiceId: practiceId);
    notifyListeners();
  }

  Future<void> floopsHome() async {
    loopsHomeEntity = await repo.floopsHome(subjectId);
    notifyListeners();
  }

  Future<void> floopsBottomSheet(LoopsEntity loopsEntity) async {
    loopsBottomSheetEntity =
        await repo.floopsBottomSheet(testID: loopsEntity.id!.toInt());
    notifyListeners();
  }

  Future<void> fquestionBookmark(int questionId) async {
    await repo.fquestionBookmark(questionId);
    notifyListeners();
  }

  // Future<void> fquestionNext(int? userTestId) async {
  //   await repo
  //       .fquestionNext(
  //     userTestId!,
  //     questionId,
  //     response,
  //     timetaken,
  //     review: review,
  //   )
  //       .then((result) {
  //     result.fold((l) => null, (r) {
  //       r.question?.forEach((element) {
  //         testStart.question?.add(element);
  //       });
  //     });
  //   });

  //   response = '';
  //   indexOfAcceptedItem = -1;
  //   notifyListeners();
  // }
//new sourav
  Future<void> fquestionNext(int? userTestId) async {
    await repo
        .fquestionNext(
      userTestId!,
      questionId,
      response,
      timetaken,
      review: review,
    )
        .then((result) {
      result.fold((l) => null, (r) {
        r.question?.forEach((element) {
          testStart.question?.add(element);
        });
      });
    });

    // Clear the selected choices for the current question
    // selectedChoices[currentQuestionPageIndex]
    //     .fillRange(0, selectedChoices[currentQuestionPageIndex].length, -1);

    response = '';
    indexOfAcceptedItem = -1;
    notifyListeners();
  }

  Future<void> ftestPaused(int userTestId, int questionIdNum) async {
    return repo.ftestPaused(userTestId, questionIdNum);
  }

  Future<void> ftestSubmit(int userTestId) async {
    return repo.ftestSubmit(userTestId);
  }

  Future<void> ftestBookmark(int? idTest, int userTestId) async {
    return repo.ftestBookmark(idTest ?? userTestId);
  }

  Future<void> ftestResults(int? idTest) async {
    testResultsEntity =
        await repo.ftestResults(idTest ?? testEntity.userTestId!.toInt());
  }

  Future<void> fsprintHistory(int userTestId) async {
    sprintHistoryEntity = await repo.fsprintHistory(userTestId);
    notifyListeners();
  }

  Future<void> ftestHistory(String? startDate, String? endDate,
      String? subjectName, String? searchConceptName, String? filter1) async {
    testHistoryEntity = await repo.ftestHistory(
        startDate, endDate, subjectName, searchConceptName, filter1);
    notifyListeners();
  }

  Future<void> fanalytics() async {
    analyticsEntity = await repo.fanalytics(selectedTime);
    notifyListeners();
  }

  Future<void> fanalyticsSubject() async {
    analyticsSubject = await repo.fanalyticsSubject(subjectId, selectedTime);
    notifyListeners();
  }

  Future<void> freports(String time) async {
    reportsEntity = await repo.freports(time);
    notifyListeners();
  }

  void setState() {
    notifyListeners();
  }

  void clearPrevious() {
    questionId = 0;
    response = '';
    timetaken = 0;
    review = false;
  }

  void updateSubjectMap(SubjectList element, {required bool reload}) {
    if (element.loop != null) {
      subjectwisePerformanceValues.clear();

      subjectMap.update('Confidence', (value) => element.confidence);
      subjectMapAll.update(
          'Confidence', (value) => analyticsEntity.allConfidence);
      subjectMap.update('Score', (value) => element.score);
      subjectMapAll.update('Score', (value) => analyticsEntity.allScore);
      subjectMap.update('Tests', (value) => element.tests);
      subjectMapAll.update('Tests', (value) => analyticsEntity.allTests);
      subjectMap.update('Performance', (value) => element.performance);
      subjectMapAll.update(
          'Performance', (value) => analyticsEntity.allPerformance);
      subjectMap.update('Accuracy', (value) => element.accuracy);
      subjectMapAll.update('Accuracy', (value) => analyticsEntity.allAccuracy);

      subjectwisePerformanceValues.add(element.loop!.toDouble());
      subjectwisePerformanceValues.add(element.tests!.toDouble());
      subjectwisePerformanceValues.add(element.custom!.toDouble());
      subjectwisePerformanceValues.add(element.other!.toDouble());

      if (subjectwisePerformanceValues.isEmpty) {
        subjectwisePerformanceValues.add(0.0);
      }
      if (reload) {
        notifyListeners();
      }
    }
  }

  bool getEmptyChart() {
    if (subjectwisePerformanceValues.isEmpty) {
      return true;
    } else {
      int dataCount = 0;
      subjectwisePerformanceValues.forEach((element) {
        if (element > 0) {
          ++dataCount;
        }
      });
      if (dataCount > 0) {
        return true;
      }
    }
    return false;
  }
}

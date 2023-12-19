import 'package:dartz/dartz.dart';
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

abstract class TestRepo {
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
  });
  Future<TestChapters> ftestChapters(int subjectId);
  Future<TestSummaryEntity> ftestSummary(int userTestId);
  Future<CustomTestEntity> fcustomTest(
      {List<int>? chapterIds,
      List<int>? conceptIds,
      List<int>? level,
      List<int>? format,
      required num subjectId,
      num? testId});
  Future<TestChapterConcept> ftestChapterConcept(int subjectId, int chapterId);
  Future<TestHomeEntity> ftestHome(int subjectId);
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
  });
  Future<LoopsHomeEntity> floopsHome(int subjectId);
  Future<LoopsBottomSheetEntity> floopsBottomSheet({required int testID});
  Future<void> fquestionBookmark(int questionId);
  Future<Either<Unit, TestStart>> fquestionNext(
      int userTestId, int questionId, String response, int timetaken,
      {bool? review});
  Future<void> ftestPaused(int userTestId, int questionIdNum);
  Future<void> ftestSubmit(int userTestId);
  Future<void> ftestBookmark(int userTestId);
  Future<TestResultsEntity> ftestResults(int userTestId);
  Future<SprintHistoryEntity> fsprintHistory(int userTestId);
  Future<TestHistoryEntity> ftestHistory(String? startDate, String? endDate,
      String? subjectName, String? searchConceptName, String? filter1);
  Future<AnalyticsEntity> fanalytics(String time);
  Future<AnalyticsSubject> fanalyticsSubject(int subjectId, String time);
  Future<ReportsEntity> freports(String time);
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/auth/auth_provider.dart';
import 'package:EdTestz/application/firebase/firebase_notification_provider.dart';
import 'package:EdTestz/application/home/home_provider.dart';
import 'package:EdTestz/application/other/other_provider.dart';
import 'package:EdTestz/application/test/test_provider.dart';
import 'package:EdTestz/core/utli/error_handle.dart';
import 'package:EdTestz/core/utli/show_error_toast.dart';
import 'package:EdTestz/domain/entities/recommendations_entity.dart';
import 'package:EdTestz/presentation/home/homescreen.dart';
import 'package:EdTestz/presentation/results/widgets/test_results.dart';
import 'package:EdTestz/presentation/test_screens/test_instructions.dart';
import 'package:EdTestz/presentation/test_screens/test_summary.dart';

import '../../presentation/test_screens/custom_test.dart';

Future<void> gotoHomePage(BuildContext context) async {
  await Provider.of<HomeProvider>(context, listen: false)
      .fhome()
      .then((_) async {
    await Provider.of<HomeProvider>(context, listen: false)
        .ffaq(type: 'home')
        .then((_) async {
      Provider.of<OtherProvider>(context, listen: false)
          .routeNames
          .add('/homeScreen');
      await Navigator.pushNamedAndRemoveUntil(
        context,
        '/homeScreen',
        (route) => false,
      ).then((_) {
        // Provider.of<OtherProvider>(context, listen: false).routeNames.clear();
      });
    }).onError((error, stackTrace) async {
      await handleError(error);
    });
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> gotoSubscription(BuildContext context) async {
  await Provider.of<HomeProvider>(context, listen: false)
      .fsubscription()
      .then((_) async {
    Provider.of<OtherProvider>(context, listen: false)
        .routeNames
        .add('/subscription');
    await Navigator.of(context).pushNamed(
      '/subscription',
    );
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> gotoScheduledTests(BuildContext context) async {
  await Provider.of<HomeProvider>(context, listen: false)
      .fsubscription()
      .then((_) async {
    Provider.of<OtherProvider>(context, listen: false)
        .routeNames
        .add('/ScheduledTests');
    await Navigator.of(context).pushNamed(
      '/ScheduledTests',
    );
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> gotoTestHome(BuildContext context) async {
  await Provider.of<TestProvider>(context, listen: false)
      .ftestHome()
      .then((value) async {
    Provider.of<OtherProvider>(context, listen: false)
        .routeNames
        .add('/testHome');
    await Navigator.pushNamedAndRemoveUntil(
      context,
      '/testHome',
      (route) => false,
    );
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> gotoSignupPage(BuildContext context) async {
  await Provider.of<AuthAppProvider>(context, listen: false)
      .fsignup(fcmToken: fcmTokenGlobal)
      .then((_) async {
    Provider.of<OtherProvider>(context, listen: false)
        .routeNames
        .add('/signUpForm');
    await Navigator.pushNamedAndRemoveUntil(
      context,
      '/signUpForm',
      (route) => false,
    );
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> gotoProfile(BuildContext context) async {
  await Provider.of<AuthAppProvider>(context, listen: false)
      .fprofile()
      .then((_) async {
    await Provider.of<AuthAppProvider>(context, listen: false)
        .fprofileDetailed()
        .then((_) async {
      Provider.of<OtherProvider>(context, listen: false)
          .routeNames
          .add('/profile');
      await Navigator.pushNamedAndRemoveUntil(
        context,
        '/profile',
        (route) => false,
      );
    }).onError((error, stackTrace) async {
      await handleError(error);
    });
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> showDrawer() async {
  await Future.delayed(const Duration(milliseconds: 500)).then((_) {
    if (isDrawerOpen) {
      closeTheDrawer();
    } else {
      openTheDrawer();
    }
  });
}

Future<void> gotoLoops(BuildContext context) async {
  await Provider.of<TestProvider>(context, listen: false)
      .floopsHome()
      .then((_) async {
    Provider.of<OtherProvider>(context, listen: false).routeNames.add('/loops');
    await Navigator.pushNamedAndRemoveUntil(
      context,
      '/loops',
      (route) => false,
    );
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> gotoAnalyticsPage(BuildContext context) async {
  await Provider.of<TestProvider>(context, listen: false)
      .fanalytics()
      .then((_) async {
    await Provider.of<TestProvider>(context, listen: false)
        .fanalyticsSubject()
        .then((_) async {
      Provider.of<OtherProvider>(context, listen: false)
          .routeNames
          .add('/analyticsPage');
      await Navigator.pushNamedAndRemoveUntil(
        context,
        '/analyticsPage',
        (route) => false,
      );
    }).onError((error, stackTrace) async {
      await handleError(error);
    });
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> gotoAllChapters(BuildContext context) async {
  await Provider.of<TestProvider>(context, listen: false)
      .ftestChapters()
      .then((_) async {
    Provider.of<OtherProvider>(context, listen: false)
        .routeNames
        .add('/allChapters');
    await Navigator.pushNamed(
      context,
      '/allChapters',
    );
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> gotoCustomTest(
  BuildContext context,
  int testId,
) async {
  // Provider.of<TestProvider>(context, listen: false).testID = testId;
  await Provider.of<TestProvider>(context, listen: false)
      .fcustomTest()
      .then((_) async {
    Provider.of<OtherProvider>(context, listen: false)
        .routeNames
        .add('/customTest');
    await Navigator.pushNamed(
      context,
      '/customTest',
    );
  });
}

Future<void> gotoConceptBased(BuildContext context, int chapterId) async {
  Provider.of<TestProvider>(context, listen: false).chapterId = chapterId;
  await Provider.of<TestProvider>(context, listen: false)
      .ftestChapterConcept()
      .then((_) async {
    Provider.of<OtherProvider>(context, listen: false)
        .routeNames
        .add('/conceptBased');
    await Navigator.pushNamed(
      context,
      '/conceptBased',
    );
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> gotoTestInstructions(
  BuildContext context, {
  TestEntity? testEntity,
  String? customName,
  String? customConceptIds,
  String? customLevels,
  String? customFormats,
  String? questionsId,
  String? chaptersId,
  String? practiceId,
  required String testType,
  bool fromCustomTest = false,
  bool isPrecticeTest = false,
}) async {
  Provider.of<TestProvider>(context, listen: false).fromCustomTest =
      fromCustomTest;
  //Provider.of<TestProvider>(context, listen: false).testEntity.rightTop != null ? Provider.of<TestProvider>(context, listen: false).testStart.resumeQuesId = null : Provider.of<TestProvider>(context, listen: false).testStart.resumeQuesId = 1;
  /* if (testEntity.userTestId != null) {
    Provider.of<TestProvider>(context, listen: false).userTestId =
        testEntity.userTestId!.toInt();
  } else if (testEntity.testId != null) {
    Provider.of<TestProvider>(context, listen: false).testID =
        testEntity.testId!.toInt();
  } */

  await Provider.of<TestProvider>(context, listen: false)
      .ftestInstructions(
          customName: customName,
          customConceptIds: customConceptIds,
          customFormats: customFormats,
          customLevels: customLevels,
          chaptersId: chaptersId,
          questionsId: questionsId,
          testType: testType,
          practiceId: practiceId,
          testEntity: testEntity)
      .then((_) async {
    Provider.of<TestProvider>(context, listen: false).practice =
        testEntity?.leftTop?.toUpperCase().trim() == 'PRACTICE' ||
            testType.toUpperCase().trim() == 'PRACTICE';
    if (isPrecticeTest) {
      Provider.of<TestProvider>(context, listen: false).practice = true;
    } else {
      Provider.of<TestProvider>(context, listen: false).practice = false;
    }
    Provider.of<OtherProvider>(context, listen: false)
        .routeNames
        .add('/testInstructions');
    // await Navigator.pushNamed(
    //   context,
    //   '/testInstructions',
    // );
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestInstructions(
              isResume: isPrecticeTest,
              testType:
                  testType.isEmpty ? testEntity?.leftTop ?? '' : testType),
        ));
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> gotoStartTest(BuildContext context, TestEntity testEntity,
    {required bool fromCustomTest, required String? practiceId}) async {
  if (fromCustomTest) {
    if (kDebugMode) {
      print('AA-1');
      // print(provider.fromCustomTest);
    }
    await Provider.of<TestProvider>(context, listen: false)
        .ftestStart(
            // conceptIds: context.read<TestProvider>().customTestEntity.conceptIds!,
            customName: controllerCustom.text,
            chapterIds: selectedChapters.join(','),
            customConceptIds: selectedConcepts.join(','),
            customFormats: selectedFormats.join(','),
            customLevels: selectedLevels.join(','),
            testEntity: testEntity,
            questionIds:
                context.read<TestProvider>().customTestEntity.questionIds,
            practiceId: practiceId)
        .then((value) async {
      Provider.of<OtherProvider>(context, listen: false)
          .routeNames
          .add('/testScreen');
      await Navigator.pushNamed(
        context,
        '/testScreen',
      );
    });
  } else {
    if (kDebugMode) {
      print('AA-2');
      print(testEntity.userTestId);
      // print(provider.fromCustomTest);
    }
    // if(practiceId == null){
    //   Provider.of<TestProvider>(context, listen: false).practice = false;
    // }
    await Provider.of<TestProvider>(context, listen: false)
        .ftestStart(
      testEntity: testEntity,
      practiceId: practiceId,
    )
        .then((_) async {
      if (Provider.of<TestProvider>(context, listen: false)
              .testStart
              .poorPerformanceMessage ==
          null) {
        await gotoQuestionTypes(
          context,
          Provider.of<TestProvider>(context, listen: false)
              .testStart
              .question!
              .first
              .format!,
        );
      } else {
        showErrorToast(Provider.of<TestProvider>(context, listen: false)
                .testStart
                .poorPerformanceMessage ??
            '');
      }
    }).onError((error, stackTrace) async {
      await handleError(error);
    });
  }
}

Future<void> gotoTestSummary(
    BuildContext context, int userTestId, bool isShowResume) async {
  await Provider.of<TestProvider>(context, listen: false)
      .ftestSummary(userTestId)
      .then((_) async {
    Provider.of<OtherProvider>(context, listen: false)
        .routeNames
        .add('/testSummary');
    // await Navigator.pushNamedAndRemoveUntil(
    //   context,
    //   '/testSummary',
    //   (route) => false,
    // );
    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => TestSummary(isShowResumeButton: isShowResume),
        ),
        (route) => false);
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> gotoResults(BuildContext context, int? idTest, int? index) async {
  await Provider.of<TestProvider>(context, listen: false)
      .ftestResults(idTest)
      .then((_) async {
    if (kDebugMode) {
      print('AA-2');
      print(idTest);
      // print(provider.fromCustomTest);
    }
    Provider.of<OtherProvider>(context, listen: false)
        .routeNames
        .add('/results');
    // Navigator.popUntil(context, (route) => route.isFirst);
    // await Navigator.pushNamedAndRemoveUntil(
    //     context, '/results', (route) => false,
    //     arguments: {'index': index});
    await Navigator.of(context).pushNamed(
      '/results',
      arguments: {'index': index},
    );
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> gotoReferral(BuildContext context) async {
  await Provider.of<HomeProvider>(context, listen: false)
      .freferralPage()
      .then((_) async {
    Provider.of<OtherProvider>(context, listen: false).routeNames.add('/refer');
    await Navigator.pushNamed(
      context,
      '/refer',
    );
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> gotoNotification(BuildContext context) async {
  await Provider.of<HomeProvider>(context, listen: false)
      .fnotificationHistory()
      .then((_) async {
    Provider.of<OtherProvider>(context, listen: false)
        .routeNames
        .add('/notification');
    await Navigator.pushNamed(
      context,
      '/notification',
    );
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> gotoSprintHistory(
    BuildContext context, int userTestId, String testName) async {
  await Provider.of<TestProvider>(context, listen: false)
      .fsprintHistory(userTestId)
      .then((_) async {
    // Provider.of<OtherProvider>(context, listen: false)
    //     .routeNames
    //     .add('/sprintHistory');
    // await Navigator.pushNamed(
    //   context,
    //   '/sprintHistory',
    // );
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SprintHome(
            testName: testName.isEmpty
                ? Provider.of<TestProvider>(context, listen: false)
                        .sprintHistoryEntity
                        .chapterName ??
                    ''
                : testName),
      ),
    );
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

// Future<void> gotoSprintHistory(BuildContext context, int chapterId) async {
//   await Provider.of<TestProvider>(context, listen: false)
//       .fsprintHistory(chapterId)
//       .then((_) async {
//     Provider.of<OtherProvider>(context, listen: false)
//         .routeNames
//         .add('/sprintHistory');
//     await Navigator.pushNamed(
//       context,
//       '/sprintHistory',
//     );
//   }).onError((error, stackTrace) async {
//     await handleError(error);
//   });
// }

Future<void> gotoQuestionTypes(BuildContext context, String format) async {
  Provider.of<OtherProvider>(context, listen: false)
      .routeNames
      .add('/testScreen');
  await Navigator.pushNamed(
    context,
    '/testScreen',
  );
}

Future<void> gotoTestHistory(BuildContext context) async {
  Provider.of<OtherProvider>(context, listen: false)
      .routeNames
      .add('/testHistory');
  unawaited(Navigator.of(context).pushNamed(
    '/testHistory',
  ));
  unawaited(showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  ));
  await Provider.of<TestProvider>(context, listen: false)
      .ftestHistory(
    null,
    null,
    null,
    null,
    null,
  )
      .then((_) async {
    Navigator.pop(context);
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> gotoReports(BuildContext context, bool isHome,
    {String time = 'This week'}) async {
  unawaited(showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  ));
  await Provider.of<TestProvider>(context, listen: false)
      .freports(time)
      .then((_) async {
    Provider.of<OtherProvider>(context, listen: false)
        .routeNames
        .add('/reports');
    if (time == 'This week') {
      Navigator.pop(context);
      await Navigator.pushNamed(
        context,
        '/reports',
        // (route) => false,
      );
    }
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

void goSpecificBack(BuildContext context, index) {
  // final int lastIndex = Provider.of<OtherProvider>(context, listen: false)
  //     .routeNames
  //     .lastIndexOf('/results');
  // if (kDebugMode) {
  //   print("INDEX:");
  //   print(lastIndex);
  // }
  if (index == 0) {
    Navigator.pushReplacementNamed(context, '/homeScreen');
  }
  if (index == 1) {
    Navigator.pushReplacementNamed(context, '/sprintHistory');
  }
  if (index == 2) {
    Navigator.pushReplacementNamed(context, '/testHistory');
  }
  if (index == 3) {
    Navigator.pop(context);
    // Navigator.pushReplacementNamed(context, '/testHome');
  }
}

void goBack(BuildContext context) {
  final int homeIndex = Provider.of<OtherProvider>(context, listen: false)
      .routeNames
      .lastIndexOf('/homeScreen');

  final int testHomeIndex = Provider.of<OtherProvider>(context, listen: false)
      .routeNames
      .lastIndexOf('/testHome');
  final int loopsIndex = Provider.of<OtherProvider>(context, listen: false)
      .routeNames
      .lastIndexOf('/loops');
  final int analyticsIndex = Provider.of<OtherProvider>(context, listen: false)
      .routeNames
      .lastIndexOf('/analyticsPage');
  if (homeIndex == testHomeIndex && loopsIndex == analyticsIndex) {
    gotoHomePage(context);
  }
  if (homeIndex > testHomeIndex &&
      homeIndex > loopsIndex &&
      homeIndex > analyticsIndex) {
    gotoHomePage(context);
  } else if (testHomeIndex > homeIndex &&
      testHomeIndex > loopsIndex &&
      testHomeIndex > analyticsIndex) {
    gotoTestHome(context);
  } else if (loopsIndex > homeIndex &&
      loopsIndex > testHomeIndex &&
      loopsIndex > analyticsIndex) {
    if (kDebugMode) {
      print('ISSUEE');
    }
    gotoLoops(context);
  } else {
    gotoAnalyticsPage(context);
  }
}

Future<void> gotoSplashScreen(BuildContext context) async {
  await Provider.of<AuthAppProvider>(context, listen: false)
      .fsplashScreen()
      .then((_) async {
    Provider.of<OtherProvider>(context, listen: false)
        .routeNames
        .add('/info01');
    await Navigator.pushNamedAndRemoveUntil(
      context,
      '/info01',
      (route) => false,
    );
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

Future<void> gotoFAQs(BuildContext context, String type) async {
  await Provider.of<HomeProvider>(context, listen: false)
      .ffaq(type: type)
      .then((_) async {
    Provider.of<OtherProvider>(context, listen: false).routeNames.add('/faq');
    await Navigator.pushNamed(
      context,
      '/faq',
    );
  }).onError((error, stackTrace) async {
    await handleError(error);
  });
}

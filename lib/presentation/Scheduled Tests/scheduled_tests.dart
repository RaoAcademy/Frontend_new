import 'package:EdTestz/presentation/Scheduled%20Tests/widget/paused_finish_test_screen.dart';
import 'package:EdTestz/presentation/Scheduled%20Tests/widget/schedual_practice_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/presentation/Scheduled%20Tests/shedual_test_provider.dart';
import 'package:EdTestz/presentation/Scheduled%20Tests/widget/missed_test.dart';
import 'package:EdTestz/presentation/Scheduled%20Tests/widget/upcomming.dart';

class ScheduledTestsScreen extends StatefulWidget {
  const ScheduledTestsScreen ({super.key});

  @override
  State<ScheduledTestsScreen> createState() => _ScheduledTestsScreenState();
}

class _ScheduledTestsScreenState extends State<ScheduledTestsScreen> {

  @override
  void initState() {
    super.initState();
    context.read<ScheduleTestProvider>().getPausedFinishPracticeTest();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: LoopsColors.primaryColor,
          title: Text("Scheduled Tests"),
        bottom: TabBar(
          isScrollable: true,
          tabs: [
            Tab(text: "Upcomming"),
            Tab(text: "Missed",),
            Tab(text: "Paused/Finished"),
            Tab(text: "Practice"),
            Tab(text: "Paused/Finished"),
          ],
        ),
        ),
        body:  TabBarView(
          children: [
            UpCommingScreen(),
            MissedTestScreen(),
            PausedFinishScreen(),
            SchedualPracticeTestScreen(),
            Container()
          ],
        ),
      ),
    );
  }
}

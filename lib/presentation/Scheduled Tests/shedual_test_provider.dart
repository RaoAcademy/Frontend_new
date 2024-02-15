import 'package:EdTestz/presentation/Scheduled%20Tests/test_paused_model.dart';
import 'package:flutter/material.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/presentation/Scheduled%20Tests/shedual_tests_model.dart';
import 'package:http/http.dart' as http;

class ScheduleTestProvider with ChangeNotifier{
  TestModel? _schedualPractice ;
  TestModel? get schedualPractice => _schedualPractice;
  TestPausedModel? _schedualPaused ;
  TestPausedModel? get schedualPaused => _schedualPaused;
  TestModel? _uppcoming ;
  TestModel? get uppcoming => _uppcoming;
  TestModel? _missed ;
  TestModel? get missed => _missed;
  TestModel? _missedPractice ;
  TestModel? get missedPractice => _missedPractice;

  getSchedualPracticeTest() async{
    final res = await http.post(Uri.parse(LoopsUrls.baseUrl + LoopsUrls.fschedualPractice),
    body: {
      'userId':'673'
    }
    );
    if(res.statusCode == 200){
      _schedualPractice = testModelFromJson(res.body);
    }
    notifyListeners();
  }
  getPausedFinishPracticeTest() async{
    final res = await http.post(Uri.parse(LoopsUrls.baseUrl + LoopsUrls.fPausedFinishPractice),
    body: {
      'userId':'673'
    }
    );
    if(res.statusCode == 200){
      _schedualPaused = testPausedModelFromJson(res.body);
    }
    notifyListeners();
  }

  getSchedualPracticeTest1() async{
    final res = await http.get(Uri.parse(LoopsUrls.baseUrl + LoopsUrls.fschedualPractice));
    if(res.statusCode == 200){
      _schedualPractice = testModelFromJson(res.body);
    }
    notifyListeners();
  }

}
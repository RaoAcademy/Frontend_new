import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashProvider with ChangeNotifier {
  SplashProvider();

  List<String> infoHead = [
    'Weekly Reports',
    'Custom Tests',
    'Challenge your Friends',
    'Time for new way of Learning',
    'Study & share any topic'
  ];
  List<String> infoText = [
    'We bring you weekly report which will showcase your performance, activity and progress for that week',
    'Now you can create your own custom tests upto concept level',
    'It can be loops, custom tests and concept based tests you can challenge and compete with your friends',
    'With our platform, you have more than detailed tests to take anywhere, anytime!',
    'Find an interesting topic, study it and discuss this topic with all your friends'
  ];

  int currentIndex = 0;
  void setState() {
    notifyListeners();
  }
}

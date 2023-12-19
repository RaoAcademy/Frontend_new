import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class OtherProvider with ChangeNotifier {
  OtherProvider();
  int currentTab = 0;
  void setState() {
    notifyListeners();
  }

  List<String> routeNames = [];
}

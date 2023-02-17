import 'package:flutter/material.dart';

class HomePageProvider with ChangeNotifier {
  String? deviceId;
  int currentIndex = 0;
  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}

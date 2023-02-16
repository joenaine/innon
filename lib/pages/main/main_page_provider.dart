import 'package:flutter/material.dart';

class MainPageProvider with ChangeNotifier {
  int currentIndex = 0;
  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}

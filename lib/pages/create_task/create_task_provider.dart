import 'package:flutter/material.dart';

class CreateTaskProvider extends ChangeNotifier {
  bool isCreateButtonActive = false;
  void setButtonActive(bool value) {
    isCreateButtonActive = value;
    notifyListeners();
  }
}

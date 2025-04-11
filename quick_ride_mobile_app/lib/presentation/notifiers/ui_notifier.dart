import 'package:flutter/material.dart';

class UiNotifier extends ChangeNotifier {
  int _indexTabIndex = 0;
  int get indexTabIndex => _indexTabIndex;
  set indexTabIndex(int value) {
    _indexTabIndex = value;
    notifyListeners();
  }
}

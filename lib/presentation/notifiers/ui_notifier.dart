import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class UiNotifier extends ChangeNotifier {
  int _indexTabIndex = 1;
  int get indexTabIndex => _indexTabIndex;
  set indexTabIndex(int value) {
    _indexTabIndex = value;
    notifyListeners();
  }

  AlignOnUpdate _alignPositionOnUpdate = AlignOnUpdate.always;
  AlignOnUpdate get alignPositionOnUpdate => _alignPositionOnUpdate;
  set alignPositionOnUpdate(AlignOnUpdate value) {
    _alignPositionOnUpdate = value;
    notifyListeners();
  }

  double _rideDetailScrollPos = 0;
  double get rideDetailScrollPos => _rideDetailScrollPos;
  set rideDetailScrollPos(double value) {
    _rideDetailScrollPos = value;
    notifyListeners();
  }
}

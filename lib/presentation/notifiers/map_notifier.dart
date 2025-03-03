import '../../entity/osm_entity.dart';
import 'package:flutter/material.dart';

class MapNotifier extends ChangeNotifier {
  bool _isMapMoving = false;
  bool get isMapMoving => _isMapMoving;
  set isMapMoving(bool value) {
    _isMapMoving = value;
    notifyListeners();
  }

  bool _isPickLocLoading = false;
  bool get isPickLocLoading => _isPickLocLoading;
  set isPickLocLoading(bool value) {
    _isPickLocLoading = value;
    notifyListeners();
  }

  PickedData? _firstDropOff;
  PickedData? get firstDropOff => _firstDropOff;
  set firstDropOff(PickedData? value) {
    _firstDropOff = value;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:quick_ride_user/di.dart';
import '../../entity/bus_info_entity.dart';
import 'package:quick_ride_user/repository/repository.dart';

class BusesNotifier extends ChangeNotifier {
  Repository get _repository => getIt<Repository>();

  List<BusInfoEntity> _busesInfo = [];
  List<BusInfoEntity> get busesInfo => _busesInfo;

  bool isLoading = false;

  String? _getBusesErrorMsg;
  String? get getBusesErrorMsg => _getBusesErrorMsg;

  void getBuses({
    required String from,
    required String to,
    required String date,
  }) async {
    if (isLoading) return;

    isLoading = true;
    _getBusesErrorMsg = null;
    notifyListeners();

    try {
      final resp = await _repository.searchTravelResult(
        from: from,
        to: to,
        date: date,
      );
      busesInfo.clear();
      _busesInfo = [];
      _busesInfo = resp;
      isLoading = false;
      _getBusesErrorMsg = null;
      notifyListeners();
    } catch (e) {
      _getBusesErrorMsg = e.toString();
      busesInfo.clear();
      _busesInfo = [];
      isLoading = false;
      notifyListeners();
    }
  }
}

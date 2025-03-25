import 'package:flutter/material.dart';
import 'package:quick_ride_user/di.dart';
import 'package:quick_ride_user/entity/ticket_entity.dart';
import 'package:quick_ride_user/repository/repository.dart';

class TripsNotifier extends ChangeNotifier {
  Repository get _repository => getIt<Repository>();

  List<TicketEntity> _bookingsList = [];
  List<TicketEntity> get bookingsList => _bookingsList;

  bool isLoading = false;
  String? _getBookingsErrorMsg;
  String? get getBookingsErrorMsg => _getBookingsErrorMsg;

  void getTicketBookings({bool clear = false}) async {
    if (isLoading) return;
    if (clear) _bookingsList.clear();

    isLoading = true;
    _getBookingsErrorMsg = null;
    notifyListeners();

    try {
      final resp = await _repository.getTicketBookings();
      _bookingsList.clear();
      _bookingsList = [];
      _bookingsList = resp;
      isLoading = false;
      _getBookingsErrorMsg = null;
      notifyListeners();
    } catch (e) {
      _getBookingsErrorMsg = e.toString();
      _bookingsList.clear();
      _bookingsList = [];
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> cancelTicket({required String ticketNumber}) async {
    try {
      return await _repository.cancelTicket(ticketNumber: ticketNumber);
    } catch (e) {
      rethrow;
    }
  }
}

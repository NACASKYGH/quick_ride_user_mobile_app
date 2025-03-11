import 'dart:convert';
import '../../di.dart';
import '../../entity/app_user.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import '../../repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthNotifier extends ChangeNotifier {
  Repository get _repository => getIt<Repository>();

  AppUser? _appUser;
  AppUser? get appUser => _appUser;

  String _locationID = '10';
  String get locationID => _locationID;
  set locationID(String value) {
    _locationID = value;
    notifyListeners();
  }

  Future<AppUser?> getLocalUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? localUserString = prefs.getString(localUser);
      if (localUserString != null) {
        AppUser appUser = AppUser.fromJson(jsonDecode(localUserString));
        _appUser = appUser;
        notifyListeners();
      }
      return appUser;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  ///
  ///
  ///
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMsg;
  String? get errorMsg => _errorMsg;

  // Future<bool?> login({
  //   required String phone,
  //   required String password,
  // }) async {
  //   if (_isLoading) return null;
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     AppUser response = await _repository.loginOnServer(
  //       loginID: loginID,
  //       password: password,
  //     );

  //     _appUser = response;
  //     final prefs = await SharedPreferences.getInstance();
  //     prefs.setString(localUser, jsonEncode(response.toJson()));
  //     // prefs.setString(userPass, password);

  //     _isLoading = false;
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     logger.e(e);
  //     _isLoading = false;
  //     _errorMsg = e.toString();
  //     notifyListeners();
  //     return false;
  //   }
  // }

  Future<bool?> checkPhone({required String phone}) async {
    if (_isLoading) return null;
    _isLoading = true;
    notifyListeners();

    try {
      bool response = await _repository.checkIfExistingUser(
        phone: phone,
      );

      _isLoading = false;
      _errorMsg = null;
      notifyListeners();
      return response;
    } catch (e) {
      _isLoading = false;
      _errorMsg = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<void> signOut() async {
    _isLoading = false;
    _errorMsg = null;
    _appUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

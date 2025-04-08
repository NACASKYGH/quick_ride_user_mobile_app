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
  set errorMsg(String? value) {
    _errorMsg = value;
    notifyListeners();
  }

  Future<String?> checkPhone({required String phone}) async {
    if (_isLoading) return null;
    _isLoading = true;
    notifyListeners();

    try {
      String response = await _repository.checkIfExistingUser(phone: phone);

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

  Future<bool?> login({required String phone, required String password}) async {
    if (_isLoading) return null;
    _isLoading = true;
    _errorMsg = null;
    notifyListeners();

    try {
      AppUser response = await _repository.login(
        phone: phone,
        password: password,
      );

      _appUser = response;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(localUser, jsonEncode(response.toJson()));
      prefs.setString(userPass, password);
      getUser();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      logger.e(e);
      _isLoading = false;
      _errorMsg = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool?> signUp({required Map<String, dynamic> map}) async {
    if (_isLoading) return null;
    _isLoading = true;
    _errorMsg = null;
    notifyListeners();

    try {
      AppUser response = await _repository.signup(map: map);

      _appUser = response;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(localUser, jsonEncode(response.toJson()));
      getUser();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      logger.e(e);
      _isLoading = false;
      _errorMsg = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> getUser() async {
    if (_appUser == null) return;

    try {
      AppUser response = await _repository.getUser();

      _appUser = response;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(localUser, jsonEncode(response.toJson()));

      getUserAutoFills();

      notifyListeners();
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> getUserAutoFills() async {
    if (_appUser == null) return;

    try {
      AppUser response = await _repository.getUserAutoFills();

      logger.d(response);

      _appUser = response;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(localUser, jsonEncode(response.toJson()));

      notifyListeners();
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> updateUser({
    required String name,
    required String email,
    required String gender,
    required String date,
  }) async {
    try {
      AppUser response = await _repository.updateUser(
        name: name,
        email: email,
        gender: gender,
        date: date,
      );

      _appUser = response;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(localUser, jsonEncode(response.toJson()));

      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> updatePassword({
    required String oldPass,
    required String newPass,
  }) async {
    try {
      return await _repository.changePass(oldPass: oldPass, newPass: newPass);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    _isLoading = false;
    _errorMsg = null;
    _appUser = null;
    bool showWalkThru = prefs.getBool(PrefKeys.showWalkThru) ?? true;
    await prefs.clear();
    prefs.setBool(PrefKeys.showWalkThru, showWalkThru);
  }
}

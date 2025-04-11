import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'entity/app_user.dart';
import '/utils/constants.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'repository/repository.dart';
import 'repository/repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

final logger = getIt.get<Logger>();
final prefs = getIt.get<SharedPreferences>();

typedef AuthTokenGetter = FutureOr<AppUser?> Function();

Future<AppUser?> getUserToken() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    String? localUserString = prefs.getString(localUser);
    if (localUserString == null) return null;
    AppUser appUser = AppUser.fromJson(jsonDecode(localUserString));
    return appUser;
  } catch (e) {
    return null;
  }
}

Future<void> diSetup() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  getIt.registerLazySingleton<AuthTokenGetter>(() => () => getUserToken());
  getIt.registerSingleton<Logger>(Logger());

  getIt.registerLazySingleton<Dio>(() {
    var baseUrl = 'http://209.236.119.239:8092/API';
    return Dio(BaseOptions(baseUrl: baseUrl));
  });

  dependenciesInj();
}

void dependenciesInj() {
  getIt.registerLazySingleton<Repository>(
    () => RepositoryImpl(getIt.get(), token: getIt.get()),
  );
}

import 'dart:async';
import 'package:dio/dio.dart';
import '/utils/constants.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'repository/repository.dart';
import 'repository/repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

final logger = getIt.get<Logger>();
final prefs = getIt.get<SharedPreferences>();

typedef AuthTokenGetter = FutureOr<String?> Function();

Future<String?> getUserToken() async {
  try {
    String? token = prefs.getString(PrefKeys.showWalkThru);
    return (token ?? '').isNotEmpty ? 'Bearer $token' : null;
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
    () => RepositoryImpl(
      getIt.get(),
      token: getIt.get(),
    ),
  );
}

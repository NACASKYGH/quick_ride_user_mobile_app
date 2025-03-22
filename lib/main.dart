import 'di.dart';
import 'app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/notifiers/ui_notifier.dart';
import 'presentation/notifiers/auth_notifier.dart';
import 'presentation/notifiers/trips_notifier.dart';
import 'presentation/notifiers/buses_notifier.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  await diSetup();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      useOnlyLangCode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthNotifier()),
          ChangeNotifierProvider(create: (_) => UiNotifier()),
          ChangeNotifierProvider(create: (_) => BusesNotifier()),
          ChangeNotifierProvider(create: (_) => TripsNotifier()),
        ],
        child: const App(),
      ),
    ),
  );
}

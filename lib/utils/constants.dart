import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:x_ride_user/utils/app_colors.dart';

String get emptyAssetImage => 'assets/png/empty.png';

//Hive boxes
String get settingsBoxName => 'app_settings_$kDebugMode';

String get graphHopperApiKey => 'e73070db-21c9-46aa-9b0c-efb5c564706d';

class PrefKeys {
  static String get showWalkThru => 'show-walk-through-screen';
  static String get userLoggedInToken => 'token_$kDebugMode';
}

ColorFiltered darkMapFilter(Widget tileWidget) => ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        -0.2126, -0.7152, -0.0722, 0,
        255, // Red channel
        -0.2126, -0.7152, -0.0722, 0,
        255, // Green channel
        -0.2126, -0.7152, -0.0722, 0,
        255, // Blue channel
        0, 0, 0, 1, 0, // Alpha channel
      ]),
      child: tileWidget,
    );

Widget get divider => Divider(
      color: AppColors.grey.withValues(alpha: .2),
    );

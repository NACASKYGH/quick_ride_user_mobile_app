import '/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

String get emptyAssetImage => 'assets/png/empty.png';
String get localUser => 'local-user';

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

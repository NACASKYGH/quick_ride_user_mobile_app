import '/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

String get emptyAssetImage => 'assets/png/empty.png';
String get localUser => 'local-users';
String get userPass => 'local-user-passkey';

String get playstoreLink => 'https://play.google.com/store/apps/details?id';

class PrefKeys {
  static String get showWalkThru => 'show-walk-through-screen_';
  static String get userLoggedInToken => 'token_$kDebugMode';
}

Widget get divider => Divider(
      color: AppColors.grey.withValues(alpha: .2),
    );

import 'package:flutter/material.dart';
import 'package:quick_ride_user/utils/app_colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
// import 'package:flutter_vibrate/flutter_vibrate.dart';

Future<dynamic> appBottomModalSheet({
  required BuildContext context,
  required Widget child,
  bool expand = true,
  bool isDismissible = true,
  Radius? topRadius,
  Color? barrierColor,
  bool showBarrier = false,
  bool enableDrag = true,
}) async {
  return await showCupertinoModalBottomSheet(
    expand: expand,
    context: context,
    isDismissible: isDismissible,
    barrierColor:
        showBarrier
            ? barrierColor ?? AppColors.whiteText.withValues(alpha: .4)
            : null,
    topRadius: topRadius ?? const Radius.circular(16),
    backgroundColor: AppColors.whiteText,
    enableDrag: enableDrag,
    builder: (context) => child,
  );
}

Future<AlertButton> showError({
  String title = 'Error',
  String msg = 'Sorry, an error occurred',
}) async {
  // Vibrate.feedback(FeedbackType.error);
  return await FlutterPlatformAlert.showAlert(
    windowTitle: title,
    text: msg,
    alertStyle: AlertButtonStyle.ok,
    iconStyle: IconStyle.none,
  );
}

Future<void> showSuccess({
  String title = 'Success',
  String msg = 'Operation successful!',
}) async {
  // Vibrate.feedback(FeedbackType.success);
  await FlutterPlatformAlert.showAlert(
    windowTitle: title,
    text: msg,
    alertStyle: AlertButtonStyle.ok,
    iconStyle: IconStyle.none,
  );
}

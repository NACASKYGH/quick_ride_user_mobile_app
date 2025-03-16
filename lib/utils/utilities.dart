import 'package:flutter/material.dart';
import 'package:quick_ride_user/utils/app_colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<dynamic> appBottomModalSheet({
  required BuildContext context,
  required Widget child,
  bool expand = true,
  isDismissible = true,
  Radius? topRadius,
  Color? barrierColor,
  bool showBarrier = false,
  bool enableDrag = true,
}) async {
  return await showCupertinoModalBottomSheet(
    expand: expand,
    context: context,
    isDismissible: isDismissible,
    barrierColor: showBarrier
        ? barrierColor ?? AppColors.whiteText.withValues(alpha: .4)
        : null,
    topRadius: topRadius ?? const Radius.circular(16),
    backgroundColor: AppColors.whiteText,
    enableDrag: enableDrag,
    builder: (context) => child,
  );
}

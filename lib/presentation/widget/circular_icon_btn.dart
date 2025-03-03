import '../../utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:x_ride_user/utils/extensions.dart';

class CircularIconBtn extends StatelessWidget {
  const CircularIconBtn({
    super.key,
    this.onTap,
    this.bgColor = AppColors.grey1,
    this.icon,
    this.radius = 48,
    this.iconColor,
    this.showShadow = true,
  });
  final Function()? onTap;
  final Color bgColor;
  final Color? iconColor;
  final Widget? icon;
  final double radius;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor,
          boxShadow: !showShadow
              ? null
              : [
                  BoxShadow(
                    color: context.colors.inverseSurface.withValues(alpha: .05),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(3, 3),
                  )
                ],
        ),
        child: icon ??
            Icon(
              Icons.arrow_back_ios_new,
              color: iconColor,
            ),
      ),
    );
  }
}

import '../../utils/app_colors.dart';
import '../../utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easy_localization/easy_localization.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.title = '',
    this.onTap,
    this.isNegative = false,
    this.isDisabled = false,
    this.isLoading = false,
    this.isGradient = false,
    this.height = 47,
    this.width,
    this.child,
    this.textStyle,
    this.padding,
    this.trArgs,
    this.translateText = false,
    this.borderColor,
    this.radius = 47,
    this.trailing,
    this.leading,
  });

  final String title;
  final bool isNegative;
  final bool isDisabled;
  final bool isLoading;
  final bool isGradient;
  final double height;
  final double? width;
  final Function()? onTap;
  final Widget? child;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final List<String>? trArgs;
  final bool translateText;
  final Color? borderColor;
  final double radius;
  final Widget? trailing;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Container(
        padding: padding,
        height: height,
        width: width == 0 ? null : width ?? MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: isLoading || isDisabled ? null : onTap,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0.0),
            elevation: 0,
            foregroundColor: AppColors.transparent,
            backgroundColor: AppColors.transparent,
            side: isNegative
                ? BorderSide(color: borderColor ?? context.scaffoldColor)
                : null,
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                stops: [0.1, 0.9, 0.9],
                colors: isNegative
                    ? [
                        context.scaffoldColor,
                        context.scaffoldColor,
                        context.scaffoldColor,
                      ]
                    : isDisabled
                        ? [
                            AppColors.grey1,
                            AppColors.grey1,
                            AppColors.grey1,
                          ]
                        : isGradient
                            ? [
                                const Color.fromARGB(255, 50, 116, 183),
                                AppColors.primary,
                                AppColors.primary,
                                // const Color.fromARGB(255, 98, 194, 101),
                              ]
                            : [
                                AppColors.primary,
                                AppColors.primary,
                                AppColors.primary,
                              ],
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Container(
              height: height,
              alignment: Alignment.center,
              child: isLoading
                  ? const SpinKitThreeInOut(
                      color: AppColors.blackText,
                      size: 20.0,
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        leading ?? const SizedBox.shrink(),
                        child ??
                            Text(
                              translateText ? title.tr(args: trArgs) : title,
                              style: textStyle ??
                                  context.textTheme.labelMedium?.copyWith(
                                    color: isNegative
                                        ? AppColors.primary
                                        : AppColors.whiteText,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                        trailing ?? const SizedBox.shrink(),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

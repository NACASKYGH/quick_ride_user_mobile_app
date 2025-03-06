import 'package:lottie/lottie.dart';
import '../../utils/app_colors.dart';
import '../../utils/extensions.dart';
import 'package:flutter/material.dart';
import 'app_button.dart' show AppButton;

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    super.key,
    this.title = '',
    this.desc = '',
    this.showGreyLogo = true,
    this.padding,
    this.onRetry,
  });
  final String title;
  final String desc;
  final bool showGreyLogo;

  final EdgeInsets? padding;
  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: showGreyLogo,
              child: Lottie.asset(
                'assets/json/error-lottie.json',
                width: 60,
              ),
            ),
            Visibility(
              visible: title.isNotEmpty,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineMedium?.copyWith(
                  color: AppColors.grey700,
                ),
              ),
            ),
            Visibility(
              visible: desc.isNotEmpty,
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: context.textTheme.labelSmall?.copyWith(
                  color: AppColors.grey700,
                ),
              ),
            ),
            Visibility(
              visible: onRetry != null,
              child: SizedBox(
                width: 100,
                height: 70,
                child: AppButton(
                  height: 30,
                  title: 'Retry',
                  onTap: onRetry,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

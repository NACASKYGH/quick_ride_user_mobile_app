import '../../di.dart';
import '../../utils/constants.dart';
import '../../utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../notifiers/auth_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_ride_user/routes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    this.showLoading = true,
  });

  final bool showLoading;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthNotifier authNotifier;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await authNotifier.getLocalUser();
      authNotifier.getUser();
      if (!mounted) return;

      bool showWalkThru = prefs.getBool(PrefKeys.showWalkThru) ?? true;
      if (showWalkThru) {
        context.goNamed(RouteConsts.walkThru);
      } else {
        context.goNamed(RouteConsts.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    authNotifier = context.watch<AuthNotifier>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/png/logo.png',
            height: 200,
          ),
          widget.showLoading
              ? SpinKitThreeBounce(
                  size: 26,
                  color: AppColors.white,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

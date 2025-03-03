import '../../di.dart';
import '../../routes.dart';
import '/utils/extensions.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../notifiers/auth_notifier.dart';
import 'package:go_router/go_router.dart';
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
      await Future.delayed(const Duration(seconds: 3));

      bool showWalkThru = prefs.getBool(PrefKeys.showWalkThru) ?? true;
      if (!mounted) return;
      if (showWalkThru) {
        context.goNamed(RouteConsts.walkThru);
      } else {
        context.goNamed(RouteConsts.phoneScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    authNotifier = context.watch<AuthNotifier>();

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/png/logo-green.png',
              height: 200,
            ),
          ),
          widget.showLoading
              ? Padding(
                  padding: const EdgeInsets.only(top: 80.0, left: 130),
                  child: SpinKitThreeBounce(
                    size: 24,
                    color: context.colors.primary,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

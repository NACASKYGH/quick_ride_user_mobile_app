import '_home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '_rides/_rides_index_screen.dart';
import '_profile/_profile_index_screen.dart';
import '../widget/custom_bottom_navigation.dart';
import 'package:x_ride_user/presentation/notifiers/ui_notifier.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  Widget build(BuildContext context) {
    UiNotifier uiNotifier = context.watch<UiNotifier>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ClipRect(
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: IndexedStack(
          key: ValueKey<int>(uiNotifier.indexTabIndex),
          index: uiNotifier.indexTabIndex,
          children: [
            const HomeScreen(),
            const RidesIndexScreen(),
            const ProfileIndexScreen(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        showPathWayBadge: true,
      ),
    );
  }
}

import '_home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/custom_bottom_navigation.dart';
import '/presentation/notifiers/ui_notifier.dart';

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
      body: IndexedStack(
        key: ValueKey<int>(uiNotifier.indexTabIndex),
        index: uiNotifier.indexTabIndex,
        children: [
          const HomeScreen(),
          Container(),
          Container(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        showPathWayBadge: true,
      ),
    );
  }
}

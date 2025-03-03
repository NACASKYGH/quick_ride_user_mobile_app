import '/utils/extensions.dart';
import './past_rides_screen.dart';
import 'upcoming_rides_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/presentation/notifiers/ui_notifier.dart';
import '/presentation/widget/circular_icon_btn.dart';
import 'package:easy_localization/easy_localization.dart';

class RidesIndexScreen extends StatefulWidget {
  const RidesIndexScreen({super.key});

  @override
  State<RidesIndexScreen> createState() => _RidesIndexScreenState();
}

class _RidesIndexScreenState extends State<RidesIndexScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    UiNotifier uiNotifier = context.watch<UiNotifier>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'index.rides'.tr(),
          style: context.textTheme.headlineSmall,
        ),
        leadingWidth: 50,
        leading: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: CircularIconBtn(
            bgColor: context.scaffoldColor,
            showShadow: false,
            icon: Icon(Icons.close, size: 30),
            onTap: () => uiNotifier.indexTabIndex = 0,
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: context.colors.inverseSurface,
          labelColor: context.textTheme.labelLarge?.color,
          unselectedLabelColor:
              context.textTheme.labelLarge?.color?.withValues(alpha: .6),
          labelStyle: context.textTheme.labelLarge,
          tabs: [
            Tab(text: 'Past'),
            Tab(text: 'Upcoming'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: const [
            PastRidesScreen(),
            UpcomingRidesScreen(),
          ],
        ),
      ),
    );
  }
}

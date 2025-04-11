import 'bookings_screen.dart';
import 'cancelled_screen.dart';
import '/utils/extensions.dart';
import 'package:flutter/material.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: context.scaffoldColor.withValues(alpha: .5),
        scrolledUnderElevation: 0,
        elevation: 0,
        bottom: TabBar(
          controller: tabController,
          tabs: [Tab(text: 'Bookings'), Tab(text: 'Cancellations')],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [const BookingsScreen(), const CancelledScreen()],
      ),
    );
  }
}

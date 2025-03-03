import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import '../../widget/upcoming_ride_item.dart';

class UpcomingRidesScreen extends StatefulWidget {
  const UpcomingRidesScreen({super.key});

  @override
  State<UpcomingRidesScreen> createState() => _UpcomingRidesScreenState();
}

class _UpcomingRidesScreenState extends State<UpcomingRidesScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 6,
      separatorBuilder: (context, index) => const Gap(16),
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (context, index) {
        return UpcomingRideItem();
      },
    );
  }
}

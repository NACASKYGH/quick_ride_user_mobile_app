import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import '../../widget/past_ride_item.dart';

class PastRidesScreen extends StatefulWidget {
  const PastRidesScreen({super.key});

  @override
  State<PastRidesScreen> createState() => _PastRidesScreenState();
}

class _PastRidesScreenState extends State<PastRidesScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 6,
      separatorBuilder: (context, index) => const Gap(16),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
      itemBuilder: (context, index) {
        return PastRideItem();
      },
    );
  }
}

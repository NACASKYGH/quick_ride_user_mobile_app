import '/utils/extensions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key, required this.safeArea});

  final SafeArea safeArea;

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/svg/background-overlay.svg',
            width: context.width,
            fit: BoxFit.cover,
          ),
          widget.safeArea,
        ],
      ),
    );
  }
}

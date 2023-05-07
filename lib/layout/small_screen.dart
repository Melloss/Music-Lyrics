import 'package:flutter/material.dart';
import 'package:music_website/layout/mainLayout.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        constraints: const BoxConstraints.expand(),
        child: const MainLayout());
  }
}

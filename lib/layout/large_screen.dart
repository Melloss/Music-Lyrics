import 'package:flutter/material.dart';
import 'package:music_website/layout/mainLayout.dart';
import 'package:music_website/layout/side_bar.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.purple, Colors.blue]),
              ),
              child: const SideBar()),
        ),
        const Expanded(flex: 3, child: MainLayout()),
      ],
    );
  }
}

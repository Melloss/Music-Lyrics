import 'package:flutter/material.dart';
import 'package:music_website/layout/layout.dart';

import '../layout/side_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static bool isSmallScreen(BuildContext context) {
    if (MediaQuery.of(context).size.width <= 780) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
    return Scaffold(
      key: scaffoldkey,
      appBar: topNavigationBar(context, scaffoldkey),
      body: LayoutBuilder(
        builder: (context, consraints) {
          double width = consraints.maxWidth;
          if (width <= 780) {
            return const SmallScreen();
          } else {
            return const LargeScreen();
          }
        },
      ),
      drawer: Drawer(
        child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.purple, Colors.blue]),
            ),
            child: const SideBar()),
      ),
    );
  }
}

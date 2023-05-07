import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_website/controller/general_controller.dart';
import 'layout.dart';
import '../pages/home.dart';

final controller = Get.put(GeneralController());
AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) {
  return AppBar(
    toolbarHeight: 80,
    backgroundColor: dark,
    leading: !Home.isSmallScreen(context)
        ? Row()
        : IconButton(
            icon: Icon(
              Icons.menu,
              color: light,
              weight: 1000,
            ),
            onPressed: () {
              key.currentState?.openDrawer();
            },
          ),
    elevation: 0,
    title: Row(
      children: [
        Text(
          'Music',
          style: TextStyle(
            color: light,
            fontSize: Home.isSmallScreen(context) ? 20 : 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(child: Container()),
        Text(
          'John Doe',
          style: TextStyle(
            fontSize: Home.isSmallScreen(context) ? 15 : null,
            color: light,
          ),
        ),
        SizedBox(
          width: Home.isSmallScreen(context) ? 13 : 16,
        ),
        Container(
          padding: const EdgeInsets.all(2),
          margin: const EdgeInsets.all(2),
          child: CircleAvatar(
              backgroundColor: light,
              child: Icon(
                Icons.person_outline,
                color: dark,
              )),
        )
      ],
    ),
  );
}

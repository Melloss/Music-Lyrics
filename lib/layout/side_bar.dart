import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_website/controller/general_controller.dart';
import 'package:music_website/layout/style.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final controller = Get.put(GeneralController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 30, bottom: 50),
              child: Icon(
                Icons.library_music,
                color: light,
                size: 60,
              )),
          ListTile(
              onTap: () {
                controller.selectedSideBarMenu.value = 'home';
                setState(() {
                  controller.selectedSideBarMenu =
                      controller.selectedSideBarMenu;
                  controller.isSelected[0] = true;
                  controller.isSelected[1] = false;
                  controller.isSelected[2] = false;
                });
              },
              title: controller.isSelected[0]
                  ? controller.selectedRow('Home', Icons.home)
                  : controller.unselectedRow('Home', Icons.home)),
          ListTile(
              onTap: () {
                controller.selectedSideBarMenu.value = 'favorite';
                setState(() {
                  controller.selectedSideBarMenu =
                      controller.selectedSideBarMenu;
                  controller.isSelected[0] = false;
                  controller.isSelected[1] = true;
                  controller.isSelected[2] = false;
                });
              },
              title: controller.isSelected[1]
                  ? controller.selectedRow('Favorite', Icons.favorite)
                  : controller.unselectedRow('Favorite', Icons.favorite)),
          ListTile(
              onTap: () {
                controller.selectedSideBarMenu.value = 'about';
                setState(() {
                  controller.selectedSideBarMenu =
                      controller.selectedSideBarMenu;

                  controller.isSelected[0] = false;
                  controller.isSelected[1] = false;
                  controller.isSelected[2] = true;
                });
              },
              title: controller.isSelected[2]
                  ? controller.selectedRow('About', Icons.info)
                  : controller.unselectedRow('About', Icons.info)),
        ],
      ),
    );
  }
}

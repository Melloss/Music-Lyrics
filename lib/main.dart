import 'package:flutter/material.dart';
import 'package:music_website/controller/general_controller.dart';
import 'pages/home.dart';
import 'package:get/get.dart';

class MusicWebsite extends StatelessWidget {
  const MusicWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: Home(),
      title: 'Music Website',
    );
  }
}

main() async {
  final controller = Get.put(GeneralController());
  await controller.fetchPosts().catchError((error) {
    //print('Unable to fetch the data check you connection..');
  });
  controller.getFavorites();
  return runApp(const MusicWebsite());
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_website/controller/general_controller.dart';
import 'package:music_website/layout/layout.dart';

import '../pages/home.dart';

class MusicBottomSheet extends StatefulWidget {
  const MusicBottomSheet({super.key});

  @override
  State<MusicBottomSheet> createState() => _MusicBottomSheetState();
}

class _MusicBottomSheetState extends State<MusicBottomSheet> {
  final controller = Get.put(GeneralController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.purple, Colors.blue]),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.title, color: light, size: 30),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  controller.titleController.text,
                  style: TextStyle(
                    fontSize: 20,
                    color: light,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.mic_none, color: light, size: 30),
                const SizedBox(width: 20),
                Text(
                  controller.artistController.text,
                  style: TextStyle(
                    fontSize: 20,
                    color: light,
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Text(
              "Lyrics",
              style: TextStyle(
                fontSize: 20,
                color: light,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView(children: [
              Center(
                child: Text(controller.lyricsController.text,
                    style: TextStyle(
                      fontSize: Home.isSmallScreen(context) ? 17 : 20,
                      color: light,
                    )),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

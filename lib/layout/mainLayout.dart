// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_website/controller/general_controller.dart';
import 'package:music_website/layout/music_bottomSheet.dart';
import 'package:music_website/layout/style.dart';
import 'package:music_website/pages/home.dart';
import 'about_layout.dart';
import 'music_playlist.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => MainLayoutState();
}

class MainLayoutState extends State<MainLayout> {
  Widget _buildBottomSheet(
      BuildContext context, String title, String artist, String lyrics) {
    controller.titleController.text = title;
    controller.artistController.text = artist;
    controller.lyricsController.text = lyrics;
    return const MusicBottomSheet();
  }

  final controller = Get.put(GeneralController());
  Widget _buildEditLayout() {
    return AlertDialog(
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              Music newMusic = Music();
              newMusic.favorite = "false";
              newMusic.id = "${controller.musics.length}";
              newMusic.title = controller.titleController.text;
              newMusic.artist = controller.artistController.text;
              newMusic.lyrics = controller.lyricsController.text;
              controller.musics.add(newMusic);
              controller.post(newMusic, context);
              setState(() {
                controller.musics = controller.musics;
              });
              Navigator.of(context).pop();
            },
            child: const Text('Save')),
      ],
      title: const Center(child: Text('Add Music')),
      content: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller.titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "title",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.artistController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Artist",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                maxLines: 15,
                controller: controller.lyricsController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "lyrics",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildGesture() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        for (int i = 0; i < controller.musics.length; i++)
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  constraints: Home.isSmallScreen(context)
                      ? BoxConstraints.expand(
                          width: (width * 0.85), height: height * 0.95)
                      : BoxConstraints.expand(
                          width: (width * 0.6), height: height * 0.95),
                  enableDrag: true,
                  elevation: 3,
                  context: context,
                  backgroundColor: const Color.fromARGB(0, 199, 127, 127),
                  builder: (BuildContext context) {
                    return _buildBottomSheet(
                        context,
                        controller.musics[i].title.toString(),
                        controller.musics[i].artist.toString(),
                        controller.musics[i].lyrics.toString());
                  });
              //TODo::
            },
            child: MusicPlaylist(
              title: controller.musics[i].title.toString(),
              artist: controller.musics[i].artist.toString(),
              lyrics: controller.musics[i].lyrics.toString(),
              id: i,
            ),
          ),
        Container(
          padding: const EdgeInsets.all(90.0),
          child: ElevatedButton(
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size.square(60))),
              onPressed: () {
                controller.titleController.text = "";
                controller.artistController.text = "";
                controller.lyricsController.text = "";
                showDialog(
                    context: context,
                    builder: (_) {
                      return _buildEditLayout();
                    });
              },
              child: Icon(
                Icons.add,
                color: light,
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Home.isSmallScreen(context)
        ? ListView(
            children: [
              Obx(
                () => Wrap(
                  children: [
                    if (controller.selectedSideBarMenu.value == 'home')
                      Center(child: buildGesture()),
                    if (controller.selectedSideBarMenu.value == 'favorite')
                      Center(child: _buildFavoriteGesture()),
                    if (controller.selectedSideBarMenu.value == 'about')
                      const Center(child: AboutLayout()),
                  ],
                ),
              )
            ],
          )
        : GridView.count(
            crossAxisCount: 1,
            scrollDirection: Axis.vertical,
            children: [
              Obx(
                () => Wrap(
                  children: [
                    if (controller.selectedSideBarMenu.value == 'home')
                      Center(child: buildGesture()),
                    if (controller.selectedSideBarMenu.value == 'favorite')
                      Center(child: _buildFavoriteGesture()),
                    if (controller.selectedSideBarMenu.value == 'about')
                      const Center(child: AboutLayout()),
                  ],
                ),
              )
            ],
          );
  }

  Widget _buildFavoriteGesture() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Wrap(
      children: [
        for (int i = 0; i < controller.favorites.length; i++)
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  isDismissible: true,
                  constraints: Home.isSmallScreen(context)
                      ? BoxConstraints.expand(
                          width: (width * 0.85), height: height * 0.95)
                      : BoxConstraints.expand(
                          width: (width * 0.6), height: height * 0.95),
                  enableDrag: true,
                  elevation: 3,
                  context: context,
                  backgroundColor: const Color.fromARGB(0, 199, 127, 127),
                  builder: (BuildContext context) {
                    return _buildBottomSheet(
                        context,
                        controller
                            .musics[controller.favorites.elementAt(i)].title
                            .toString(),
                        controller
                            .musics[controller.favorites.elementAt(i)].artist
                            .toString(),
                        controller
                            .musics[controller.favorites.elementAt(i)].lyrics
                            .toString());
                  });
            },
            child: MusicPlaylist(
              title: controller.musics[controller.favorites.elementAt(i)].title
                  .toString(),
              artist: controller
                  .musics[controller.favorites.elementAt(i)].artist
                  .toString(),
              lyrics: controller
                  .musics[controller.favorites.elementAt(i)].lyrics
                  .toString(),
              id: controller.favorites.elementAt(i),
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_website/layout/layout.dart';
import '../controller/general_controller.dart';

class MusicPlaylist extends StatefulWidget {
  final String title;
  final String artist;
  final String lyrics;
  final int id;
  const MusicPlaylist({
    super.key,
    required this.title,
    required this.artist,
    required this.lyrics,
    required this.id,
  });

  @override
  State<MusicPlaylist> createState() => _MusicPlaylistState();
}

class _MusicPlaylistState extends State<MusicPlaylist> {
  final controller = Get.put(GeneralController());
  bool isDeleted = false;
  Widget _buildEditLayout() {
    controller.titleController.text =
        controller.musics[widget.id].title.toString();
    controller.artistController.text =
        controller.musics[widget.id].artist.toString();
    controller.lyricsController.text =
        controller.musics[widget.id].lyrics.toString();
    return isDeleted == true
        ? const SizedBox.shrink()
        : AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Music newMusic = Music();
                    newMusic.id = '${widget.id}';
                    newMusic.title = controller.titleController.text;
                    newMusic.artist = controller.artistController.text;
                    newMusic.lyrics = controller.lyricsController.text;
                    newMusic.favorite =
                        '${controller.musics[widget.id].favorite}';
                    controller.editData(widget.id, newMusic);
                    controller.musics[widget.id].id = newMusic.id;
                    controller.musics[widget.id].title = newMusic.title;
                    controller.musics[widget.id].artist = newMusic.artist;
                    controller.musics[widget.id].lyrics = newMusic.lyrics;
                    controller.musics[widget.id].favorite = newMusic.favorite;
                    setState(() {
                      controller.musics[widget.id] =
                          controller.musics[widget.id];
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save')),
            ],
            title: const Center(child: Text('Music Editing')),
            content: Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      focusNode: FocusNode(),
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

  @override
  Widget build(BuildContext context) {
    return isDeleted == true
        ? const SizedBox.shrink()
        : Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [dark, dark.withOpacity(.8)]),
                color: dark,
                borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(25),
            child: Column(
              children: [
                const SizedBox(
                  width: 200,
                  height: 100,
                  child: Icon(
                    Icons.queue_music,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      controller.musics[widget.id].title.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <IconButton>[
                    IconButton(
                        onPressed: () async {
                          if (controller.musics[widget.id].favorite == "true") {
                            controller.musics[widget.id].favorite = "false";
                            setState(() {
                              controller.musics[widget.id].favorite =
                                  controller.musics[widget.id].favorite;
                            });
                            await controller
                                .editData(
                                    widget.id, controller.musics[widget.id])
                                .catchError((error) {
                              controller.musics[widget.id].favorite = "false";
                              setState(() {
                                controller.musics[widget.id].favorite =
                                    controller.musics[widget.id].favorite;
                              });
                            });
                            controller.favorites.remove(widget.id);
                            setState(() {
                              controller.favorites = controller.favorites;
                            });
                          } else {
                            controller.musics[widget.id].favorite = "true";
                            setState(() {
                              controller.musics[widget.id].favorite =
                                  controller.musics[widget.id].favorite;
                            });
                            await controller
                                .editData(
                                    widget.id, controller.musics[widget.id])
                                .catchError((error) {
                              controller.musics[widget.id].favorite = "false";

                              setState(() {
                                controller.musics[widget.id].favorite =
                                    controller.musics[widget.id].favorite;
                              });
                            });
                            controller.favorites.add(widget.id);
                          }
                          //controller.getFavorites();
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: controller.musics[widget.id].favorite == "true"
                              ? Colors.blue
                              : Colors.white,
                        )),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return _buildEditLayout();
                              });
                        },
                        icon: const Icon(Icons.edit, color: Colors.white)),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: ((context) => _deleteConformation()));
                        },
                        icon: Icon(
                          Icons.delete,
                          color: light,
                        )),
                  ],
                ),
              ],
            ),
          );
  }

  Widget _deleteConformation() {
    return AlertDialog(
      title: const Center(child: Text('Deleting...')),
      content: const Text('Are you sure?'),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
            onPressed: () async {
              await controller
                  .deleteData(widget.id, context)
                  .catchError((error) {
                //print('something is wrong $error');
              });

              setState(() {
                controller.musics = [...controller.musics];
                isDeleted = true;
              });
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
              ),
            )),
      ],
    );
  }
}

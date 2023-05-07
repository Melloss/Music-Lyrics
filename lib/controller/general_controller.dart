import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:music_website/layout/layout.dart';

class Music {
  String? id;
  String? title;
  String? artist;
  String? lyrics;
  String? favorite;

  Music({this.id, this.title, this.artist, this.lyrics, this.favorite});

  Music.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    artist = json['artist'];
    lyrics = json['lyrics'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['artist'] = artist;
    data['lyrics'] = lyrics;
    data['favorite'] = favorite;
    return data;
  }
}

class GeneralController extends GetxController {
  Widget selectedRow(String name, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 25,
          color: Colors.blue,
        ),
        const SizedBox(width: 10),
        Text(
          name,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  var isSelected = [true, false, false];
  Widget unselectedRow(String name, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
        const SizedBox(width: 20),
        Text(name, style: const TextStyle(color: Colors.white, fontSize: 20)),
      ],
    );
  }

  Set<int> favorites = {};

  void getFavorites() {
    for (int i = 0; i < musics.length; i++) {
      if (musics[i].favorite == 'true') {
        favorites.add(i);
      }
    }
  }

  var titleController = TextEditingController();
  var artistController = TextEditingController();
  var lyricsController = TextEditingController();
  final url = 'https://melloss-music-api.onrender.com/Music';
  List<Music> musics = [];

  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var map in jsonData) {
        var music = Music.fromJson(map);
        musics.add(music);
      }
    } else {
      //print('Failed to fetch data. Error code: ${response.statusCode}');
    }
  }

  Future<void> post(Music music, BuildContext context) async {
    final response = await http.post(Uri.parse(url), body: music.toJson());
    if (response.statusCode == 201 || response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      displayMessage("${music.title} music is Creaated Sucessfully!", context);
      //print(response.body);
    } else {
      //print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> editData(int id, Music music) async {
    final response = await http.put(
      Uri.parse("$url/$id"),
      body: music.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      //print('Object updated successfully!');
    } else {
      //print('Failed to update object. Error code: ${response.statusCode}');
    }
  }

  Future<void> deleteData(int id, BuildContext context) async {
    var response = await http.delete(Uri.parse('$url/$id'));
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      displayMessage("${musics[id].title} is Deleted", context);
      musics.removeAt(id);

      // print('Data is deleted');
    } else {
      //print("Unable to delete ${response.statusCode}");
    }
  }

  RxString selectedSideBarMenu = 'home'.obs;

  void displayMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.blue,
        action: SnackBarAction(
          label: 'Ok',
          textColor: Colors.white,
          disabledTextColor: light,
          onPressed: () {},
        ),
      ),
    );
  }
}

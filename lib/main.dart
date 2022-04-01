import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:online_music/GetData/get_data.dart';
import 'package:online_music/View/new_music.dart';
import 'package:online_music/components/custom_list_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MusicApp(),
    );
  }
}

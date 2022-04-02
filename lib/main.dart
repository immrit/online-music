import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'GetData/get_data.dart';
import 'View/new_music.dart';
import 'components/custom_list_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VistaMusic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MusicApp(),
    );
  }
}

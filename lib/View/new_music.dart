import 'dart:io';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../GetData/Remote_Service.dart';

import '../GetData/Post.dart';
import '../components/custom_list_tile.dart';

class MusicApp extends StatefulWidget {
  const MusicApp({Key? key}) : super(key: key);

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  late Future<Post> posts;
  @override
  void initState() {
    super.initState();
    posts = fetchPost();
  }

  String CurrentTitle = "";
  String CurrentCover = "";
  String CurrentSinger = "";
  IconData btnIcon = Icons.play_arrow;
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isplaying = false;
  String CurrentSong = "";
  Duration duration = const Duration();
  Duration posation = const Duration();

  void playMusic(String url) async {
    if (isplaying && CurrentSong != url) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          CurrentSong == url;
        });
      }
    } else if (!isplaying) {
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          isplaying = true;
        });
      }
    }
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        posation = event;
      });
    });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    audioPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.white,
          title: const Text(
            "VistaMusic",
          ),
        ),
        body: Center(
          child: FutureBuilder<Post>(
              future: posts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.data.length,
                            itemBuilder: (context, index) {
                              final post = snapshot.data!.data[index];

                              return Custom_List_tile(
                                  title: post.title,
                                  singer: post.artist,
                                  cover: post.cover,
                                  ontap: () {
                                    playMusic(post.file);
                                    // Platform.script;
                                    setState(() {
                                      CurrentTitle = post.title;
                                      CurrentCover = post.cover;
                                      CurrentSinger = post.artist;
                                      btnIcon = Icons.pause;
                                      isplaying = true;
                                    });
                                  });
                            }),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                            boxShadow: [BoxShadow(color: Color(0x55212121))]),
                        child: Column(
                          children: [
                            // Slider.adaptive(
                            //     value: posation.inSeconds.toDouble(),
                            //     min: 0.0,
                            //     max: duration.inSeconds.toDouble(),
                            //     onChanged: (double value) {
                            //       setState(() {
                            //         seekToSecond(value.toInt());
                            //         value = value;
                            //       });
                            //     }),
                            ProgressBar(
                              progress: posation,
                              buffered: duration,
                              total: Duration(seconds: duration.inSeconds),
                              thumbColor: Colors.red,
                              baseBarColor: Colors.white,
                              progressBarColor: Colors.red,
                              onSeek: (duration) {
                                print('User selected a new time: $duration');
                                setState(() {
                                  seekToSecond(duration.inSeconds);
                                  duration = duration;
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, left: 12.0, right: 12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 80.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        image: DecorationImage(
                                            image: NetworkImage(CurrentCover))),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(CurrentTitle,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                        const SizedBox(height: 5.0),
                                        Text(CurrentSinger,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (isplaying) {
                                        audioPlayer.pause();
                                        setState(() {
                                          btnIcon = Icons.play_arrow;
                                          isplaying = false;
                                        });
                                      } else {
                                        audioPlayer.resume();
                                        setState(() {
                                          btnIcon = Icons.pause;
                                          isplaying = true;
                                        });
                                      }
                                    },
                                    icon: Icon(btnIcon),
                                    iconSize: 42.0,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }),
        ));
  }
}

class DurationState {
  const DurationState(
      {required this.progress, required this.buffered, required this.total});
  final Duration progress;
  final Duration buffered;
  final Duration total;
}

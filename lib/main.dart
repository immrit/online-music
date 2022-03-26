import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:online_music/GetData/get_data.dart';
import 'package:online_music/components/custom_list_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: GetDataClass(),
    );
  }
}

class MusicApp extends StatefulWidget {
  const MusicApp({Key key}) : super(key: key);

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  List<dynamic> musicList = [
    {
      "title": "Eshgh Faghat To",
      "artist": "Ahmad Saeedi",
      "url":
          "https://cdnmrtehran.ir/media/mp3s/ahmad_saeedi/ahmad_saeedi_eshgh_faghat_to.mp3",
      "cover":
          "https://cdnmrtehran.ir/media/mp3s/ahmad_saeedi/ahmad_saeedi_eshgh_faghat_to_thumb.jpg"
    },
    {
      "title": "Eshghe Bi Zaval",
      "artist": "Reza Yazdani",
      "url":
          "https://cdnmrtehran.ir/media/mp3s/reza_yazdani/reza_yazdani_eshghe_bi_zaval.mp3",
      "cover":
          "https://cdnmrtehran.ir/media/mp3s/reza_yazdani/reza_yazdani_eshghe_bi_zaval_thumb.jpg"
    },
    {
      "title": "Kahkeshan",
      "artist": "Reza Abbasi",
      "url":
          "https://cdnmrtehran.ir/media/mp3s/reza_abbasi/reza_abbasi_kahkeshan.mp3",
      "cover":
          "https://cdnmrtehran.ir/media/mp3s/reza_abbasi/reza_abbasi_kahkeshan_thumb.jpg"
    }
  ];

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
          "Online Music",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: musicList.length,
                itemBuilder: (context, index) {
                  final post = musicList[index];

                  return Custom_List_tile(
                      title: post['title'],
                      singer: musicList[index]['artist'],
                      cover: musicList[index]['cover'],
                      ontap: () {
                        playMusic(musicList[index]['url']);

                        setState(() {
                          CurrentTitle = musicList[index]['title'];
                          CurrentCover = musicList[index]['cover'];
                          CurrentSinger = musicList[index]['artist'];
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
                Slider.adaptive(
                    value: posation.inSeconds.toDouble(),
                    min: 0.0,
                    max: duration.inSeconds.toDouble(),
                    onChanged: (double value) {
                      setState(() {
                        seekToSecond(value.toInt());
                        value = value;
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8.0, left: 12.0, right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 80.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            image: DecorationImage(
                                image: NetworkImage(CurrentCover))),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(CurrentTitle,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 5.0),
                            Text(CurrentSinger,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14)),
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
      ),
    );
  }
}

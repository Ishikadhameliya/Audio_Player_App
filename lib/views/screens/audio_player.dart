import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../res/globals.dart';

class audio extends StatefulWidget {
  const audio({Key? key}) : super(key: key);

  @override
  State<audio> createState() => _audioState();
}

new_song({required bool play}) {
  assetsAudioPlayer.open(
    Audio(
      "${Globals.all_songs[Globals.init_value]['song']}",
      metas: Metas(
        title: "${Globals.all_songs[Globals.init_value]["name  "]}",
        artist: "Unknown",
        image: const MetasImage.asset(
          "assets/images/1.png",
        ),
      ),
    ),
    showNotification: true,
    autoStart: play,
    headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
  );
}

bool stop = false;

class _audioState extends State<audio> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    assetsAudioPlayer.stop();
    new_song(play: true);
  }

  @override
  Widget build(BuildContext context) {
    double _heigth = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: const Text("AUDIO"),
          centerTitle: true,
          backgroundColor: Colors.red),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 80),
            Image.asset("${Globals.all_songs[Globals.init_value]['image']}",
                width: _width * 0.4),
            const SizedBox(height: 50),
            Text(
              "${Globals.all_songs[Globals.init_value]['name']}",
              style: const TextStyle(fontSize: 25, color: Colors.red),
            ),
            const SizedBox(height: 30),
            StreamBuilder(
                stream: assetsAudioPlayer.currentPosition,
                builder: (context, snapshort) {
                  Globals.totalsecond = assetsAudioPlayer
                      .current.value!.audio.duration
                      .toString()
                      .split(".")[0];
                  Duration? data = snapshort.data as Duration?;
                  Globals.totalsecond = assetsAudioPlayer
                      .current.value!.audio.duration
                      .toString()
                      .split(".")[0];
                  return Column(
                    children: [
                      Text(
                        "${data.toString().split(".")[0]} / ${Globals.totalsecond}",
                        style: const TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                      Slider(
                        activeColor: Colors.red,
                        thumbColor: Colors.red,
                        min: 0,
                        max: (assetsAudioPlayer.current.hasValue)
                            ? assetsAudioPlayer
                                .current.value!.audio.duration.inSeconds
                                .toDouble()
                            : 0,
                        value: data!.inSeconds.toDouble(),
                        onChanged: (val) {
                          assetsAudioPlayer
                              .seek(Duration(seconds: val.toInt()));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              const SizedBox(width: 35),
                              IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        if (Globals.init_value > 0) {
                                          Globals.init_value--;
                                        } else {
                                          Globals.init_value = 0;
                                        }
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.arrow_back_ios_new,
                                      size: 40)),
                              const SizedBox(width: 60),
                              IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        stop = !stop;
                                        if (stop == true) {
                                          assetsAudioPlayer.pause();
                                        } else {
                                          new_song(play: true);
                                        }
                                      },
                                    );
                                  },
                                  icon: (stop == true)
                                      ? const Icon(Icons.play_arrow, size: 40)
                                      : const Icon(Icons.stop, size: 40)),
                              const SizedBox(width: 60),
                              IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        setState(
                                          () {
                                            assetsAudioPlayer.stop();
                                            if (Globals.init_value <
                                                Globals.all_songs.length - 1) {
                                              Globals.init_value++;
                                            } else {
                                              Globals.init_value = 0;
                                            }
                                            new_song(play: true);
                                          },
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      size: 40)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}

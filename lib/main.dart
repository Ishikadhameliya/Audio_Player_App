import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_player_app/res/globals.dart';
import 'package:audio_player_app/views/screens/audio_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Homepage(),
        'audio_player': (context) => const audio(),
      },
    ),
  );
}

final assetsAudioPlayer = AssetsAudioPlayer();

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("AUDIO PLAYER"),
        centerTitle: true,
        backgroundColor: Colors.red.shade600,
      ),
      body: ListView.separated(
        itemCount: Globals.all_songs.length,
        separatorBuilder: (context, i) => const SizedBox(height: 10),
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              setState(() {
                Globals.init_value = i;
                new_song(play: true);
                Globals.totalsecond = assetsAudioPlayer
                    .current.value!.audio.duration
                    .toString()
                    .split(".")[0];
                Navigator.of(context).pushNamed('audio_player');
              });
            },
            child: Container(
              height: height * 0.15,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.red.shade600, borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  const SizedBox(width: 20,),
                  Image.asset(
                    "${Globals.all_songs[i]['image']}",
                    height: height * 0.1,
                    fit: BoxFit.fitHeight,
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    height: height * 0.09,
                    width: 150,
                    child: Text("\n${Globals.all_songs[i]['name']}",
                        style: const TextStyle(fontSize: 18,color: Colors.white),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

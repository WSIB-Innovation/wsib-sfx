import 'dart:io';

import 'package:flutter/material.dart';
// custom sounds
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Sound Effects'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool play = false;
  bool wasPaused = false;
  AudioPlayer player = AudioPlayer();

  void _audioAction() {
    playRemoteSound();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(15),
              child: const Text("Button with play and pause functionality"),
            ),
            ElevatedButton(
              onPressed: () {
                _audioAction();
              },
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: (play == false)
                  ? const Icon(Icons.play_arrow_outlined)
                  : const Icon(Icons.pause_circle_outline),
              ),
              style: ElevatedButton.styleFrom(shape: const CircleBorder()),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: const Text("Button with short sound effect"),
            ),
            ElevatedButton(
              onPressed: () {
                playLocalSound();
              },
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: const Icon(Icons.play_arrow_outlined),
              ),
              style: ElevatedButton.styleFrom(shape: const CircleBorder()),
            ),
          ],
        ),
      ),
    );
  }

  Future<AudioPlayer> playLocalSound() async {
    AudioCache cache = AudioCache();
    return await cache.play("assets_hat.wav");
  }

  void playRemoteSound() async {
    final file = File('${(await getTemporaryDirectory()).path}/music.mp3');
    await file.writeAsBytes(
        (await rootBundle.load('assets/closer.wav')).buffer.asUint8List());
    play = !play;
    if (play == true) {
      print("play");
      if (wasPaused == true) {
        await player.resume();
      } else {
        await player.play(file.path, isLocal: true);
      }
      wasPaused = false;
    } else {
      print("pause");
      wasPaused = true;
      await player.pause();
    }
    setState(() {});
  }
}

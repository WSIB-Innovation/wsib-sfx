import 'dart:io';

import 'package:flutter/material.dart';
// custom sounds
import 'package:audioplayers/audioplayers.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  bool play = false;
  bool wasPaused = false;
  // final filePath = "/Users/ping/projects/wsib-sfx/assets/closer.wav";
  AudioPlayer player = AudioPlayer();

  void _audioAction() {
    playRemoteSound();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _audioAction();
                    setState(() {});
                  },
                  child: (play == true) ? const Icon(Icons.pause_circle_outline)
                  : const Icon(Icons.play_arrow_outlined),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Future<AudioPlayer> playLocalSound() async {
    AudioCache cache = AudioCache();
    if (play != false) {
      play = false;
    }

    return await cache.play("crickets.wav");
  }

  void playRemoteSound() async {
    play = !play;
    if (play == true) {
      print("play");
      if (wasPaused == true) {
        await player.resume();
      } else {
        await player.play("closer.wav", isLocal: true);
      }
      wasPaused = false;
    } else {
      print("pause");
      wasPaused = true;
      await player.pause();
    }
  }
}

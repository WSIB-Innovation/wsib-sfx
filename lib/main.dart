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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    playLocalSound();
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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){},
                  child: const Icon(Icons.play_arrow),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: (){},
                  child: const Icon(Icons.pause),
                ),
              ],
            )
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  // Use AudioCache objects for local sound files
  Future<AudioPlayer> playLocalSound() async {
    AudioCache cache = AudioCache();
    return await cache.play("assets_hat.wav");
  }

  // Use AudioPlayer objects for hosted sound files
  void playRemoteSound() {
    AudioPlayer player = AudioPlayer();
    player.play("https://bit.ly/2CH50TO");
  }
}

# wsib-sounds

## Foreword

This document outlines how to add custom sound effects to a [Flutter project](https://flutter.dev/docs/get-started). Ensure that file formats used are compatible with the desired platforms.

Note: Certain features are not available with Flutter Web.

### Plugins

- [AudioPlayers](https://pub.dev/packages/audioplayers)

---

### Accessing Local Audio

If using local files, create an assets folder in the root of the project and include desired files in [pubspec.yaml](/pubspec.yaml).

The `AudioCache` class avoids delay, and is optimal for adding audio to interactive components such as buttons.

#### AudioCache Usage

Call `play` on an instance of `AudioCache` and specify the asset used:

Example:

```dart
AudioCache cache = AudioCache();
await cache.play('soundfile.wav');
```

#### AudioPlayer Usage

`AudioPlayer` can be used to access local audio. This involves converting audio from the assets folder to a byte array and storing it in a temporary folder.

Example:

```dart
AudioPlayer player = AudioPlayer();
final file = File('${(await getTemporaryDirectory()).path}/sounds.mp3');
await file.writeAsBytes((await rootBundle.load(['assets/soundfile.wav'])).buffer.asUint8List());
await player.play(file.path, isLocal: true);
```

---

### Accessing Hosted Audio

Using `AudioPlayer`, call `play` with the url of the desired file. `isLocal` is false by default.

Example:

```dart
AudioPlayer remotePlayer = AudioPlayer();
remotePlayer.play('https://bit.ly/2CH50TO');
```

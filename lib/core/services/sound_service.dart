import 'package:audioplayers/audioplayers.dart';

class SoundService {
  // private constructor
  SoundService._();

  /// Cached instance of [SoundService]
  static SoundService? _instance;

  /// return an instance of [SoundService]
  static SoundService get instance {
    // set the instance if it's null
    _instance ??= SoundService._();
    // return the instance
    return _instance!;
  }

  final AudioPlayer _player = AudioPlayer(
    // prefix: 'assets/audio/',
  );

  Future<void> loadSounds() async {
    // await _player.load(
    //   'audio_effect.mp3',
    // );
  }

  Future<void> playTapDownSound() async {
    await _player.play(
      AssetSource("audio/audio_effect.mp3"),
      mode: PlayerMode.lowLatency,
    );
  }
}

import 'package:audioplayers/audioplayers.dart';

class SoundService {
  static final SoundService _instance = SoundService._internal();
  final AudioPlayer _player = AudioPlayer();

  SoundService._internal();

  static SoundService get instance => _instance;

  Future<void> init() async {
    await _player.setVolume(0.3);
  }

  Future<void> playSound(String soundPath) async {
    await _player.play(AssetSource(soundPath));
  }
}

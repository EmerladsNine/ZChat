import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

class SoundService {
  static final SoundService _instance = SoundService._internal();
  final AudioPlayer _player = AudioPlayer();

  SoundService._internal();

  static SoundService get instance => _instance;

  Future<void> init() async {
    if(Platform.isAndroid || Platform.isIOS)
    {
        await _player.setAudioContext(
          AudioContext(
            android: AudioContextAndroid(
              isSpeakerphoneOn: false,
              stayAwake: false,
              contentType: AndroidContentType.sonification,
              audioFocus: AndroidAudioFocus.none,
            ),
            iOS: AudioContextIOS(
              category: AVAudioSessionCategory.playAndRecord,
              options: {AVAudioSessionOptions.mixWithOthers},
            ),
          ),
        );
    }
    await _player.setVolume(0.3);
  }

  Future<void> playSound(String soundPath) async {
    await _player.play(AssetSource(soundPath));
  }
}

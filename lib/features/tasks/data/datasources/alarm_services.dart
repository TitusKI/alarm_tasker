import 'package:audioplayers/audioplayers.dart';

class AlarmServices {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAlarmSound() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/alarm.mp3'));
    } catch (e) {
      print("Error playing alarm sound: $e");
    }
  }

  Future<void> stopAlarm() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      print("Error stopping alarm sound: $e");
    }
  }
}

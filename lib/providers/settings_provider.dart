import 'package:flutter/foundation.dart';

class SettingsProvider extends ChangeNotifier {
  bool _audioOnly;
  bool _audioMuted;
  bool _videoMuted;

  SettingsProvider(
      {bool audioOnly = true, bool audioMuted = false, bool videoMuted = false})
      : _audioOnly = audioOnly,
        _audioMuted = audioMuted,
        _videoMuted = videoMuted;

  toggleAudioOnly() {
    _audioOnly = !_audioOnly;
    notifyListeners();
  }

  toggleAudioMuted() {
    _audioMuted = !_audioMuted;
    notifyListeners();
  }

  toggleVideoMuted() {
    _videoMuted = !_videoMuted;
    notifyListeners();
  }
}

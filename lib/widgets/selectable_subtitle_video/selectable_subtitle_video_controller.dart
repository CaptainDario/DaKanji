import 'package:flutter/widgets.dart';



class SelectableSubtitleVideoController with ChangeNotifier{

  /// Is the video currently playing
  bool _isPlaying;
  /// Is the video currently playing
  bool get isPlaying => _isPlaying;
  /// Is the video currently playing
  set isPlaying(bool newValue) {
    _isPlaying = newValue;
    notifyListeners();
  }

  /// Function to play the video
  late Function() play;
  /// Function to pause the video
  late Function() pause;
  /// Function to toggle the current play/pause state
  late Function() togglePlayPause;
  
  /// The current playback rate
  double _playbackRate;
  /// The current playback rate
  double get playbackRate => _playbackRate;
  /// The current playback rate
  set playbackRate(double newValue) {
    _playbackRate = newValue;
    notifyListeners();
  }
  /// Function to set the playback rate
  late Function(double) setPlaybackRate;

  
  /// Is the player muted
  bool _isMuted;
  /// Is the player muted
  bool get isMuted => _isMuted;
  /// Is the player muted
  set isMuted(bool newValue) {
    _isMuted = newValue;
    notifyListeners();
  }
  /// Function to unmute the audio
  late Function() unMute;
  /// Function to mute the audio
  late Function() mute;
  /// Function to toglle the current mute state
  late Function() toggleMute;

  /// By how many seconds the user already seeked at this time
  int _isSeeking = 0;
  /// By how many seconds the user already seeked at this time
  int get isSeeking => _isSeeking;
  /// By how many seconds the user already seeked at this time
  set isSeeking(int newValue) {
    _isSeeking = newValue;
    notifyListeners();
  }

  
  /// Function that seeks in the current video by `n` seconds
  late Function(int n) seekBy;
  


  SelectableSubtitleVideoController({
    required isPlaying,
    required play,
    required pause,

    required playbackRate,
    required setPlaybackRate,
    
    required isMuted,
    required unMute,
    required mute,

    required this.seekBy
  }) :
    _isPlaying = isPlaying,
    _playbackRate = playbackRate,
    _isMuted = isMuted
  {
    // PLAY / PAUSE
    this.pause = () {
      pause();
      this.isPlaying = false;
    };
    this.play = () {
      play();
      this.isPlaying = true;
    };
    togglePlayPause = () {
      this.isPlaying ? this.pause() : this.play();
    };

    // PLAYBACK RATE
    this.setPlaybackRate = (double newPlaybackRate) {
      setPlaybackRate(newPlaybackRate);
      this.playbackRate = newPlaybackRate;
    };

    // MUTE
    this.unMute = () {
      unMute();
      this.isMuted = false;
    };
    this.mute = () {
      mute();
      this.isMuted = true;
    };
    toggleMute = () {
      this.isMuted ? this.unMute() : this.mute();
    };

  }


}
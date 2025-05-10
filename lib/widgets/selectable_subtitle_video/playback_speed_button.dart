// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:da_kanji_mobile/widgets/selectable_subtitle_video/playback_rate.dart';
import 'package:da_kanji_mobile/widgets/selectable_subtitle_video/selectable_subtitle_video_controller.dart';
import 'package:flutter/material.dart';



/// A widget to display playback speed changing button.
class PlaybackSpeedButton extends StatefulWidget {

  /// Creates [PlaybackSpeedButton] widget.
  const PlaybackSpeedButton({
    super.key,
    required this.controller,
    this.icon,
  });

  /// Overrides the default [YoutubePlayerController].
  final SelectableSubtitleVideoController controller;

  /// Defines icon for the button.
  final Widget? icon;

  @override
  State<PlaybackSpeedButton> createState() => _PlaybackSpeedButtonState();
}

class _PlaybackSpeedButtonState extends State<PlaybackSpeedButton> {


  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<double>(
      onSelected: widget.controller.setPlaybackRate,
      tooltip: 'PlayBack Rate',
      itemBuilder: (context) => [
        _popUpItem('2.0x', PlaybackRate.twice),
        _popUpItem('1.75x', PlaybackRate.oneAndAThreeQuarter),
        _popUpItem('1.5x', PlaybackRate.oneAndAHalf),
        _popUpItem('1.25x', PlaybackRate.oneAndAQuarter),
        _popUpItem('Normal', PlaybackRate.normal),
        _popUpItem('0.75x', PlaybackRate.threeQuarter),
        _popUpItem('0.5x', PlaybackRate.half),
        _popUpItem('0.25x', PlaybackRate.quarter),
      ],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: widget.icon ??
          Image.asset(
            'assets/speedometer.webp',
            package: 'youtube_player_flutter',
            width: 20.0,
            height: 20.0,
            color: Colors.white,
          ),
      ),
    );
  }

  PopupMenuEntry<double> _popUpItem(String text, double rate) {
    return CheckedPopupMenuItem(
      checked: widget.controller.playbackRate == rate,
      value: rate,
      child: Text(text),
    );
  }
}

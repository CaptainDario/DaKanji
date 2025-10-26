// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:file_picker/file_picker.dart';

// Project imports:
import 'package:da_kanji_mobile/widgets/video/video_player.dart';

class VideoLibrary extends StatefulWidget {
  const VideoLibrary({super.key});

  @override
  State<VideoLibrary> createState() => _VideoLibraryState();
}

class _VideoLibraryState extends State<VideoLibrary> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () async {

          // Let the user pick a video
          FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.video);
          if(result == null || result.files.isEmpty) return;
          File videoFile = File(result.files.first.path!);

          // Let the user pick a subs file
          result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ["srt", "vtt"]);
          if(result == null || result.files.isEmpty) return;
          File subsFile = File(result.files.first.path!);

          Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return Scaffold(
                body: VideoPlayer(videoFile, subsFile));
            },));
        },
        icon: const Icon(Icons.add)
      ),
    );
  }
}

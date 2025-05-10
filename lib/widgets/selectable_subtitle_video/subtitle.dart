import 'package:youtube_caption_scraper/youtube_caption_scraper.dart' as ytc;



/// Hold information about a single subtitle line.
class SubtitleLine {
  SubtitleLine({
    required this.start,
    required this.duration,
    required this.text,
  });

  factory SubtitleLine.fromYoutubeCaptions(ytc.SubtitleLine line) {
    return SubtitleLine(
      start: line.start,
      duration: line.duration,
      text: line.text,
    );
  }

  final Duration start;
  final Duration duration;
  final String text;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubtitleLine &&
        other.start == start &&
        other.duration == duration &&
        other.text == text;
  }

  @override
  int get hashCode => start.hashCode ^ duration.hashCode ^ text.hashCode;

  @override
  String toString() =>
      'SubtitleLine(start: $start, duration: $duration, text: $text)';
}

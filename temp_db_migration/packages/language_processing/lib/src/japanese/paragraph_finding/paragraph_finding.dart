import 'package:language_processing/src/japanese/japanese_string_operations.dart';
import 'package:language_processing/src/text_segment.dart';



List<TextSegment> findParagraphs(String text) {
  final List<TextSegment> paragraphs = [];
  final matches = paragraphRegex.allMatches(text);
  
  for (var match in matches) {
    final content = match.group(0) ?? '';
    if (content.trim().isNotEmpty) {
      paragraphs.add(TextSegment(content, match.start, match.end));
    }
  }
  return paragraphs;
}
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';



int extractNumber(File file) {
  final fileName = p.basename(file.path);
  // Assumes a pattern like "..._1.json", "..._2.json", etc.
  final match = RegExp(r'_(\d+)\.json$').firstMatch(fileName);
  return int.parse(match!.group(1)!);
}
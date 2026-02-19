import 'package:dakanji_db_core/parsing/staging_db/staging_db.dart';
import 'package:language_processing/language_processing.dart';



abstract class YomitanFileParser {
  /// Returns true if this parser logic applies to the given filename.
  bool canHandle(String fileName);

  /// Processes the full JSON content of a file and writes directly to the DB.
  ///
  /// [jsonContent]: The full decoded JSON list from the file.
  /// [db]: The database to write to.
  /// [lp]: Language processor (nullable).
  /// [options]: Normalization options.
  /// [startId]: The starting ID for this batch (for generating unique IDs).
  /// Returns the last used ID after processing, to be used as the next startId.
  Future<int> parseFileContent(
    List<dynamic> jsonContent,
    StagingDatabase db,
    LanguageProcessor? lp,
    ProcessorOptions options,
    int startId,
  );
}
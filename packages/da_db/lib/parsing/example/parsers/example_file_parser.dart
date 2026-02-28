import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:language_processing/language_processing.dart';

abstract class ExampleFileParser<T> {
  bool canHandle(String fileName);

  /// Processes the raw file bytes and writes directly to the DB.
  Future<int> parseFileContent(
    T fileBytes,
    StagingDatabase db,
    LanguageProcessor? lp,
    ProcessorOptions options,
    int startId,
  );
}
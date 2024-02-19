// These imports are necessary to open the sqlite3 database

// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

/// opens a SQLite database given by a [File]
LazyDatabase openSqlite(File databaseFile) {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(databaseFile);
  });
}

// stores preferences as strings
class ListIntConverter extends TypeConverter<List<int>, String> {
  const ListIntConverter();

  @override
  List<int> fromSql(String fromDb) {
    return List<int>.from(jsonDecode(fromDb));
  }

  @override
  String toSql(List<int> value) {
    return jsonEncode(value);
  }
}

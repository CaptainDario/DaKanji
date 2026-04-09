import 'dart:convert';

import 'package:da_db/database/index/index_table_entry.dart';
import 'package:dio/dio.dart';



/// if the given dictionary has update information, check if there are updates
/// available.
/// Returns true if updates are available, false otherwise.
Future<bool> checkIfDictionaryHasUpdates(IndexEntry entry) async {

  // all necessary fields must NOT be null
  if (entry.indexUrl == null || entry.isUpdatable == null || entry.downloadUrl == null) {
    return false;
  }

  // the dict itself must define that it is updatable
  if (!entry.isUpdatable!) return false;

  Dio d = Dio();

  // fetch the latest index data from the url the dict provides
  final latest = await d.get(entry.indexUrl!);
  final latestJson = jsonDecode(latest.data);

  // check if the revision is newer than the current one
  if (latestJson['revision'] != null) {
    String latestRevision = latestJson['revision'];
    return entry.compareRevision(latestRevision);
  }


  return false;

}
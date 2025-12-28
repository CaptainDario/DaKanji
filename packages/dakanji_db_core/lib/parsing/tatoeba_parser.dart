import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:archive/archive_io.dart';
import 'package:dakanji_db_core/parsing/util/parsing_util.dart';
import 'package:disjoint_set/disjoint_set.dart';
import 'package:language_processing/iso/iso_table.dart'; 



/// Converts the Tatoeba files from the input directory to the DaKanji DB
/// example sentence format by parsing the `sentences.csv` and `links.csv` files
/// in the `input_directory`
Future<void> convertTatoebaDataSource(
  File inputLinks,
  File inputSentences,
  File outputZipFile,
  {
    Set<Iso639_3>? langsToInclude,
  }
) async {

  if(langsToInclude != null) langsToInclude.add(Iso639_3.jpn);
  List<String>? stringLangsToInclude = langsToInclude?.map((e) => e.name).toList();

  final List<Set<int>> linkedSentences =
    await Isolate.run(() async => await loadLinks(inputLinks));
  final Map<int, ({String lang, String sentence})> sentences =
    await Isolate.run(() async => await loadSentences(inputSentences));

  // Zip to store converted sentences
  var encoder = ZipFileEncoder()..create(outputZipFile.path);

  // add index file
  encoder.addArchiveFile(ArchiveFile.string(
    "yomitan_index.json", getTatoebaIndexString()));

  int i = 0;
  for (var linkedSentence in linkedSentences.sublist(1, 100)) {

    // get all examples from this group
    List<({String lang, String sentence})> sentenceGroup = linkedSentence
      .map((id) => sentences[id]).nonNulls
      .where((e) =>
        stringLangsToInclude == null ||
        stringLangsToInclude.contains(e.lang))
      .toList();

    print(sentenceGroup);

    // filter out groups that do not contain Japanese examples
    if (sentenceGroup.every((sentence) => sentence.lang != Iso639_3.jpn.name)) continue;
    i++;

    encoder.addArchiveFile(ArchiveFile.string(
      "$i.json", 
      jsonEncode(
        { for (var record in sentenceGroup) record.lang : record.sentence }
      )
    ));
  }
  encoder.close();
}

/// Returns the Tatoeba index file as a JSON string
String getTatoebaIndexString(){

  DateTime now = DateTime.now();
  
  return jsonEncode({
    "title": "Tatoeba Example Sentences",
    "revision": "Tatoeba.${now.year}-${now.month}-${now.day}",
    "description": "Example created from the Tatoeba project.",
  });

}

/// Creates a DisjointSet from tatoeba's `links.csv` and returns all sentence groups.
Future<List<Set<int>>> loadLinks(File linksArchiveFile) async {

  final linksStream = getStringStreamFromTarBz2File(linksArchiveFile);

  DisjointSet<int> links = DisjointSet();

  await for (var line in linksStream) {
    var columns = line.split('\t');
    if (columns.length == 2) {
      var id1 = int.tryParse(columns[0])!;
      var id2 = int.tryParse(columns[1])!;

      links.makeSet(id1);
      links.makeSet(id2);
      links.union(id1, id2);
    }
  }

  return links.getAllSets();

}

/// Loads all example sentences from tatoeba's `sentences.csv`
Future<Map<int, ({String lang, String sentence})>> loadSentences(File sentencesArchiveFile) async {

  final sentencesLineStream = getStringStreamFromTarBz2File(sentencesArchiveFile);

  Map<int, ({String lang, String sentence})> sentences = {};

  await for (var line in sentencesLineStream) {
    var columns = line.split('\t');
    if (columns.length == 3) {
      var id = int.tryParse(columns[0])!;
      var lang = columns[1];
      var text = columns[2];
      sentences[id] = (lang: lang, sentence: text);
    }
  }

  return sentences;

}
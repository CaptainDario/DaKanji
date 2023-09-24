import 'package:isar/isar.dart';

part 'dojg_entry.g.dart';



/// One entry of the DoJG anki deck
/// 
/// rebuild *.g.dart by
/// `flutter pub run build_runner build --delete-conflicting-outputs`
@collection
class DojgEntry {
  /// The id of this entry
  Id id = Isar.autoIncrement;
  
  @Index()
  String grammaticalConcept;
  String? usage;
  String? equivalent;
  String? pos;
  String? relatedExpression;
  String? antonymExpression;

  String? formation;

  String volume;
  String volumeTag;
  String volumeJp;
  int page;

  String cloze;

  List<String> keySentencesJp;
  List<String> keySentencesEn;

  List<String> examplesJp;
  List<String> examplesEn;

  /// The actualt note in string form
  String? note;
  /// name of the image with notes for this entry
  String? noteImageName;


  DojgEntry({
    required this.grammaticalConcept,
    required this.usage,
    required this.equivalent,
    required this.pos,
    required this.relatedExpression,
    required this.antonymExpression,

    required this.formation,

    required this.volume,
    required this.volumeTag,
    required this.volumeJp,
    required this.page,

    required this.cloze,

    required this.keySentencesJp,
    required this.keySentencesEn,

    required this.examplesJp,
    required this.examplesEn,

    required this.note,
    required this.noteImageName
  });
}
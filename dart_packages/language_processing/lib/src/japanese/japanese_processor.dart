import 'package:language_processing/language_processing.dart';
import 'package:language_processing/src/japanese/japanese_string_operations.dart';
import 'package:language_processing/src/japanese/normalize/normalize.dart' as jp_norm;
import 'package:language_processing/src/japanese/parse/parse.dart' as jp_parse;
import 'package:language_processing/src/japanese/pronouncation/pronounciation.dart' as jp_pron;
import 'package:language_processing/src/japanese/sentence_finding/sentence_finding_scan.dart' as jp_sent_scan;
import 'package:language_processing/src/japanese/spellfix/forbidden_sequences.dart';
import 'package:language_processing/src/japanese/spellfix/spellfix.dart' as jp_spell;
import 'package:language_processing/src/japanese/spellfix/substitutions.dart';
import 'package:language_processing/src/japanese/term_reading_pair/furigana_matching.dart';
import 'package:language_processing/src/japanese/yomitan_deconjugation/deconjugate.dart' as jp_dec;
import 'package:language_processing/src/parse_result.dart';
import 'package:language_processing/src/text_segment.dart';
import 'package:mecab_for_dart/mecab_dart.dart';



class JapaneseProcessor extends LanguageProcessor{

  @override
  Iso639_3 languageCode = Iso639_3.jpn;

  /// State from which a new mecab instance can be created
  /// Note: if this is set to null some methods will throw an exception
  MecabTransferableState? mecabTransferableState;
    
  Mecab? _mecab;

  jp_dec.JapaneseWordAnalyzer deconjugator = jp_dec.JapaneseWordAnalyzer();

  Mecab get mecab {
    if (!_initialized || _mecab == null) {
      throw StateError("Mecab is not initialized. Call init() first.");
    }
    return _mecab!;
  }

  bool _initialized = false;
  
  JapaneseProcessor({
    this.mecabTransferableState
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'languageCode': languageCode.name,
      'transferableMecab': _mecab?.transferableState.toJson() ?? mecabTransferableState?.toJson(),
    };
  }

  JapaneseProcessor.fromJson(Map<String, dynamic> json) {
    languageCode = Iso639_3.values.firstWhere((e) => e.name == json['languageCode']);
    if (json['transferableMecab'] != null) {
      mecabTransferableState = MecabTransferableState.fromJson(json['transferableMecab']);
    }
  }

  @override
  Future<void> init() async {
    if(mecabTransferableState != null){
      _mecab = await Mecab.fromTransferableState(mecabTransferableState!);
    }
    _initialized = true;
  }

  @override
  Future<void> close() async {
    if (_mecab != null) _mecab!.dispose();

    _initialized = false;
  }

  @override
  String parseYomitanPitch(dynamic input)
    => jp_pron.parseYomitanPitch(input);
  
  /// Normalizes a term by:
  /// 1. Converting full-width Romaji to half-width.
  /// 2. Converting half-width Kana to full-width.
  /// 3. Converting Katakana to Hiragana.
  /// 4. Optionally converting Romaji to Hiragana.
  /// 
  /// Options:
  /// - convertRomajiToHiragana: bool (default: false)
  /// 
  /// Returns: List of normalized terms (usually just one, but can be
  ///          multiple if there are multiple valid normalizations)
  @override
  List<String> normalize(String term, ProcessorOptions options) {

    return jp_norm.normalize(
      term,
      convertRomajiToHiragana: options.japaneseOptions.normalizationConvertsRomajiToHiragana
    );
  }

  @override
  List<String> normalizeAll(List<String> terms, ProcessorOptions options) {

    return jp_norm.normalizeAll(
      terms,
      convertRomajiToHiragana: options.japaneseOptions.normalizationConvertsRomajiToHiragana
    );
  }

  @override
  Set<DeconjugationResult> deconjugate(String term) 
    => deconjugator.processSingle(term);

  @override
  List<Set<DeconjugationResult>> deconjugateAll(List<String> terms)
    => deconjugator.processBatch(terms);

  @override
  ParseResult parse(String term, ProcessorOptions options)
    => jp_parse.parse(term, mecab, options);

  @override
  List<String> generateSpellingVariations({
    required String word,
    required int n,
    required int maxCost,
    int substitutionPenalty = 0,
    List<(String, String, int)> rules = spellfixRules,
    List<String> forbiddenSequences = forbiddenSequences,
  }) {
    return jp_spell.generateSpellingVariations(
      word: word,
      n: n,
      maxCost: maxCost,
      substitutionPenalty: substitutionPenalty,
      rules: rules,
      forbiddenSequences: forbiddenSequences
    );
  }

  @override
  bool isIdeographic(String text) => kanjiRegex.hasMatch(text);

  /// Extracts all unique ideographs (e.g., Kanji) from the given list of strings.
  @override
  Set<String> extractIdeographs(List<String> text) {
    final matches = extractKanji(text);
    return matches.toSet();
  }

  @override
  List<TermReadingPair> getTermReadingPairs(
    String term, String reading, ProcessorOptions options) 
      => matchFurigana(
        term, reading,
        convertToKatakana: options.japaneseOptions.getTermReadingPairsConvertToKatakanaForFurigana
      );

  @override
  List<TextSegment> findSentences(String text, ProcessorOptions options) 
    => jp_sent_scan.findSentences(text);


  @override
  List<TextSegment> findParagraphs(String text) => findParagraphs(text);
  

}
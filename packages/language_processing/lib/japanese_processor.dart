import 'package:language_processing/japanese/deconjugation/yomitan_deconjugate.dart' as jp_dec;
import 'package:language_processing/japanese/normalize/normalize.dart' as jp_norm;
import 'package:language_processing/japanese/spellfix/forbidden_sequences.dart';
import 'package:language_processing/japanese/spellfix/spellfix.dart' as jp_spell;
import 'package:language_processing/japanese/spellfix/substitutions.dart';
import 'package:language_processing/language_processor.dart';
import 'package:language_processing/language_processor_options.dart';
import 'package:language_processing/util/deconjugation_result.dart';
import 'package:mecab_for_dart/mecab_dart.dart';



class JapaneseProcessor extends LanguageProcessor{

  /// Optional, path to the mecab library.
  /// Must be provided if `mecab` is not provided to the constructor.
  final String? libMecabPath;
  /// Optional, path to the mecab dictionary.
  /// Must be provided if `mecab` is not provided to the constructor.
  final String? dicMecabPath;
  /// Options for mecab initialization.
  /// Must be provided if `mecab` is not provided to the constructor.
  final bool? mecabIncludeFeatures;

  bool _initialized = false;

  Mecab? _mecab;

  Mecab get mecab {
    if (!_initialized || _mecab == null) {
      throw StateError("Mecab is not initialized. Call init() first.");
    }
    return _mecab!;
  }
  
  JapaneseProcessor({
    this.libMecabPath,
    this.dicMecabPath,
    this.mecabIncludeFeatures,
    Mecab? mecab
  }){
    _mecab = mecab;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'japanese', // <--- CRITICAL: Identifies this class
      'libMecabPath': libMecabPath,
      'dicMecabPath': dicMecabPath,
      'mecabIncludeFeatures': mecabIncludeFeatures,
    };
  }

  JapaneseProcessor.fromJson(Map<String, dynamic> json) :
    libMecabPath = json['libMecabPath'],
    dicMecabPath = json['dicMecabPath'],
    mecabIncludeFeatures = json['mecabIncludeFeatures'];

  @override
  Future<void> init() async {
    if ([libMecabPath, dicMecabPath, mecabIncludeFeatures].nonNulls.length == 3) {
      _mecab = Mecab();
      await _mecab!.init(libMecabPath!, dicMecabPath!, mecabIncludeFeatures!);
    }
    _initialized = true;
  }

  @override
  Future<void> close() async {
    _initialized = false;
    _mecab!.destroy();
  }
  
  /// Normalizes aterm by:
  /// 1. Converting full-width Romaji to half-width.
  /// 2. Converting half-width Kana to full-width.
  /// 3. Converting Katakana to Hiragana.
  /// 4. Optionally converting Romaji to Hiragana.
  /// 
  /// Options:
  /// - convertRomajiToHiragana: bool (default: false)
  @override
  List<String> normalize(String term, ProcessorOptions options) {

    return jp_norm.normalize(
      term,
      convertRomajiToHiragana: options.japaneseNormalizationConvertsRomajiToHiragana
    );
  }

  @override
  List<String> normalizeAll(List<String> terms, ProcessorOptions options) {

    return jp_norm.normalizeAll(
      terms,
      convertRomajiToHiragana: options.japaneseNormalizationConvertsRomajiToHiragana
    );
  }

  @override
  List<DeconjugationResult> deconjugate(String term) {
    return jp_dec.JapaneseDeconjugator().deconjugate(term);
  }

  @override
  List<DeconjugationResult> deconjugateAll(List<String> terms) {

    final Set<DeconjugationResult> results = {};
    final Set<String> exclusions = terms.toSet();
    final deconjugator = jp_dec.JapaneseDeconjugator();

    for (String d in terms) {
      if (d.isEmpty) continue;
      
      results.addAll(
        deconjugator.deconjugate(d)
          .where((e) => !exclusions.contains(e.deconjugatedTerm))
      );
    }

    return results.toList();
  }

  @override
  String? segment(String text) {
    if (text.isEmpty) return null;

    List<String> tokens = mecab.parse(text).map((e) => e.surface).toList();
    
    if (tokens.isNotEmpty) tokens = tokens.sublist(0, tokens.length - 1);
    
    String joinedTokens = tokens.join(" ");
    return joinedTokens == text ? null : joinedTokens;
  }

  @override
  String getReadings(String sentence) {

    List<TokenNode> parsed = mecab.parse(sentence);
    String tokenized = "";
    for (int i = 0; i < parsed.length; i++) {
      if(parsed[i].features.isEmpty) continue;

      tokenized += "${parsed[i].features[10]} ";
    }

    return tokenized;

  }

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
}
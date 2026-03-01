import 'package:language_processing/src/japanese/difficulty/difficulty_estimation_methods.dart';
import 'package:language_processing/src/japanese/sentence_finding/sentence_finding_methods.dart';

class ProcessorOptions {

  final JapaneseProcessorOptions japaneseOptions;

  const ProcessorOptions({
    this.japaneseOptions = const JapaneseProcessorOptions(),
  });

}

class JapaneseProcessorOptions {
  
  final bool normalizationConvertsRomajiToHiragana;
  
  final bool getTermReadingPairsConvertToKatakanaForFurigana;

  final SentenceFindingMethods sentenceFindingMethod;

  final DifficultyEstimationMethods difficultyEstimationMethod;


  const JapaneseProcessorOptions({
    this.normalizationConvertsRomajiToHiragana = false,
    this.getTermReadingPairsConvertToKatakanaForFurigana = false,
    this.sentenceFindingMethod = SentenceFindingMethods.scan,
    this.difficultyEstimationMethod = DifficultyEstimationMethods.obi,
  });
}
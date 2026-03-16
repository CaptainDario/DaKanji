import 'package:language_processing/src/japanese/difficulty/difficulty_estimation_methods.dart';

class ProcessorOptions {

  final JapaneseProcessorOptions japaneseOptions;

  const ProcessorOptions({
    this.japaneseOptions = const JapaneseProcessorOptions(),
  });

}

class JapaneseProcessorOptions {
  
  final bool normalizationConvertsRomajiToHiragana;
  
  final bool getTermReadingPairsConvertToKatakanaForFurigana;

  final DifficultyEstimationMethods difficultyEstimationMethod;


  const JapaneseProcessorOptions({
    this.normalizationConvertsRomajiToHiragana = false,
    this.getTermReadingPairsConvertToKatakanaForFurigana = false,
    this.difficultyEstimationMethod = DifficultyEstimationMethods.obi,
  });
}
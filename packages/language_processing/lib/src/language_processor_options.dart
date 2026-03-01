class ProcessorOptions {

  final JapaneseProcessorOptions japaneseOptions;

  const ProcessorOptions({
    this.japaneseOptions = const JapaneseProcessorOptions(),
  });

}

class JapaneseProcessorOptions {
  
  final bool normalizationConvertsRomajiToHiragana;
  
  final bool getTermReadingPairsConvertToKatakanaForFurigana;

  final bool sentenceFindingUseScanMethod;

  final bool sentenceFindingUseRegexMethod;


  const JapaneseProcessorOptions({
    this.normalizationConvertsRomajiToHiragana = false,
    this.getTermReadingPairsConvertToKatakanaForFurigana = false,
    this.sentenceFindingUseScanMethod = false,
    this.sentenceFindingUseRegexMethod = false,
  });
}
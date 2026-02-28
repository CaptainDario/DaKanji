class ProcessorOptions {

  final bool japaneseNormalizationConvertsRomajiToHiragana;

  final bool japaneseGetTermReadingPairsConvertToKatakanaForFurigana;

  final bool japaneseSentenceFindingUseScanMethod;

  final bool japaneseSentenceFindingUseRegexMethod;

  const ProcessorOptions({
    this.japaneseNormalizationConvertsRomajiToHiragana = false,
    this.japaneseGetTermReadingPairsConvertToKatakanaForFurigana = false,
    this.japaneseSentenceFindingUseScanMethod = false,
    this.japaneseSentenceFindingUseRegexMethod = false,
  });

}
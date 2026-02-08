class ProcessorOptions {

  final bool japaneseNormalizationConvertsRomajiToHiragana;

  final bool japaneseGetTermReadingPairsConvertToKatakanaForFurigana;

  const ProcessorOptions({
    this.japaneseNormalizationConvertsRomajiToHiragana = false,
    this.japaneseGetTermReadingPairsConvertToKatakanaForFurigana = false,
  });

}
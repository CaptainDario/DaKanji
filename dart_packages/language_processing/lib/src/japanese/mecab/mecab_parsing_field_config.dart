import 'package:language_processing/src/japanese/mecab/unidic_fields.dart';


/// Defines which indices in the MeCab feature array map to specific linguistic concepts.
class MecabParsingFieldConfig {
  
  
  final List<int> posIndices;

  final int surfaceIndex;

  final int surfaceReadingIndex;

  final int baseFormIndex;

  final int baseFormReadingIndex;

  const MecabParsingFieldConfig({
    required this.posIndices,
    required this.surfaceIndex,
    required this.surfaceReadingIndex,
    required this.baseFormIndex,
    required this.baseFormReadingIndex,
  });

  const MecabParsingFieldConfig.unidic()
    : posIndices = const [
        UniDicFields.pos1,
        UniDicFields.pos2,
        UniDicFields.pos3,
        UniDicFields.pos4
      ],
      surfaceIndex = UniDicFields.orth,
      surfaceReadingIndex = UniDicFields.kana,
      baseFormIndex = UniDicFields.orthBase,
      baseFormReadingIndex = UniDicFields.kanaBase;
}
import 'package:language_processing/src/text_segment.dart';

// --- Define the complex text variables here in pieces ---
final _complexP1 = '東京に暮らす男子高校生・瀧は、夢を見ることをきっかけに田舎町の女子高生・三葉と入れ替わるようになる。';
final _complexP2 = '慣れない女子の身体、未知の田舎暮らしに戸惑いつつ、徐々に馴染んでいく瀧。\n身体の持ち主である三葉のことをもっと知りたいと瀧が思い始めたころ、普段と違う三葉を疑問に思った周りの人たちも彼女のことを考え出して――。';
final _complexP3 = '食べられる\n食べられました\n欲しくない\n失礼な\n基本的';
final _complexP4 = '（主に関西）（五段活用・下一段活用・サ行変格活用の動詞の後について）～ない　語源：「～はせぬ」が転じたもの。';
final _complexInput = '$_complexP1\n\n$_complexP2\n\n$_complexP3\n\n$_complexP4';
// -------------------------------------------------------------------------

final paragraphCases = [
  (
    description: 'Splits standard paragraphs separated by double newlines',
    input: 'First.\n\nSecond.',
    expected: [
      TextSegment('First.', 0, 6),
      TextSegment('Second.', 8, 15),
    ],
  ),
  (
    description: 'Ignores empty or whitespace-only chunks between paragraphs',
    input: 'Para 1\n\n   \n\nPara 2',
    expected: [
      TextSegment('Para 1', 0, 6),
      // Note: Adjusted start index from previous snippet to correctly match the string length
      TextSegment('Para 2', 13, 19), 
    ],
  ),
  (
    description: 'Returns an empty list for an empty string',
    input: '',
    expected: <TextSegment>[],
  ),
  // THE NEW COMPLEX JAPANESE CASE ADDED HERE
  (
    description: 'Handles complex Japanese synopsis, single-newline lists, and definitions',
    input: _complexInput,
    expected: [
      TextSegment(_complexP1, _complexInput.indexOf(_complexP1), _complexInput.indexOf(_complexP1) + _complexP1.length),
      TextSegment(_complexP2, _complexInput.indexOf(_complexP2), _complexInput.indexOf(_complexP2) + _complexP2.length),
      TextSegment(_complexP3, _complexInput.indexOf(_complexP3), _complexInput.indexOf(_complexP3) + _complexP3.length),
      TextSegment(_complexP4, _complexInput.indexOf(_complexP4), _complexInput.indexOf(_complexP4) + _complexP4.length),
    ],
  ),
];

final sentenceCases = [
  (
    description: 'Splits correctly on standard sentence enders (。！？)',
    input: 'こんにちは。元気？行こう！',
    expected: [
      TextSegment('こんにちは。', 0, 6),
      TextSegment('元気？', 6, 9),
      TextSegment('行こう！', 9, 13),
    ],
  ),
  (
    description: 'CRITICAL: does NOT split when punctuation is inside brackets',
    input: '彼は「バカな！」と言った。',
    expected: [
      TextSegment('彼は「バカな！」と言った。', 0, 13),
    ],
  ),
  (
    description: 'Captures trailing closing brackets immediately after an ender',
    input: '終わった。」彼は言った。',
    expected: [
      TextSegment('終わった。」', 0, 6),
      TextSegment('彼は言った。', 6, 12),
    ],
  ),
];
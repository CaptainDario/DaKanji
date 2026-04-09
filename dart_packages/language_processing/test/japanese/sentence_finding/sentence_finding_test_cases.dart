
import 'package:language_processing/src/text_segment.dart'; // Update to your actual path

// --- The Complex Japanese Test Data ---
final _complexP1 = '東京に暮らす男子高校生・瀧は、夢を見ることをきっかけに田舎町の女子高生・三葉と入れ替わるようになる。';
final _complexP2 = '慣れない女子の身体、未知の田舎暮らしに戸惑いつつ、徐々に馴染んでいく瀧。\n身体の持ち主である三葉のことをもっと知りたいと瀧が思い始めたころ、普段と違う三葉を疑問に思った周りの人たちも彼女のことを考え出して――。';
final _complexP3 = '食べられる\n食べられました\n欲しくない\n失礼な\n基本的';
final _complexP4 = '（主に関西）（五段活用・下一段活用・サ行変格活用の動詞の後について）～ない　語源：「～はせぬ」が転じたもの。';
final _complexInput = '$_complexP1\n\n$_complexP2\n\n$_complexP3\n\n$_complexP4';

// Breaking down the exact sentences we expect to find in that block:
final _s1 = '東京に暮らす男子高校生・瀧は、夢を見ることをきっかけに田舎町の女子高生・三葉と入れ替わるようになる。';
final _s2 = '慣れない女子の身体、未知の田舎暮らしに戸惑いつつ、徐々に馴染んでいく瀧。';
final _s3 = '身体の持ち主である三葉のことをもっと知りたいと瀧が思い始めたころ、普段と違う三葉を疑問に思った周りの人たちも彼女のことを考え出して――。';
final _s4 = '食べられる';
final _s5 = '食べられました';
final _s6 = '欲しくない';
final _s7 = '失礼な';
final _s8 = '基本的';
final _s9 = '（主に関西）（五段活用・下一段活用・サ行変格活用の動詞の後について）～ない　語源：「～はせぬ」が転じたもの。';
// --------------------------------------

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
  (
    description: 'Safely captures leftover text without final punctuation',
    input: '最後の一文',
    expected: [
      TextSegment('最後の一文', 0, 5),
    ],
  ),
  // YOUR COMPLEX PARAGRAPH APPLIED TO SENTENCES
  (
    description: 'Handles complex Japanese synopsis, newlines as enders, and nested brackets',
    input: _complexInput,
    expected: [
      TextSegment(_s1, _complexInput.indexOf(_s1), _complexInput.indexOf(_s1) + _s1.length),
      TextSegment(_s2, _complexInput.indexOf(_s2), _complexInput.indexOf(_s2) + _s2.length),
      TextSegment(_s3, _complexInput.indexOf(_s3), _complexInput.indexOf(_s3) + _s3.length),
      TextSegment(_s4, _complexInput.indexOf(_s4), _complexInput.indexOf(_s4) + _s4.length),
      TextSegment(_s5, _complexInput.indexOf(_s5), _complexInput.indexOf(_s5) + _s5.length),
      TextSegment(_s6, _complexInput.indexOf(_s6), _complexInput.indexOf(_s6) + _s6.length),
      TextSegment(_s7, _complexInput.indexOf(_s7), _complexInput.indexOf(_s7) + _s7.length),
      TextSegment(_s8, _complexInput.indexOf(_s8), _complexInput.indexOf(_s8) + _s8.length),
      TextSegment(_s9, _complexInput.indexOf(_s9), _complexInput.indexOf(_s9) + _s9.length),
    ],
  ),
];
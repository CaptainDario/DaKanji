/*
 * Copyright (C) 2024-2025  Yomitan Authors
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'language_transforms.dart';

// Helper classes to structure the transform data
class I18nInfo {
  final String language;
  final String name;
  final String? description;

  const I18nInfo({required this.language, required this.name, this.description});
}

class ConditionInfo {
  final String name;
  final List<I18nInfo> i18n;
  final bool isDictionaryForm;
  final List<String>? subConditions;

  const ConditionInfo({
    required this.name,
    this.i18n = const [],
    required this.isDictionaryForm,
    this.subConditions,
  });
}

class Transform {
  final String name;
  final String description;
  final List<I18nInfo> i18n;
  final List<Rule<String>> rules;

  const Transform({
    required this.name,
    required this.description,
    this.i18n = const [],
    required this.rules,
  });
}

class LanguageTransformDescriptor {
  final String language;
  final Map<String, ConditionInfo> conditions;
  final Map<String, Transform> transforms;

  const LanguageTransformDescriptor({
    required this.language,
    required this.conditions,
    required this.transforms,
  });
}

// Constants and helper functions from the JS file
const shimauEnglishDescription = '''
1. Shows a sense of regret/surprise when you did have volition in doing something, but it turned out to be bad to do.
2. Shows perfective/punctual achievement. This shows that an action has been completed.
3. Shows unintentional action–“accidentally”.''';

const passiveEnglishDescription = '''
1. Indicates an action received from an action performer.
2. Expresses respect for the subject of action performer.''';

const ikuVerbs = ['いく', '行く', '逝く', '往く'];
const godanUSpecialVerbs = [
  'こう',
  'とう',
  '請う',
  '乞う',
  '恋う',
  '問う',
  '訪う',
  '宣う',
  '曰う',
  '給う',
  '賜う',
  '揺蕩う'
];
const fuVerbTeConjugations = [
  ['のたまう', 'のたもう'],
  ['たまう', 'たもう'],
  ['たゆたう', 'たゆとう'],
];

List<SuffixRule<String>> irregularVerbSuffixInflections(
    String suffix, List<String> conditionsIn, List<String> conditionsOut) {
  final inflections = <SuffixRule<String>>[];
  for (final verb in ikuVerbs) {
    inflections.add(suffixInflection(
        '${verb[0]}っ$suffix', verb, conditionsIn, conditionsOut));
  }
  for (final verb in godanUSpecialVerbs) {
    inflections.add(
        suffixInflection('$verb$suffix', verb, conditionsIn, conditionsOut));
  }
  for (final conjugation in fuVerbTeConjugations) {
    final verb = conjugation[0];
    final teRoot = conjugation[1];
    inflections.add(
        suffixInflection('$teRoot$suffix', verb, conditionsIn, conditionsOut));
  }
  return inflections;
}

// Main data structure translated to Dart
final japaneseTransforms = LanguageTransformDescriptor(
  language: 'ja',
  conditions: {
    'v': ConditionInfo(
      name: 'Verb',
      i18n: [
        I18nInfo(language: 'ja', name: '動詞'),
      ],
      isDictionaryForm: false,
      subConditions: ['v1', 'v5', 'vk', 'vs', 'vz'],
    ),
    'v1': ConditionInfo(
      name: 'Ichidan verb',
      i18n: [
        I18nInfo(language: 'ja', name: '一段動詞'),
      ],
      isDictionaryForm: true,
      subConditions: ['v1d', 'v1p'],
    ),
    'v1d': ConditionInfo(
      name: 'Ichidan verb, dictionary form',
      i18n: [
        I18nInfo(language: 'ja', name: '一段動詞、終止形'),
      ],
      isDictionaryForm: false,
    ),
    'v1p': ConditionInfo(
      name: 'Ichidan verb, progressive or perfect form',
      i18n: [
        I18nInfo(language: 'ja', name: '一段動詞、～てる・でる'),
      ],
      isDictionaryForm: false,
    ),
    'v5': ConditionInfo(
      name: 'Godan verb',
      i18n: [
        I18nInfo(language: 'ja', name: '五段動詞'),
      ],
      isDictionaryForm: true,
      subConditions: ['v5d', 'v5s'],
    ),
    'v5d': ConditionInfo(
      name: 'Godan verb, dictionary form',
      i18n: [
        I18nInfo(language: 'ja', name: '五段動詞、終止形'),
      ],
      isDictionaryForm: false,
    ),
    'v5s': ConditionInfo(
      name: 'Godan verb, short causative form',
      i18n: [
        I18nInfo(language: 'ja', name: '五段動詞、～す・さす'),
      ],
      isDictionaryForm: false,
      subConditions: ['v5ss', 'v5sp'],
    ),
    'v5ss': ConditionInfo(
      name:
          'Godan verb, short causative form having さす ending (cannot conjugate with passive form)',
      i18n: [
        I18nInfo(language: 'ja', name: '五段動詞、～さす'),
      ],
      isDictionaryForm: false,
    ),
    'v5sp': ConditionInfo(
      name:
          'Godan verb, short causative form not having さす ending (can conjugate with passive form)',
      i18n: [
        I18nInfo(language: 'ja', name: '五段動詞、～す'),
      ],
      isDictionaryForm: false,
    ),
    'vk': ConditionInfo(
      name: 'Kuru verb',
      i18n: [
        I18nInfo(language: 'ja', name: '来る動詞'),
      ],
      isDictionaryForm: true,
    ),
    'vs': ConditionInfo(
      name: 'Suru verb',
      i18n: [
        I18nInfo(language: 'ja', name: 'する動詞'),
      ],
      isDictionaryForm: true,
    ),
    'vz': ConditionInfo(
      name: 'Zuru verb',
      i18n: [
        I18nInfo(language: 'ja', name: 'ずる動詞'),
      ],
      isDictionaryForm: true,
    ),
    'adj-i': ConditionInfo(
      name: 'Adjective with i ending',
      i18n: [
        I18nInfo(language: 'ja', name: '形容詞'),
      ],
      isDictionaryForm: true,
    ),
    '-ます': ConditionInfo(
      name: 'Polite -ます ending',
      isDictionaryForm: false,
    ),
    '-ません': ConditionInfo(
      name: 'Polite negative -ません ending',
      isDictionaryForm: false,
    ),
    '-て': ConditionInfo(
      name: 'Intermediate -て endings for progressive or perfect tense',
      isDictionaryForm: false,
    ),
    '-ば': ConditionInfo(
      name: 'Intermediate -ば endings for conditional contraction',
      isDictionaryForm: false,
    ),
    '-く': ConditionInfo(
      name: 'Intermediate -く endings for adverbs',
      isDictionaryForm: false,
    ),
    '-た': ConditionInfo(
      name: '-た form ending',
      isDictionaryForm: false,
    ),
    '-ん': ConditionInfo(
      name: '-ん negative ending',
      isDictionaryForm: false,
    ),
    '-なさい': ConditionInfo(
      name: 'Intermediate -なさい ending (polite imperative)',
      isDictionaryForm: false,
    ),
    '-ゃ': ConditionInfo(
      name: 'Intermediate -や ending (conditional contraction)',
      isDictionaryForm: false,
    ),
  },
  transforms: {
    '-ば': Transform(
      name: '-ば',
      description:
          '''1. Conditional form; shows that the previous stated condition's establishment is the condition for the latter stated condition to occur.
2. Shows a trigger for a latter stated perception or judgment.
Usage: Attach ば to the hypothetical form (仮定形) of verbs and i-adjectives.''',
      i18n: [
        I18nInfo(language: 'ja', name: '～ば'),
      ],
      rules: [
        suffixInflection('ければ', 'い', ['-ば'], ['adj-i']),
        suffixInflection('えば', 'う', ['-ば'], ['v5']),
        suffixInflection('けば', 'く', ['-ば'], ['v5']),
        suffixInflection('げば', 'ぐ', ['-ば'], ['v5']),
        suffixInflection('せば', 'す', ['-ば'], ['v5']),
        suffixInflection('てば', 'つ', ['-ば'], ['v5']),
        suffixInflection('ねば', 'ぬ', ['-ば'], ['v5']),
        suffixInflection('べば', 'ぶ', ['-ば'], ['v5']),
        suffixInflection('めば', 'む', ['-ば'], ['v5']),
        suffixInflection('れば', 'る', ['-ば'], ['v1', 'v5', 'vk', 'vs', 'vz']),
        suffixInflection('れば', '', ['-ば'], ['-ます']),
      ],
    ),
    '-ゃ': Transform(
      name: '-ゃ',
      description: 'Contraction of -ば.',
      i18n: [
        I18nInfo(language: 'ja', name: '～ゃ', description: '「～ば」の短縮'),
      ],
      rules: [
        suffixInflection('けりゃ', 'ければ', ['-ゃ'], ['-ば']),
        suffixInflection('きゃ', 'ければ', ['-ゃ'], ['-ば']),
        suffixInflection('や', 'えば', ['-ゃ'], ['-ば']),
        suffixInflection('きゃ', 'けば', ['-ゃ'], ['-ば']),
        suffixInflection('ぎゃ', 'げば', ['-ゃ'], ['-ば']),
        suffixInflection('しゃ', 'せば', ['-ゃ'], ['-ば']),
        suffixInflection('ちゃ', 'てば', ['-ゃ'], ['-ば']),
        suffixInflection('にゃ', 'ねば', ['-ゃ'], ['-ば']),
        suffixInflection('びゃ', 'べば', ['-ゃ'], ['-ば']),
        suffixInflection('みゃ', 'めば', ['-ゃ'], ['-ば']),
        suffixInflection('りゃ', 'れば', ['-ゃ'], ['-ば']),
      ],
    ),
    '-ちゃ': Transform(
      name: '-ちゃ',
      description: '''Contraction of ～ては.
1. Explains how something always happens under the condition that it marks.
2. Expresses the repetition (of a series of) actions.
3. Indicates a hypothetical situation in which the speaker gives a (negative) evaluation about the other party's intentions.
4. Used in "Must Not" patterns like ～てはいけない.
Usage: Attach は after the て-form of verbs, contract ては into ちゃ.''',
      i18n: [
        I18nInfo(language: 'ja', name: '～ちゃ', description: '「～ては」の短縮'),
      ],
      rules: [
        suffixInflection('ちゃ', 'る', ['v5'], ['v1']),
        suffixInflection('いじゃ', 'ぐ', ['v5'], ['v5']),
        suffixInflection('いちゃ', 'く', ['v5'], ['v5']),
        suffixInflection('しちゃ', 'す', ['v5'], ['v5']),
        suffixInflection('っちゃ', 'う', ['v5'], ['v5']),
        suffixInflection('っちゃ', 'く', ['v5'], ['v5']),
        suffixInflection('っちゃ', 'つ', ['v5'], ['v5']),
        suffixInflection('っちゃ', 'る', ['v5'], ['v5']),
        suffixInflection('んじゃ', 'ぬ', ['v5'], ['v5']),
        suffixInflection('んじゃ', 'ぶ', ['v5'], ['v5']),
        suffixInflection('んじゃ', 'む', ['v5'], ['v5']),
        suffixInflection('じちゃ', 'ずる', ['v5'], ['vz']),
        suffixInflection('しちゃ', 'する', ['v5'], ['vs']),
        suffixInflection('為ちゃ', '為る', ['v5'], ['vs']),
        suffixInflection('きちゃ', 'くる', ['v5'], ['vk']),
        suffixInflection('来ちゃ', '来る', ['v5'], ['vk']),
        suffixInflection('來ちゃ', '來る', ['v5'], ['vk']),
      ],
    ),
    '-ちゃう': Transform(
      name: '-ちゃう',
      description: '''Contraction of -しまう.
$shimauEnglishDescription
Usage: Attach しまう after the て-form of verbs, contract てしまう into ちゃう.''',
      i18n: [
        I18nInfo(
            language: 'ja',
            name: '～ちゃう',
            description: '「～てしまう」のややくだけた口頭語的表現'),
      ],
      rules: [
        suffixInflection('ちゃう', 'る', ['v5'], ['v1']),
        suffixInflection('いじゃう', 'ぐ', ['v5'], ['v5']),
        suffixInflection('いちゃう', 'く', ['v5'], ['v5']),
        suffixInflection('しちゃう', 'す', ['v5'], ['v5']),
        suffixInflection('っちゃう', 'う', ['v5'], ['v5']),
        suffixInflection('っちゃう', 'く', ['v5'], ['v5']),
        suffixInflection('っちゃう', 'つ', ['v5'], ['v5']),
        suffixInflection('っちゃう', 'る', ['v5'], ['v5']),
        suffixInflection('んじゃう', 'ぬ', ['v5'], ['v5']),
        suffixInflection('んじゃう', 'ぶ', ['v5'], ['v5']),
        suffixInflection('んじゃう', 'む', ['v5'], ['v5']),
        suffixInflection('じちゃう', 'ずる', ['v5'], ['vz']),
        suffixInflection('しちゃう', 'する', ['v5'], ['vs']),
        suffixInflection('為ちゃう', '為る', ['v5'], ['vs']),
        suffixInflection('きちゃう', 'くる', ['v5'], ['vk']),
        suffixInflection('来ちゃう', '来る', ['v5'], ['vk']),
        suffixInflection('來ちゃう', '來る', ['v5'], ['vk']),
      ],
    ),
    '-ちまう': Transform(
      name: '-ちまう',
      description: '''Contraction of -しまう.
$shimauEnglishDescription
Usage: Attach しまう after the て-form of verbs, contract てしまう into ちまう.''',
      i18n: [
        I18nInfo(language: 'ja', name: '～ちまう', description: '「～てしまう」の音変化'),
      ],
      rules: [
        suffixInflection('ちまう', 'る', ['v5'], ['v1']),
        suffixInflection('いじまう', 'ぐ', ['v5'], ['v5']),
        suffixInflection('いちまう', 'く', ['v5'], ['v5']),
        suffixInflection('しちまう', 'す', ['v5'], ['v5']),
        suffixInflection('っちまう', 'う', ['v5'], ['v5']),
        suffixInflection('っちまう', 'く', ['v5'], ['v5']),
        suffixInflection('っちまう', 'つ', ['v5'], ['v5']),
        suffixInflection('っちまう', 'る', ['v5'], ['v5']),
        suffixInflection('んじまう', 'ぬ', ['v5'], ['v5']),
        suffixInflection('んじまう', 'ぶ', ['v5'], ['v5']),
        suffixInflection('んじまう', 'む', ['v5'], ['v5']),
        suffixInflection('じちまう', 'ずる', ['v5'], ['vz']),
        suffixInflection('しちまう', 'する', ['v5'], ['vs']),
        suffixInflection('為ちまう', '為る', ['v5'], ['vs']),
        suffixInflection('きちまう', 'くる', ['v5'], ['vk']),
        suffixInflection('来ちまう', '来る', ['v5'], ['vk']),
        suffixInflection('來ちまう', '來る', ['v5'], ['vk']),
      ],
    ),
    '-しまう': Transform(
      name: '-しまう',
      description: '''$shimauEnglishDescription
Usage: Attach しまう after the て-form of verbs.''',
      i18n: [
        I18nInfo(
            language: 'ja',
            name: '～しまう',
            description:
                'その動作がすっかり終わる、その状態が完成することを表す。終わったことを強調したり、不本意である、困ったことになった、などの気持ちを添えたりすることもある。'),
      ],
      rules: [
        suffixInflection('てしまう', 'て', ['v5'], ['-て']),
        suffixInflection('でしまう', 'で', ['v5'], ['-て']),
      ],
    ),
    '-なさい': Transform(
      name: '-なさい',
      description: '''Polite imperative suffix.
Usage: Attach なさい after the continuative form (連用形) of verbs.''',
      i18n: [
        I18nInfo(language: 'ja', name: '～なさい', description: '動詞「なさる」の命令形'),
      ],
      rules: [
        suffixInflection('なさい', 'る', ['-なさい'], ['v1']),
        suffixInflection('いなさい', 'う', ['-なさい'], ['v5']),
        suffixInflection('きなさい', 'く', ['-なさい'], ['v5']),
        suffixInflection('ぎなさい', 'ぐ', ['-なさい'], ['v5']),
        suffixInflection('しなさい', 'す', ['-なさい'], ['v5']),
        suffixInflection('ちなさい', 'つ', ['-なさい'], ['v5']),
        suffixInflection('になさい', 'ぬ', ['-なさい'], ['v5']),
        suffixInflection('びなさい', 'ぶ', ['-なさい'], ['v5']),
        suffixInflection('みなさい', 'む', ['-なさい'], ['v5']),
        suffixInflection('りなさい', 'る', ['-なさい'], ['v5']),
        suffixInflection('じなさい', 'ずる', ['-なさい'], ['vz']),
        suffixInflection('しなさい', 'する', ['-なさい'], ['vs']),
        suffixInflection('為なさい', '為る', ['-なさい'], ['vs']),
        suffixInflection('きなさい', 'くる', ['-なさい'], ['vk']),
        suffixInflection('来なさい', '来る', ['-なさい'], ['vk']),
        suffixInflection('來なさい', '來る', ['-なさい'], ['vk']),
      ],
    ),
    '-そう': Transform(
      name: '-そう',
      description: '''Appearing that; looking like.
Usage: Attach そう to the continuative form (連用形) of verbs, or to the stem of adjectives.''',
      i18n: [
        I18nInfo(
            language: 'ja',
            name: '～そう',
            description: 'そういう様子だ、そうなる様子だということ、すなわち様態を表す助動詞。'),
      ],
      rules: [
        suffixInflection('そう', 'い', [], ['adj-i']),
        suffixInflection('そう', 'る', [], ['v1']),
        suffixInflection('いそう', 'う', [], ['v5']),
        suffixInflection('きそう', 'く', [], ['v5']),
        suffixInflection('ぎそう', 'ぐ', [], ['v5']),
        suffixInflection('しそう', 'す', [], ['v5']),
        suffixInflection('ちそう', 'つ', [], ['v5']),
        suffixInflection('にそう', 'ぬ', [], ['v5']),
        suffixInflection('びそう', 'ぶ', [], ['v5']),
        suffixInflection('みそう', 'む', [], ['v5']),
        suffixInflection('りそう', 'る', [], ['v5']),
        suffixInflection('じそう', 'ずる', [], ['vz']),
        suffixInflection('しそう', 'する', [], ['vs']),
        suffixInflection('為そう', '為る', [], ['vs']),
        suffixInflection('きそう', 'くる', [], ['vk']),
        suffixInflection('来そう', '来る', [], ['vk']),
        suffixInflection('來そう', '來る', [], ['vk']),
      ],
    ),
    '-すぎる': Transform(
      name: '-すぎる',
      description:
          '''Shows something "is too..." or someone is doing something "too much".
Usage: Attach すぎる to the continuative form (連用形) of verbs, or to the stem of adjectives.''',
      i18n: [
        I18nInfo(language: 'ja', name: '～すぎる', description: '程度や限度を超える'),
      ],
      rules: [
        suffixInflection('すぎる', 'い', ['v1'], ['adj-i']),
        suffixInflection('すぎる', 'る', ['v1'], ['v1']),
        suffixInflection('いすぎる', 'う', ['v1'], ['v5']),
        suffixInflection('きすぎる', 'く', ['v1'], ['v5']),
        suffixInflection('ぎすぎる', 'ぐ', ['v1'], ['v5']),
        suffixInflection('しすぎる', 'す', ['v1'], ['v5']),
        suffixInflection('ちすぎる', 'つ', ['v1'], ['v5']),
        suffixInflection('にすぎる', 'ぬ', ['v1'], ['v5']),
        suffixInflection('びすぎる', 'ぶ', ['v1'], ['v5']),
        suffixInflection('みすぎる', 'む', ['v1'], ['v5']),
        suffixInflection('りすぎる', 'る', ['v1'], ['v5']),
        suffixInflection('じすぎる', 'ずる', ['v1'], ['vz']),
        suffixInflection('しすぎる', 'する', ['v1'], ['vs']),
        suffixInflection('為すぎる', '為る', ['v1'], ['vs']),
        suffixInflection('きすぎる', 'くる', ['v1'], ['vk']),
        suffixInflection('来すぎる', '来る', ['v1'], ['vk']),
        suffixInflection('來すぎる', '來る', ['v1'], ['vk']),
      ],
    ),
    '-過ぎる': Transform(
      name: '-過ぎる',
      description:
          '''Shows something "is too..." or someone is doing something "too much".
Usage: Attach 過ぎる to the continuative form (連用形) of verbs, or to the stem of adjectives.''',
      i18n: [
        I18nInfo(language: 'ja', name: '～過ぎる', description: '程度や限度を超える'),
      ],
      rules: [
        suffixInflection('過ぎる', 'い', ['v1'], ['adj-i']),
        suffixInflection('過ぎる', 'る', ['v1'], ['v1']),
        suffixInflection('い過ぎる', 'う', ['v1'], ['v5']),
        suffixInflection('き過ぎる', 'く', ['v1'], ['v5']),
        suffixInflection('ぎ過ぎる', 'ぐ', ['v1'], ['v5']),
        suffixInflection('し過ぎる', 'す', ['v1'], ['v5']),
        suffixInflection('ち過ぎる', 'つ', ['v1'], ['v5']),
        suffixInflection('に過ぎる', 'ぬ', ['v1'], ['v5']),
        suffixInflection('び過ぎる', 'ぶ', ['v1'], ['v5']),
        suffixInflection('み過ぎる', 'む', ['v1'], ['v5']),
        suffixInflection('り過ぎる', 'る', ['v1'], ['v5']),
        suffixInflection('じ過ぎる', 'ずる', ['v1'], ['vz']),
        suffixInflection('し過ぎる', 'する', ['v1'], ['vs']),
        suffixInflection('為過ぎる', '為る', ['v1'], ['vs']),
        suffixInflection('き過ぎる', 'くる', ['v1'], ['vk']),
        suffixInflection('来過ぎる', '来る', ['v1'], ['vk']),
        suffixInflection('來過ぎる', '來る', ['v1'], ['vk']),
      ],
    ),
    '-たい': Transform(
      name: '-たい',
      description:
          '''1. Expresses the feeling of desire or hope.
2. Used in ...たいと思います, an indirect way of saying what the speaker intends to do.
Usage: Attach たい to the continuative form (連用形) of verbs. たい itself conjugates as i-adjective.''',
      i18n: [
        I18nInfo(
            language: 'ja',
            name: '～たい',
            description: 'することをのぞんでいる、という、希望や願望の気持ちをあらわす。'),
      ],
      rules: [
        suffixInflection('たい', 'る', ['adj-i'], ['v1']),
        suffixInflection('いたい', 'う', ['adj-i'], ['v5']),
        suffixInflection('きたい', 'く', ['adj-i'], ['v5']),
        suffixInflection('ぎたい', 'ぐ', ['adj-i'], ['v5']),
        suffixInflection('したい', 'す', ['adj-i'], ['v5']),
        suffixInflection('ちたい', 'つ', ['adj-i'], ['v5']),
        suffixInflection('にたい', 'ぬ', ['adj-i'], ['v5']),
        suffixInflection('びたい', 'ぶ', ['adj-i'], ['v5']),
        suffixInflection('みたい', 'む', ['adj-i'], ['v5']),
        suffixInflection('りたい', 'る', ['adj-i'], ['v5']),
        suffixInflection('じたい', 'ずる', ['adj-i'], ['vz']),
        suffixInflection('したい', 'する', ['adj-i'], ['vs']),
        suffixInflection('為たい', '為る', ['adj-i'], ['vs']),
        suffixInflection('きたい', 'くる', ['adj-i'], ['vk']),
        suffixInflection('来たい', '来る', ['adj-i'], ['vk']),
        suffixInflection('來たい', '來る', ['adj-i'], ['vk']),
      ],
    ),
    '-たら': Transform(
      name: '-たら',
      description:
          '''1. Denotes the latter stated event is a continuation of the previous stated event.
2. Assumes that a matter has been completed or concluded.
Usage: Attach たら to the continuative form (連用形) of verbs after euphonic change form, かったら to the stem of i-adjectives.''',
      i18n: [
        I18nInfo(language: 'ja', name: '～たら', description: '仮定をあらわす・…すると・したあとに'),
      ],
      rules: [
        suffixInflection('かったら', 'い', [], ['adj-i']),
        suffixInflection('たら', 'る', [], ['v1']),
        suffixInflection('いたら', 'く', [], ['v5']),
        suffixInflection('いだら', 'ぐ', [], ['v5']),
        suffixInflection('したら', 'す', [], ['v5']),
        suffixInflection('ったら', 'う', [], ['v5']),
        suffixInflection('ったら', 'つ', [], ['v5']),
        suffixInflection('ったら', 'る', [], ['v5']),
        suffixInflection('んだら', 'ぬ', [], ['v5']),
        suffixInflection('んだら', 'ぶ', [], ['v5']),
        suffixInflection('んだら', 'む', [], ['v5']),
        suffixInflection('じたら', 'ずる', [], ['vz']),
        suffixInflection('したら', 'する', [], ['vs']),
        suffixInflection('為たら', '為る', [], ['vs']),
        suffixInflection('きたら', 'くる', [], ['vk']),
        suffixInflection('来たら', '来る', [], ['vk']),
        suffixInflection('來たら', '來る', [], ['vk']),
        ...irregularVerbSuffixInflections('たら', [], ['v5']),
        suffixInflection('ましたら', 'ます', [], ['-ます']),
      ],
    ),
    '-たり': Transform(
      name: '-たり',
      description:
          '''1. Shows two actions occurring back and forth (when used with two verbs).
2. Shows examples of actions and states (when used with multiple verbs and adjectives).
Usage: Attach たり to the continuative form (連用形) of verbs after euphonic change form, かったり to the stem of i-adjectives''',
      i18n: [
        I18nInfo(language: 'ja', name: '～たり', description: 'ある動作を例示的にあげることを表わす。'),
      ],
      rules: [
        suffixInflection('かったり', 'い', [], ['adj-i']),
        suffixInflection('たり', 'る', [], ['v1']),
        suffixInflection('いたり', 'く', [], ['v5']),
        suffixInflection('いだり', 'ぐ', [], ['v5']),
        suffixInflection('したり', 'す', [], ['v5']),
        suffixInflection('ったり', 'う', [], ['v5']),
        suffixInflection('ったり', 'つ', [], ['v5']),
        suffixInflection('ったり', 'る', [], ['v5']),
        suffixInflection('んだり', 'ぬ', [], ['v5']),
        suffixInflection('んだり', 'ぶ', [], ['v5']),
        suffixInflection('んだり', 'む', [], ['v5']),
        suffixInflection('じたり', 'ずる', [], ['vz']),
        suffixInflection('したり', 'する', [], ['vs']),
        suffixInflection('為たり', '為る', [], ['vs']),
        suffixInflection('きたり', 'くる', [], ['vk']),
        suffixInflection('来たり', '来る', [], ['vk']),
        suffixInflection('來たり', '來る', [], ['vk']),
        ...irregularVerbSuffixInflections('たり', [], ['v5']),
      ],
    ),
    '-て': Transform(
      name: '-て',
      description: '''て-form.
It has a myriad of meanings. Primarily, it is a conjunctive particle that connects two clauses together.
Usage: Attach て to the continuative form (連用形) of verbs after euphonic change form, くて to the stem of i-adjectives.''',
      i18n: [
        I18nInfo(language: 'ja', name: '～て'),
      ],
      rules: [
        suffixInflection('くて', 'い', ['-て'], ['adj-i']),
        suffixInflection('て', 'る', ['-て'], ['v1']),
        suffixInflection('いて', 'く', ['-て'], ['v5']),
        suffixInflection('いで', 'ぐ', ['-て'], ['v5']),
        suffixInflection('して', 'す', ['-て'], ['v5']),
        suffixInflection('って', 'う', ['-て'], ['v5']),
        suffixInflection('って', 'つ', ['-て'], ['v5']),
        suffixInflection('って', 'る', ['-て'], ['v5']),
        suffixInflection('んで', 'ぬ', ['-て'], ['v5']),
        suffixInflection('んで', 'ぶ', ['-て'], ['v5']),
        suffixInflection('んで', 'む', ['-て'], ['v5']),
        suffixInflection('じて', 'ずる', ['-て'], ['vz']),
        suffixInflection('して', 'する', ['-て'], ['vs']),
        suffixInflection('為て', '為る', ['-て'], ['vs']),
        suffixInflection('きて', 'くる', ['-て'], ['vk']),
        suffixInflection('来て', '来る', ['-て'], ['vk']),
        suffixInflection('來て', '來る', ['-て'], ['vk']),
        ...irregularVerbSuffixInflections('て', ['-て'], ['v5']),
        suffixInflection('まして', 'ます', [], ['-ます']),
      ],
    ),
    '-ず': Transform(
      name: '-ず',
      description: '''1. Negative form of verbs.
2. Continuative form (連用形) of the particle ぬ (nu).
Usage: Attach ず to the irrealis form (未然形) of verbs.''',
      i18n: [
        I18nInfo(language: 'ja', name: '～ず', description: '～ない'),
      ],
      rules: [
        suffixInflection('ず', 'る', [], ['v1']),
        suffixInflection('かず', 'く', [], ['v5']),
        suffixInflection('がず', 'ぐ', [], ['v5']),
        suffixInflection('さず', 'す', [], ['v5']),
        suffixInflection('たず', 'つ', [], ['v5']),
        suffixInflection('なず', 'ぬ', [], ['v5']),
        suffixInflection('ばず', 'ぶ', [], ['v5']),
        suffixInflection('まず', 'む', [], ['v5']),
        suffixInflection('らず', 'る', [], ['v5']),
        suffixInflection('わず', 'う', [], ['v5']),
        suffixInflection('ぜず', 'ずる', [], ['vz']),
        suffixInflection('せず', 'する', [], ['vs']),
        suffixInflection('為ず', '為る', [], ['vs']),
        suffixInflection('こず', 'くる', [], ['vk']),
        suffixInflection('来ず', '来る', [], ['vk']),
        suffixInflection('來ず', '來る', [], ['vk']),
      ],
    ),
    '-ぬ': Transform(
      name: '-ぬ',
      description: '''Negative form of verbs.
Usage: Attach ぬ to the irrealis form (未然形) of verbs.
する becomes せぬ''',
      i18n: [
        I18nInfo(language: 'ja', name: '～ぬ', description: '～ない'),
      ],
      rules: [
        suffixInflection('ぬ', 'る', [], ['v1']),
        suffixInflection('かぬ', 'く', [], ['v5']),
        suffixInflection('がぬ', 'ぐ', [], ['v5']),
        suffixInflection('さぬ', 'す', [], ['v5']),
        suffixInflection('たぬ', 'つ', [], ['v5']),
        suffixInflection('なぬ', 'ぬ', [], ['v5']),
        suffixInflection('ばぬ', 'ぶ', [], ['v5']),
        suffixInflection('まぬ', 'む', [], ['v5']),
        suffixInflection('らぬ', 'る', [], ['v5']),
        suffixInflection('わぬ', 'う', [], ['v5']),
        suffixInflection('ぜぬ', 'ずる', [], ['vz']),
        suffixInflection('せぬ', 'する', [], ['vs']),
        suffixInflection('為ぬ', '為る', [], ['vs']),
        suffixInflection('こぬ', 'くる', [], ['vk']),
        suffixInflection('来ぬ', '来る', [], ['vk']),
        suffixInflection('來ぬ', '來る', [], ['vk']),
      ],
    ),
    '-ん': Transform(
      name: '-ん',
      description: '''Negative form of verbs; a sound change of ぬ.
Usage: Attach ん to the irrealis form (未然形) of verbs.
する becomes せん''',
      i18n: [
        I18nInfo(language: 'ja', name: '～ん', description: '～ない'),
      ],
      rules: [
        suffixInflection('ん', 'る', ['-ん'], ['v1']),
        suffixInflection('かん', 'く', ['-ん'], ['v5']),
        suffixInflection('がん', 'ぐ', ['-ん'], ['v5']),
        suffixInflection('さん', 'す', ['-ん'], ['v5']),
        suffixInflection('たん', 'つ', ['-ん'], ['v5']),
        suffixInflection('なん', 'ぬ', ['-ん'], ['v5']),
        suffixInflection('ばん', 'ぶ', ['-ん'], ['v5']),
        suffixInflection('まん', 'む', ['-ん'], ['v5']),
        suffixInflection('らん', 'る', ['-ん'], ['v5']),
        suffixInflection('わん', 'う', ['-ん'], ['v5']),
        suffixInflection('ぜん', 'ずる', ['-ん'], ['vz']),
        suffixInflection('せん', 'する', ['-ん'], ['vs']),
        suffixInflection('為ん', '為る', ['-ん'], ['vs']),
        suffixInflection('こん', 'くる', ['-ん'], ['vk']),
        suffixInflection('来ん', '来る', ['-ん'], ['vk']),
        suffixInflection('來ん', '來る', ['-ん'], ['vk']),
      ],
    ),
    '-んばかり': Transform(
      name: '-んばかり',
      description:
          '''Shows an action or condition is on the verge of occurring, or an excessive/extreme degree.
Usage: Attach んばかり to the irrealis form (未然形) of verbs.
する becomes せんばかり''',
      i18n: [
        I18nInfo(
            language: 'ja',
            name: '～んばかり',
            description: '今にもそうなりそうな、しかし辛うじてそうなっていないようなさまを指す表現'),
      ],
      rules: [
        suffixInflection('んばかり', 'る', [], ['v1']),
        suffixInflection('かんばかり', 'く', [], ['v5']),
        suffixInflection('がんばかり', 'ぐ', [], ['v5']),
        suffixInflection('さんばかり', 'す', [], ['v5']),
        suffixInflection('たんばかり', 'つ', [], ['v5']),
        suffixInflection('なんばかり', 'ぬ', [], ['v5']),
        suffixInflection('ばんばかり', 'ぶ', [], ['v5']),
        suffixInflection('まんばかり', 'む', [], ['v5']),
        suffixInflection('らんばかり', 'る', [], ['v5']),
        suffixInflection('わんばかり', 'う', [], ['v5']),
        suffixInflection('ぜんばかり', 'ずる', [], ['vz']),
        suffixInflection('せんばかり', 'する', [], ['vs']),
        suffixInflection('為んばかり', '為る', [], ['vs']),
        suffixInflection('こんばかり', 'くる', [], ['vk']),
        suffixInflection('来んばかり', '来る', [], ['vk']),
        suffixInflection('來んばかり', '來る', [], ['vk']),
      ],
    ),
    '-んとする': Transform(
      name: '-んとする',
      description: '''1. Shows the speaker's will or intention.
2. Shows an action or condition is on the verge of occurring.
Usage: Attach んとする to the irrealis form (未然形) of verbs.
する becomes せんとする''',
      i18n: [
        I18nInfo(language: 'ja', name: '～んとする', description: '…しようとする、…しようとしている'),
      ],
      rules: [
        suffixInflection('んとする', 'る', ['vs'], ['v1']),
        suffixInflection('かんとする', 'く', ['vs'], ['v5']),
        suffixInflection('がんとする', 'ぐ', ['vs'], ['v5']),
        suffixInflection('さんとする', 'す', ['vs'], ['v5']),
        suffixInflection('たんとする', 'つ', ['vs'], ['v5']),
        suffixInflection('なんとする', 'ぬ', ['vs'], ['v5']),
        suffixInflection('ばんとする', 'ぶ', ['vs'], ['v5']),
        suffixInflection('まんとする', 'む', ['vs'], ['v5']),
        suffixInflection('らんとする', 'る', ['vs'], ['v5']),
        suffixInflection('わんとする', 'う', ['vs'], ['v5']),
        suffixInflection('ぜんとする', 'ずる', ['vs'], ['vz']),
        suffixInflection('せんとする', 'する', ['vs'], ['vs']),
        suffixInflection('為んとする', '為る', ['vs'], ['vs']),
        suffixInflection('こんとする', 'くる', ['vs'], ['vk']),
        suffixInflection('来んとする', '来る', ['vs'], ['vk']),
        suffixInflection('來んとする', '來る', ['vs'], ['vk']),
      ],
    ),
    '-む': Transform(
      name: '-む',
      description: '''Archaic.
1. Shows an inference of a certain matter.
2. Shows speaker's intention.
Usage: Attach む to the irrealis form (未然形) of verbs.
する becomes せむ''',
      i18n: [
        I18nInfo(language: 'ja', name: '～む', description: '…だろう'),
      ],
      rules: [
        suffixInflection('む', 'る', [], ['v1']),
        suffixInflection('かむ', 'く', [], ['v5']),
        suffixInflection('がむ', 'ぐ', [], ['v5']),
        suffixInflection('さむ', 'す', [], ['v5']),
        suffixInflection('たむ', 'つ', [], ['v5']),
        suffixInflection('なむ', 'ぬ', [], ['v5']),
        suffixInflection('ばむ', 'ぶ', [], ['v5']),
        suffixInflection('まむ', 'む', [], ['v5']),
        suffixInflection('らむ', 'る', [], ['v5']),
        suffixInflection('わむ', 'う', [], ['v5']),
        suffixInflection('ぜむ', 'ずる', [], ['vz']),
        suffixInflection('せむ', 'する', [], ['vs']),
        suffixInflection('為む', '為る', [], ['vs']),
        suffixInflection('こむ', 'くる', [], ['vk']),
        suffixInflection('来む', '来る', [], ['vk']),
        suffixInflection('來む', '來る', [], ['vk']),
      ],
    ),
    '-ざる': Transform(
      name: '-ざる',
      description: '''Negative form of verbs.
Usage: Attach ざる to the irrealis form (未然形) of verbs.
する becomes せざる''',
      i18n: [
        I18nInfo(language: 'ja', name: '～ざる', description: '…ない…'),
      ],
      rules: [
        suffixInflection('ざる', 'る', [], ['v1']),
        suffixInflection('かざる', 'く', [], ['v5']),
        suffixInflection('がざる', 'ぐ', [], ['v5']),
        suffixInflection('さざる', 'す', [], ['v5']),
        suffixInflection('たざる', 'つ', [], ['v5']),
        suffixInflection('なざる', 'ぬ', [], ['v5']),
        suffixInflection('ばざる', 'ぶ', [], ['v5']),
        suffixInflection('まざる', 'む', [], ['v5']),
        suffixInflection('らざる', 'る', [], ['v5']),
        suffixInflection('わざる', 'う', [], ['v5']),
        suffixInflection('ぜざる', 'ずる', [], ['vz']),
        suffixInflection('せざる', 'する', [], ['vs']),
        suffixInflection('為ざる', '為る', [], ['vs']),
        suffixInflection('こざる', 'くる', [], ['vk']),
        suffixInflection('来ざる', '来る', [], ['vk']),
        suffixInflection('來ざる', '來る', [], ['vk']),
      ],
    ),
    '-ねば': Transform(
      name: '-ねば',
      description: '''1. Shows a hypothetical negation; if not ...
2. Shows a must. Used with or without ならぬ.
Usage: Attach ねば to the irrealis form (未然形) of verbs.
する becomes せねば''',
      i18n: [
        I18nInfo(language: 'ja', name: '～ねば', description: 'もし…ないなら。…なければならない。'),
      ],
      rules: [
        suffixInflection('ねば', 'る', ['-ば'], ['v1']),
        suffixInflection('かねば', 'く', ['-ば'], ['v5']),
        suffixInflection('がねば', 'ぐ', ['-ば'], ['v5']),
        suffixInflection('さねば', 'す', ['-ば'], ['v5']),
        suffixInflection('たねば', 'つ', ['-ば'], ['v5']),
        suffixInflection('なねば', 'ぬ', ['-ば'], ['v5']),
        suffixInflection('ばねば', 'ぶ', ['-ば'], ['v5']),
        suffixInflection('まねば', 'む', ['-ば'], ['v5']),
        suffixInflection('らねば', 'る', ['-ば'], ['v5']),
        suffixInflection('わねば', 'う', ['-ば'], ['v5']),
        suffixInflection('ぜねば', 'ずる', ['-ば'], ['vz']),
        suffixInflection('せねば', 'する', ['-ば'], ['vs']),
        suffixInflection('為ねば', '為る', ['-ば'], ['vs']),
        suffixInflection('こねば', 'くる', ['-ば'], ['vk']),
        suffixInflection('来ねば', '来る', ['-ば'], ['vk']),
        suffixInflection('來ねば', '來る', ['-ば'], ['vk']),
      ],
    ),
    '-く': Transform(
      name: '-く',
      description: 'Adverbial form of i-adjectives.\n',
      i18n: [
        I18nInfo(
            language: 'ja',
            name: '～く',
            description: '〔形容詞で〕用言へ続く。例、「大きく育つ」の「大きく」。'),
      ],
      rules: [
        suffixInflection('く', 'い', ['-く'], ['adj-i']),
      ],
    ),
    'causative': Transform(
      name: 'causative',
      description: '''Describes the intention to make someone do something.
Usage: Attach させる to the irrealis form (未然形) of ichidan verbs and くる.
Attach せる to the irrealis form (未然形) of godan verbs and する.
It itself conjugates as an ichidan verb.''',
      i18n: [
        I18nInfo(
            language: 'ja',
            name: '～せる・させる',
            description: 'だれかにある行為をさせる意を表わす時の言い方。例、「行かせる」の「せる」。'),
      ],
      rules: [
        suffixInflection('させる', 'る', ['v1'], ['v1']),
        suffixInflection('かせる', 'く', ['v1'], ['v5']),
        suffixInflection('がせる', 'ぐ', ['v1'], ['v5']),
        suffixInflection('させる', 'す', ['v1'], ['v5']),
        suffixInflection('たせる', 'つ', ['v1'], ['v5']),
        suffixInflection('なせる', 'ぬ', ['v1'], ['v5']),
        suffixInflection('ばせる', 'ぶ', ['v1'], ['v5']),
        suffixInflection('ませる', 'む', ['v1'], ['v5']),
        suffixInflection('らせる', 'る', ['v1'], ['v5']),
        suffixInflection('わせる', 'う', ['v1'], ['v5']),
        suffixInflection('じさせる', 'ずる', ['v1'], ['vz']),
        suffixInflection('ぜさせる', 'ずる', ['v1'], ['vz']),
        suffixInflection('させる', 'する', ['v1'], ['vs']),
        suffixInflection('為せる', '為る', ['v1'], ['vs']),
        suffixInflection('せさせる', 'する', ['v1'], ['vs']),
        suffixInflection('為させる', '為る', ['v1'], ['vs']),
        suffixInflection('こさせる', 'くる', ['v1'], ['vk']),
        suffixInflection('来させる', '来る', ['v1'], ['vk']),
        suffixInflection('來させる', '來る', ['v1'], ['vk']),
      ],
    ),
    'short causative': Transform(
      name: 'short causative',
      description: '''Contraction of the causative form.
Describes the intention to make someone do something.
Usage: Attach す to the irrealis form (未然形) of godan verbs.
Attach さす to the dictionary form (終止形) of ichidan verbs.
する becomes さす, くる becomes こさす.
It itself conjugates as an godan verb.''',
      i18n: [
        I18nInfo(
            language: 'ja',
            name: '～す・さす',
            description: 'だれかにある行為をさせる意を表わす時の言い方。例、「食べさす」の「さす」。'),
      ],
      rules: [
        suffixInflection('さす', 'る', ['v5ss'], ['v1']),
        suffixInflection('かす', 'く', ['v5sp'], ['v5']),
        suffixInflection('がす', 'ぐ', ['v5sp'], ['v5']),
        suffixInflection('さす', 'す', ['v5ss'], ['v5']),
        suffixInflection('たす', 'つ', ['v5sp'], ['v5']),
        suffixInflection('なす', 'ぬ', ['v5sp'], ['v5']),
        suffixInflection('ばす', 'ぶ', ['v5sp'], ['v5']),
        suffixInflection('ます', 'む', ['v5sp'], ['v5']),
        suffixInflection('らす', 'る', ['v5sp'], ['v5']),
        suffixInflection('わす', 'う', ['v5sp'], ['v5']),
        suffixInflection('じさす', 'ずる', ['v5ss'], ['vz']),
        suffixInflection('ぜさす', 'ずる', ['v5ss'], ['vz']),
        suffixInflection('さす', 'する', ['v5ss'], ['vs']),
        suffixInflection('為す', '為る', ['v5ss'], ['vs']),
        suffixInflection('こさす', 'くる', ['v5ss'], ['vk']),
        suffixInflection('来さす', '来る', ['v5ss'], ['vk']),
        suffixInflection('來さす', '來る', ['v5ss'], ['vk']),
      ],
    ),
    'imperative': Transform(
      name: 'imperative',
      description: '''1. To give orders.
2. (As あれ) Represents the fact that it will never change no matter the circumstances.
3. Express a feeling of hope.''',
      i18n: [
        I18nInfo(
            language: 'ja',
            name: '命令形',
            description: '命令の意味を表わすときの形。例、「行け」。'),
      ],
      rules: [
        suffixInflection('ろ', 'る', [], ['v1']),
        suffixInflection('よ', 'る', [], ['v1']),
        suffixInflection('え', 'う', [], ['v5']),
        suffixInflection('け', 'く', [], ['v5']),
        suffixInflection('げ', 'ぐ', [], ['v5']),
        suffixInflection('せ', 'す', [], ['v5']),
        suffixInflection('て', 'つ', [], ['v5']),
        suffixInflection('ね', 'ぬ', [], ['v5']),
        suffixInflection('べ', 'ぶ', [], ['v5']),
        suffixInflection('め', 'む', [], ['v5']),
        suffixInflection('れ', 'る', [], ['v5']),
        suffixInflection('じろ', 'ずる', [], ['vz']),
        suffixInflection('ぜよ', 'ずる', [], ['vz']),
        suffixInflection('しろ', 'する', [], ['vs']),
        suffixInflection('せよ', 'する', [], ['vs']),
        suffixInflection('為ろ', '為る', [], ['vs']),
        suffixInflection('為よ', '為る', [], ['vs']),
        suffixInflection('こい', 'くる', [], ['vk']),
        suffixInflection('来い', '来る', [], ['vk']),
        suffixInflection('來い', '來る', [], ['vk']),
      ],
    ),
    'continuative': Transform(
      name: 'continuative',
      description: '''Used to indicate actions that are (being) carried out.
Refers to 連用形, the part of the verb after conjugating with -ます and dropping ます.''',
      i18n: [
        I18nInfo(
            language: 'ja',
            name: '連用形',
            description: '〔動詞などで〕「ます」などに続く。例、「バスを降りて歩きます」の「降り」「歩き」。'),
      ],
      rules: [
        suffixInflection('い', 'いる', [], ['v1d']),
        suffixInflection('え', 'える', [], ['v1d']),
        suffixInflection('き', 'きる', [], ['v1d']),
        suffixInflection('ぎ', 'ぎる', [], ['v1d']),
        suffixInflection('け', 'ける', [], ['v1d']),
        suffixInflection('げ', 'げる', [], ['v1d']),
        suffixInflection('じ', 'じる', [], ['v1d']),
        suffixInflection('せ', 'せる', [], ['v1d']),
        suffixInflection('ぜ', 'ぜる', [], ['v1d']),
        suffixInflection('ち', 'ちる', [], ['v1d']),
        suffixInflection('て', 'てる', [], ['v1d']),
        suffixInflection('で', 'でる', [], ['v1d']),
        suffixInflection('に', 'にる', [], ['v1d']),
        suffixInflection('ね', 'ねる', [], ['v1d']),
        suffixInflection('ひ', 'ひる', [], ['v1d']),
        suffixInflection('び', 'びる', [], ['v1d']),
        suffixInflection('へ', 'へる', [], ['v1d']),
        suffixInflection('べ', 'べる', [], ['v1d']),
        suffixInflection('み', 'みる', [], ['v1d']),
        suffixInflection('め', 'める', [], ['v1d']),
        suffixInflection('り', 'りる', [], ['v1d']),
        suffixInflection('れ', 'れる', [], ['v1d']),
        suffixInflection('い', 'う', [], ['v5']),
        suffixInflection('き', 'く', [], ['v5']),
        suffixInflection('ぎ', 'ぐ', [], ['v5']),
        suffixInflection('し', 'す', [], ['v5']),
        suffixInflection('ち', 'つ', [], ['v5']),
        suffixInflection('に', 'ぬ', [], ['v5']),
        suffixInflection('び', 'ぶ', [], ['v5']),
        suffixInflection('み', 'む', [], ['v5']),
        suffixInflection('り', 'る', [], ['v5']),
        suffixInflection('き', 'くる', [], ['vk']),
        suffixInflection('し', 'する', [], ['vs']),
        suffixInflection('来', '来る', [], ['vk']),
        suffixInflection('來', '來る', [], ['vk']),
      ],
    ),
    'negative': Transform(
      name: 'negative',
      description:
          '''1. Negative form of verbs.
2. Expresses a feeling of solicitation to the other party.
Usage: Attach ない to the irrealis form (未然形) of verbs, くない to the stem of i-adjectives. ない itself conjugates as i-adjective. ます becomes ません.''',
      i18n: [
        I18nInfo(
            language: 'ja',
            name: '～ない',
            description: 'その動作・作用・状態の成立を否定することを表わす。'),
      ],
      rules: [
        suffixInflection('くない', 'い', ['adj-i'], ['adj-i']),
        suffixInflection('ない', 'る', ['adj-i'], ['v1']),
        suffixInflection('かない', 'く', ['adj-i'], ['v5']),
        suffixInflection('がない', 'ぐ', ['adj-i'], ['v5']),
        suffixInflection('さない', 'す', ['adj-i'], ['v5']),
        suffixInflection('たない', 'つ', ['adj-i'], ['v5']),
        suffixInflection('なない', 'ぬ', ['adj-i'], ['v5']),
        suffixInflection('ばない', 'ぶ', ['adj-i'], ['v5']),
        suffixInflection('まない', 'む', ['adj-i'], ['v5']),
        suffixInflection('らない', 'る', ['adj-i'], ['v5']),
        suffixInflection('わない', 'う', ['adj-i'], ['v5']),
        suffixInflection('じない', 'ずる', ['adj-i'], ['vz']),
        suffixInflection('しない', 'する', ['adj-i'], ['vs']),
        suffixInflection('為ない', '為る', ['adj-i'], ['vs']),
        suffixInflection('こない', 'くる', ['adj-i'], ['vk']),
        suffixInflection('来ない', '来る', ['adj-i'], ['vk']),
        suffixInflection('來ない', '來る', ['adj-i'], ['vk']),
        suffixInflection('ません', 'ます', ['-ません'], ['-ます']),
      ],
    ),
    '-さ': Transform(
      name: '-さ',
      description:
          '''Nominalizing suffix of i-adjectives indicating nature, state, mind or degree.
Usage: Attach さ to the stem of i-adjectives.''',
      i18n: [
        I18nInfo(language: 'ja', name: '～さ', description: 'こと。程度。'),
      ],
      rules: [
        suffixInflection('さ', 'い', [], ['adj-i']),
      ],
    ),
    'passive': Transform(
      name: 'passive',
      description: '''$passiveEnglishDescription
Usage: Attach れる to the irrealis form (未然形) of godan verbs.''',
      i18n: [
        I18nInfo(language: 'ja', name: '～れる'),
      ],
      rules: [
        suffixInflection('かれる', 'く', ['v1'], ['v5']),
        suffixInflection('がれる', 'ぐ', ['v1'], ['v5']),
        suffixInflection('される', 'す', ['v1'], ['v5d', 'v5sp']),
        suffixInflection('たれる', 'つ', ['v1'], ['v5']),
        suffixInflection('なれる', 'ぬ', ['v1'], ['v5']),
        suffixInflection('ばれる', 'ぶ', ['v1'], ['v5']),
        suffixInflection('まれる', 'む', ['v1'], ['v5']),
        suffixInflection('われる', 'う', ['v1'], ['v5']),
        suffixInflection('られる', 'る', ['v1'], ['v5']),
        suffixInflection('じされる', 'ずる', ['v1'], ['vz']),
        suffixInflection('ぜされる', 'ずる', ['v1'], ['vz']),
        suffixInflection('される', 'する', ['v1'], ['vs']),
        suffixInflection('為れる', '為る', ['v1'], ['vs']),
        suffixInflection('こられる', 'くる', ['v1'], ['vk']),
        suffixInflection('来られる', '来る', ['v1'], ['vk']),
        suffixInflection('來られる', '來る', ['v1'], ['vk']),
      ],
    ),
    '-た': Transform(
      name: '-た',
      description:
          '''1. Indicates a reality that has happened in the past.
2. Indicates the completion of an action.
3. Indicates the confirmation of a matter.
4. Indicates the speaker's confidence that the action will definitely be fulfilled.
5. Indicates the events that occur before the main clause are represented as relative past.
6. Indicates a mild imperative/command.
Usage: Attach た to the continuative form (連用形) of verbs after euphonic change form, かった to the stem of i-adjectives.''',
      i18n: [
        I18nInfo(language: 'ja', name: '～た'),
      ],
      rules: [
        suffixInflection('かった', 'い', ['-た'], ['adj-i']),
        suffixInflection('た', 'る', ['-た'], ['v1']),
        suffixInflection('いた', 'く', ['-た'], ['v5']),
        suffixInflection('いだ', 'ぐ', ['-た'], ['v5']),
        suffixInflection('した', 'す', ['-た'], ['v5']),
        suffixInflection('った', 'う', ['-た'], ['v5']),
        suffixInflection('った', 'つ', ['-た'], ['v5']),
        suffixInflection('った', 'る', ['-た'], ['v5']),
        suffixInflection('んだ', 'ぬ', ['-た'], ['v5']),
        suffixInflection('んだ', 'ぶ', ['-た'], ['v5']),
        suffixInflection('んだ', 'む', ['-た'], ['v5']),
        suffixInflection('じた', 'ずる', ['-た'], ['vz']),
        suffixInflection('した', 'する', ['-た'], ['vs']),
        suffixInflection('為た', '為る', ['-た'], ['vs']),
        suffixInflection('きた', 'くる', ['-た'], ['vk']),
        suffixInflection('来た', '来る', ['-た'], ['vk']),
        suffixInflection('來た', '來る', ['-た'], ['vk']),
        ...irregularVerbSuffixInflections('た', ['-た'], ['v5']),
        suffixInflection('ました', 'ます', ['-た'], ['-ます']),
        suffixInflection('でした', '', ['-た'], ['-ません']),
        suffixInflection('かった', '', ['-た'], ['-ません', '-ん']),
      ],
    ),
    '-ます': Transform(
      name: '-ます',
      description: '''Polite conjugation of verbs and adjectives.
Usage: Attach ます to the continuative form (連用形) of verbs.''',
      i18n: [
        I18nInfo(language: 'ja', name: '～ます'),
      ],
      rules: [
        suffixInflection('ます', 'る', ['-ます'], ['v1']),
        suffixInflection('います', 'う', ['-ます'], ['v5d']),
        suffixInflection('きます', 'く', ['-ます'], ['v5d']),
        suffixInflection('ぎます', 'ぐ', ['-ます'], ['v5d']),
        suffixInflection('します', 'す', ['-ます'], ['v5d', 'v5s']),
        suffixInflection('ちます', 'つ', ['-ます'], ['v5d']),
        suffixInflection('にます', 'ぬ', ['-ます'], ['v5d']),
        suffixInflection('びます', 'ぶ', ['-ます'], ['v5d']),
        suffixInflection('みます', 'む', ['-ます'], ['v5d']),
        suffixInflection('ります', 'る', ['-ます'], ['v5d']),
        suffixInflection('じます', 'ずる', ['-ます'], ['vz']),
        suffixInflection('します', 'する', ['-ます'], ['vs']),
        suffixInflection('為ます', '為る', ['-ます'], ['vs']),
        suffixInflection('きます', 'くる', ['-ます'], ['vk']),
        suffixInflection('来ます', '来る', ['-ます'], ['vk']),
        suffixInflection('來ます', '來る', ['-ます'], ['vk']),
        suffixInflection('くあります', 'い', ['-ます'], ['adj-i']),
      ],
    ),
    'potential': Transform(
      name: 'potential',
      description:
          '''Indicates a state of being (naturally) capable of doing an action.
Usage: Attach (ら)れる to the irrealis form (未然形) of ichidan verbs.
Attach る to the imperative form (命令形) of godan verbs.
する becomes できる, くる becomes こ(ら)れる''',
      i18n: [
        I18nInfo(language: 'ja', name: '～(ら)れる'),
      ],
      rules: [
        suffixInflection('れる', 'る', ['v1'], ['v1', 'v5d']),
        suffixInflection('える', 'う', ['v1'], ['v5d']),
        suffixInflection('ける', 'く', ['v1'], ['v5d']),
        suffixInflection('げる', 'ぐ', ['v1'], ['v5d']),
        suffixInflection('せる', 'す', ['v1'], ['v5d']),
        suffixInflection('てる', 'つ', ['v1'], ['v5d']),
        suffixInflection('ねる', 'ぬ', ['v1'], ['v5d']),
        suffixInflection('べる', 'ぶ', ['v1'], ['v5d']),
        suffixInflection('める', 'む', ['v1'], ['v5d']),
        suffixInflection('できる', 'する', ['v1'], ['vs']),
        suffixInflection('出来る', 'する', ['v1'], ['vs']),
        suffixInflection('これる', 'くる', ['v1'], ['vk']),
        suffixInflection('来れる', '来る', ['v1'], ['vk']),
        suffixInflection('來れる', '來る', ['v1'], ['vk']),
      ],
    ),
    'potential or passive': Transform(
      name: 'potential or passive',
      description: '''$passiveEnglishDescription
3. Indicates a state of being (naturally) capable of doing an action.
Usage: Attach られる to the irrealis form (未然形) of ichidan verbs.
する becomes せられる, くる becomes こられる''',
      i18n: [
        I18nInfo(language: 'ja', name: '～られる'),
      ],
      rules: [
        suffixInflection('られる', 'る', ['v1'], ['v1']),
        suffixInflection('ざれる', 'ずる', ['v1'], ['vz']),
        suffixInflection('ぜられる', 'ずる', ['v1'], ['vz']),
        suffixInflection('せられる', 'する', ['v1'], ['vs']),
        suffixInflection('為られる', '為る', ['v1'], ['vs']),
        suffixInflection('こられる', 'くる', ['v1'], ['vk']),
        suffixInflection('来られる', '来る', ['v1'], ['vk']),
        suffixInflection('來られる', '來る', ['v1'], ['vk']),
      ],
    ),
    'volitional': Transform(
      name: 'volitional',
      description:
          '''1. Expresses speaker's will or intention.
2. Expresses an invitation to the other party.
3. (Used in …ようとする) Indicates being on the verge of initiating an action or transforming a state.
4. Indicates an inference of a matter.
Usage: Attach よう to the irrealis form (未然形) of ichidan verbs.
Attach う to the irrealis form (未然形) of godan verbs after -o euphonic change form.
Attach かろう to the stem of i-adjectives (4th meaning only).''',
      i18n: [
        I18nInfo(language: 'ja', name: '～う・よう', description: '主体の意志を表わす'),
      ],
      rules: [
        suffixInflection('よう', 'る', [], ['v1']),
        suffixInflection('おう', 'う', [], ['v5']),
        suffixInflection('こう', 'く', [], ['v5']),
        suffixInflection('ごう', 'ぐ', [], ['v5']),
        suffixInflection('そう', 'す', [], ['v5']),
        suffixInflection('とう', 'つ', [], ['v5']),
        suffixInflection('のう', 'ぬ', [], ['v5']),
        suffixInflection('ぼう', 'ぶ', [], ['v5']),
        suffixInflection('もう', 'む', [], ['v5']),
        suffixInflection('ろう', 'る', [], ['v5']),
        suffixInflection('じよう', 'ずる', [], ['vz']),
        suffixInflection('しよう', 'する', [], ['vs']),
        suffixInflection('為よう', '為る', [], ['vs']),
        suffixInflection('こよう', 'くる', [], ['vk']),
        suffixInflection('来よう', '来る', [], ['vk']),
        suffixInflection('來よう', '來る', [], ['vk']),
        suffixInflection('ましょう', 'ます', [], ['-ます']),
        suffixInflection('かろう', 'い', [], ['adj-i']),
      ],
    ),
    'volitional slang': Transform(
      name: 'volitional slang',
      description: '''Contraction of volitional form + か
1. Expresses speaker's will or intention.
2. Expresses an invitation to the other party.
Usage: Replace final う with っ of volitional form then add か.
For example: 行こうか -> 行こっか.''',
      i18n: [
        I18nInfo(language: 'ja', name: '～っか・よっか', description: '「うか・ようか」の短縮'),
      ],
      rules: [
        suffixInflection('よっか', 'る', [], ['v1']),
        suffixInflection('おっか', 'う', [], ['v5']),
        suffixInflection('こっか', 'く', [], ['v5']),
        suffixInflection('ごっか', 'ぐ', [], ['v5']),
        suffixInflection('そっか', 'す', [], ['v5']),
        suffixInflection('とっか', 'つ', [], ['v5']),
        suffixInflection('のっか', 'ぬ', [], ['v5']),
        suffixInflection('ぼっか', 'ぶ', [], ['v5']),
        suffixInflection('もっか', 'む', [], ['v5']),
        suffixInflection('ろっか', 'る', [], ['v5']),
        suffixInflection('じよっか', 'ずる', [], ['vz']),
        suffixInflection('しよっか', 'する', [], ['vs']),
        suffixInflection('為よっか', '為る', [], ['vs']),
        suffixInflection('こよっか', 'くる', [], ['vk']),
        suffixInflection('来よっか', '来る', [], ['vk']),
        suffixInflection('來よっか', '來る', [], ['vk']),
        suffixInflection('ましょっか', 'ます', [], ['-ます']),
      ],
    ),
    '-まい': Transform(
      name: '-まい',
      description: '''Negative volitional form of verbs.
1. Expresses speaker's assumption that something is likely not true.
2. Expresses speaker's will or intention not to do something.
Usage: Attach まい to the dictionary form (終止形) of verbs.
Attach まい to the irrealis form (未然形) of ichidan verbs.
する becomes しまい, くる becomes こまい''',
      i18n: [
        I18nInfo(
            language: 'ja',
            name: '～まい',
            description:
                '''1. 打うち消けしの推量すいりょう 「～ないだろう」と想像する
2. 打うち消けしの意志いし「～ないつもりだ」という気持ち'''),
      ],
      rules: [
        suffixInflection('まい', '', [], ['v']),
        suffixInflection('まい', 'る', [], ['v1']),
        suffixInflection('じまい', 'ずる', [], ['vz']),
        suffixInflection('しまい', 'する', [], ['vs']),
        suffixInflection('為まい', '為る', [], ['vs']),
        suffixInflection('こまい', 'くる', [], ['vk']),
        suffixInflection('来まい', '来る', [], ['vk']),
        suffixInflection('來まい', '來る', [], ['vk']),
        suffixInflection('まい', '', [], ['-ます']),
      ],
    ),
    '-おく': Transform(
      name: '-おく',
      description:
          '''To do certain things in advance in preparation (or in anticipation) of latter needs.
Usage: Attach おく to the て-form of verbs.
Attach でおく after ない negative form of verbs.
Contracts to とく・どく in speech.''',
      i18n: [
        I18nInfo(language: 'ja', name: '～おく'),
      ],
      rules: [
        suffixInflection('ておく', 'て', ['v5'], ['-て']),
        suffixInflection('でおく', 'で', ['v5'], ['-て']),
        suffixInflection('とく', 'て', ['v5'], ['-て']),
        suffixInflection('どく', 'で', ['v5'], ['-て']),
        suffixInflection('ないでおく', 'ない', ['v5'], ['adj-i']),
        suffixInflection('ないどく', 'ない', ['v5'], ['adj-i']),
      ],
    ),
    '-いる': Transform(
      name: '-いる',
      description:
          '''1. Indicates an action continues or progresses to a point in time.
2. Indicates an action is completed and remains as is.
3. Indicates a state or condition that can be taken to be the result of undergoing some change.
Usage: Attach いる to the て-form of verbs. い can be dropped in speech.
Attach でいる after ない negative form of verbs.
(Slang) Attach おる to the て-form of verbs. Contracts to とる・でる in speech.''',
      i18n: [
        I18nInfo(language: 'ja', name: '～いる'),
      ],
      rules: [
        suffixInflection('ている', 'て', ['v1'], ['-て']),
        suffixInflection('ておる', 'て', ['v5'], ['-て']),
        suffixInflection('てる', 'て', ['v1p'], ['-て']),
        suffixInflection('でいる', 'で', ['v1'], ['-て']),
        suffixInflection('でおる', 'で', ['v5'], ['-て']),
        suffixInflection('でる', 'で', ['v1p'], ['-て']),
        suffixInflection('とる', 'て', ['v5'], ['-て']),
        suffixInflection('ないでいる', 'ない', ['v1'], ['adj-i']),
      ],
    ),
    '-き': Transform(
      name: '-き',
      description:
          'Attributive form (連体形) of i-adjectives. An archaic form that remains in modern Japanese.',
      i18n: [
        I18nInfo(language: 'ja', name: '～き', description: '連体形'),
      ],
      rules: [
        suffixInflection('き', 'い', [], ['adj-i']),
      ],
    ),
    '-げ': Transform(
      name: '-げ',
      description: '''Describes a person's appearance. Shows feelings of the person.
Usage: Attach げ or 気 to the stem of i-adjectives''',
      i18n: [
        I18nInfo(
            language: 'ja',
            name: '～げ',
            description: '…でありそうな様子。いかにも…らしいさま。'),
      ],
      rules: [
        suffixInflection('げ', 'い', [], ['adj-i']),
        suffixInflection('気', 'い', [], ['adj-i']),
      ],
    ),
    '-がる': Transform(
      name: '-がる',
      description:
          '''1. Shows subject’s feelings contrast with what is thought/known about them.
2. Indicates subject's behavior (stands out).
Usage: Attach がる to the stem of i-adjectives. It itself conjugates as a godan verb.''',
      i18n: [
        I18nInfo(
            language: 'ja',
            name: '～がる',
            description: 'いかにもその状態にあるという印象を相手に与えるような言動をする。'),
      ],
      rules: [
        suffixInflection('がる', 'い', ['v5'], ['adj-i']),
      ],
    ),
    '-え': Transform(
      name: '-え',
      description: '''Slang. A sound change of i-adjectives.
ai：やばい → やべぇ
ui：さむい → さみぃ/さめぇ
oi：すごい → すげぇ''',
      i18n: [
        I18nInfo(language: 'ja', name: '～え'),
      ],
      rules: [
        suffixInflection('ねえ', 'ない', [], ['adj-i']),
        suffixInflection('めえ', 'むい', [], ['adj-i']),
        suffixInflection('みい', 'むい', [], ['adj-i']),
        suffixInflection('ちぇえ', 'つい', [], ['adj-i']),
        suffixInflection('ちい', 'つい', [], ['adj-i']),
        suffixInflection('せえ', 'すい', [], ['adj-i']),
        suffixInflection('ええ', 'いい', [], ['adj-i']),
        suffixInflection('ええ', 'わい', [], ['adj-i']),
        suffixInflection('ええ', 'よい', [], ['adj-i']),
        suffixInflection('いぇえ', 'よい', [], ['adj-i']),
        suffixInflection('うぇえ', 'わい', [], ['adj-i']),
        suffixInflection('けえ', 'かい', [], ['adj-i']),
        suffixInflection('げえ', 'がい', [], ['adj-i']),
        suffixInflection('げえ', 'ごい', [], ['adj-i']),
        suffixInflection('せえ', 'さい', [], ['adj-i']),
        suffixInflection('めえ', 'まい', [], ['adj-i']),
        suffixInflection('ぜえ', 'ずい', [], ['adj-i']),
        suffixInflection('っぜえ', 'ずい', [], ['adj-i']),
        suffixInflection('れえ', 'らい', [], ['adj-i']),
        suffixInflection('れえ', 'らい', [], ['adj-i']),
        suffixInflection('ちぇえ', 'ちゃい', [], ['adj-i']),
        suffixInflection('でえ', 'どい', [], ['adj-i']),
        suffixInflection('れえ', 'れい', [], ['adj-i']),
        suffixInflection('べえ', 'ばい', [], ['adj-i']),
        suffixInflection('てえ', 'たい', [], ['adj-i']),
        suffixInflection('ねぇ', 'ない', [], ['adj-i']),
        suffixInflection('めぇ', 'むい', [], ['adj-i']),
        suffixInflection('みぃ', 'むい', [], ['adj-i']),
        suffixInflection('ちぃ', 'つい', [], ['adj-i']),
        suffixInflection('せぇ', 'すい', [], ['adj-i']),
        suffixInflection('けぇ', 'かい', [], ['adj-i']),
        suffixInflection('げぇ', 'がい', [], ['adj-i']),
        suffixInflection('げぇ', 'ごい', [], ['adj-i']),
        suffixInflection('せぇ', 'さい', [], ['adj-i']),
        suffixInflection('めぇ', 'まい', [], ['adj-i']),
        suffixInflection('ぜぇ', 'ずい', [], ['adj-i']),
        suffixInflection('っぜぇ', 'ずい', [], ['adj-i']),
        suffixInflection('れぇ', 'らい', [], ['adj-i']),
        suffixInflection('でぇ', 'どい', [], ['adj-i']),
        suffixInflection('れぇ', 'れい', [], ['adj-i']),
        suffixInflection('べぇ', 'ばい', [], ['adj-i']),
        suffixInflection('てぇ', 'たい', [], ['adj-i']),
      ],
    ),
    'n-slang': Transform(
      name: 'n-slang',
      i18n: [
        I18nInfo(language: 'ja', name: '～んな'),
      ],
      description:
          'Slang sound change of r-column syllables to n (when before an n-sound, usually の or な)',
      rules: [
        suffixInflection('んなさい', 'りなさい', [], ['-なさい']),
        suffixInflection('らんない', 'られない', ['adj-i'], ['adj-i']),
        suffixInflection('んない', 'らない', ['adj-i'], ['adj-i']),
        suffixInflection('んなきゃ', 'らなきゃ', [], ['-ゃ']),
        suffixInflection('んなきゃ', 'れなきゃ', [], ['-ゃ']),
      ],
    ),
    'imperative negative slang': Transform(
      name: 'imperative negative slang',
      i18n: [
        I18nInfo(language: 'ja', name: '～んな'),
      ],
      description: '', // No description provided in JS
      rules: [
        suffixInflection('んな', 'る', [], ['v']),
      ],
    ),
    'kansai-ben negative': Transform(
      name: 'kansai-ben',
      description: 'Negative form of kansai-ben verbs',
      i18n: [
        I18nInfo(language: 'ja', name: '関西弁', description: '～ない (関西弁)'),
      ],
      rules: [
        suffixInflection('へん', 'ない', [], ['adj-i']),
        suffixInflection('ひん', 'ない', [], ['adj-i']),
        suffixInflection('せえへん', 'しない', [], ['adj-i']),
        suffixInflection('へんかった', 'なかった', ['-た'], ['-た']),
        suffixInflection('ひんかった', 'なかった', ['-た'], ['-た']),
        suffixInflection('うてへん', 'ってない', [], ['adj-i']),
      ],
    ),
    'kansai-ben -て': Transform(
      name: 'kansai-ben',
      description: '-て form of kansai-ben verbs',
      i18n: [
        I18nInfo(language: 'ja', name: '関西弁', description: '～て (関西弁)'),
      ],
      rules: [
        suffixInflection('うて', 'って', ['-て'], ['-て']),
        suffixInflection('おうて', 'あって', ['-て'], ['-て']),
        suffixInflection('こうて', 'かって', ['-て'], ['-て']),
        suffixInflection('ごうて', 'がって', ['-て'], ['-て']),
        suffixInflection('そうて', 'さって', ['-て'], ['-て']),
        suffixInflection('ぞうて', 'ざって', ['-て'], ['-て']),
        suffixInflection('とうて', 'たって', ['-て'], ['-て']),
        suffixInflection('どうて', 'だって', ['-て'], ['-て']),
        suffixInflection('のうて', 'なって', ['-て'], ['-て']),
        suffixInflection('ほうて', 'はって', ['-て'], ['-て']),
        suffixInflection('ぼうて', 'ばって', ['-て'], ['-て']),
        suffixInflection('もうて', 'まって', ['-て'], ['-て']),
        suffixInflection('ろうて', 'らって', ['-て'], ['-て']),
        suffixInflection('ようて', 'やって', ['-て'], ['-て']),
        suffixInflection('ゆうて', 'いって', ['-て'], ['-て']),
      ],
    ),
    'kansai-ben -た': Transform(
      name: 'kansai-ben',
      description: '-た form of kansai-ben terms',
      i18n: [
        I18nInfo(language: 'ja', name: '関西弁', description: '～た (関西弁)'),
      ],
      rules: [
        suffixInflection('うた', 'った', ['-た'], ['-た']),
        suffixInflection('おうた', 'あった', ['-た'], ['-た']),
        suffixInflection('こうた', 'かった', ['-た'], ['-た']),
        suffixInflection('ごうた', 'がった', ['-た'], ['-た']),
        suffixInflection('そうた', 'さった', ['-た'], ['-た']),
        suffixInflection('ぞうた', 'ざった', ['-た'], ['-た']),
        suffixInflection('とうた', 'たった', ['-た'], ['-た']),
        suffixInflection('どうた', 'だった', ['-た'], ['-た']),
        suffixInflection('のうた', 'なった', ['-た'], ['-た']),
        suffixInflection('ほうた', 'はった', ['-た'], ['-た']),
        suffixInflection('ぼうた', 'ばった', ['-た'], ['-た']),
        suffixInflection('もうた', 'まった', ['-た'], ['-た']),
        suffixInflection('ろうた', 'らった', ['-た'], ['-た']),
        suffixInflection('ようた', 'やった', ['-た'], ['-た']),
        suffixInflection('ゆうた', 'いった', ['-た'], ['-た']),
      ],
    ),
    'kansai-ben -たら': Transform(
      name: 'kansai-ben',
      description: '-たら form of kansai-ben terms',
      i18n: [
        I18nInfo(language: 'ja', name: '関西弁', description: '～たら (関西弁)'),
      ],
      rules: [
        suffixInflection('うたら', 'ったら', [], []),
        suffixInflection('おうたら', 'あったら', [], []),
        suffixInflection('こうたら', 'かったら', [], []),
        suffixInflection('ごうたら', 'がったら', [], []),
        suffixInflection('そうたら', 'さったら', [], []),
        suffixInflection('ぞうたら', 'ざったら', [], []),
        suffixInflection('とうたら', 'たったら', [], []),
        suffixInflection('どうたら', 'だったら', [], []),
        suffixInflection('のうたら', 'なったら', [], []),
        suffixInflection('ほうたら', 'はったら', [], []),
        suffixInflection('ぼうたら', 'ばったら', [], []),
        suffixInflection('もうたら', 'まったら', [], []),
        suffixInflection('ろうたら', 'らったら', [], []),
        suffixInflection('ようたら', 'やったら', [], []),
        suffixInflection('ゆうたら', 'いったら', [], []),
      ],
    ),
    'kansai-ben -たり': Transform(
      name: 'kansai-ben',
      description: '-たり form of kansai-ben terms',
      i18n: [
        I18nInfo(language: 'ja', name: '関西弁', description: '～たり (関西弁)'),
      ],
      rules: [
        suffixInflection('うたり', 'ったり', [], []),
        suffixInflection('おうたり', 'あったり', [], []),
        suffixInflection('こうたり', 'かったり', [], []),
        suffixInflection('ごうたり', 'がったり', [], []),
        suffixInflection('そうたり', 'さったり', [], []),
        suffixInflection('ぞうたり', 'ざったり', [], []),
        suffixInflection('とうたり', 'たったり', [], []),
        suffixInflection('どうたり', 'だったり', [], []),
        suffixInflection('のうたり', 'なったり', [], []),
        suffixInflection('ほうたり', 'はったり', [], []),
        suffixInflection('ぼうたり', 'ばったり', [], []),
        suffixInflection('もうたり', 'まったり', [], []),
        suffixInflection('ろうたり', 'らったり', [], []),
        suffixInflection('ようたり', 'やったり', [], []),
        suffixInflection('ゆうたり', 'いったり', [], []),
      ],
    ),
    'kansai-ben -く': Transform(
      name: 'kansai-ben',
      description: '-く stem of kansai-ben adjectives',
      i18n: [
        I18nInfo(language: 'ja', name: '関西弁', description: '連用形 (関西弁)'),
      ],
      rules: [
        suffixInflection('う', 'く', [], ['-く']),
        suffixInflection('こう', 'かく', [], ['-く']),
        suffixInflection('ごう', 'がく', [], ['-く']),
        suffixInflection('そう', 'さく', [], ['-く']),
        suffixInflection('とう', 'たく', [], ['-く']),
        suffixInflection('のう', 'なく', [], ['-く']),
        suffixInflection('ぼう', 'ばく', [], ['-く']),
        suffixInflection('もう', 'まく', [], ['-く']),
        suffixInflection('ろう', 'らく', [], ['-く']),
        suffixInflection('よう', 'よく', [], ['-く']),
        suffixInflection('しゅう', 'しく', [], ['-く']),
      ],
    ),
    'kansai-ben adjective -て': Transform(
      name: 'kansai-ben',
      description: '-て form of kansai-ben adjectives',
      i18n: [
        I18nInfo(language: 'ja', name: '関西弁', description: '～て (関西弁)'),
      ],
      rules: [
        suffixInflection('うて', 'くて', ['-て'], ['-て']),
        suffixInflection('こうて', 'かくて', ['-て'], ['-て']),
        suffixInflection('ごうて', 'がくて', ['-て'], ['-て']),
        suffixInflection('そうて', 'さくて', ['-て'], ['-て']),
        suffixInflection('とうて', 'たくて', ['-て'], ['-て']),
        suffixInflection('のうて', 'なくて', ['-て'], ['-て']),
        suffixInflection('ぼうて', 'ばくて', ['-て'], ['-て']),
        suffixInflection('もうて', 'まくて', ['-て'], ['-て']),
        suffixInflection('ろうて', 'らくて', ['-て'], ['-て']),
        suffixInflection('ようて', 'よくて', ['-て'], ['-て']),
        suffixInflection('しゅうて', 'しくて', ['-て'], ['-て']),
      ],
    ),
    'kansai-ben adjective negative': Transform(
      name: 'kansai-ben',
      description: 'Negative form of kansai-ben adjectives',
      i18n: [
        I18nInfo(language: 'ja', name: '関西弁', description: '～ない (関西弁)'),
      ],
      rules: [
        suffixInflection('うない', 'くない', ['adj-i'], ['adj-i']),
        suffixInflection('こうない', 'かくない', ['adj-i'], ['adj-i']),
        suffixInflection('ごうない', 'がくない', ['adj-i'], ['adj-i']),
        suffixInflection('そうない', 'さくない', ['adj-i'], ['adj-i']),
        suffixInflection('とうない', 'たくない', ['adj-i'], ['adj-i']),
        suffixInflection('のうない', 'なくない', ['adj-i'], ['adj-i']),
        suffixInflection('ぼうない', 'ばくない', ['adj-i'], ['adj-i']),
        suffixInflection('もうない', 'まくない', ['adj-i'], ['adj-i']),
        suffixInflection('ろうない', 'らくない', ['adj-i'], ['adj-i']),
        suffixInflection('ようない', 'よくない', ['adj-i'], ['adj-i']),
        suffixInflection('しゅうない', 'しくない', ['adj-i'], ['adj-i']),
      ],
    ),
  },
);


final conjugationTestCases = [
  {
    'verb': '食べる',
    'pos': 'Ichidan verb',
    'expected': [
      '食べない', // Negative
      '食べます', // Polite
      '食べた', // Past
      '食べれば', // Provisional
      '食べろ', // Imperative
      '食べられる' // Passive
    ],
  },
  {
    'verb': '飲む',
    'pos': "Godan verb with 'mu' ending",
    'expected': [
      '飲まない', // Negative
      '飲みます', // Polite
      '飲んだ', // Past
      '飲めば', // Provisional
      '飲め', // Imperative
      '飲まれる' // Passive
    ],
  },
  {
    'verb': '来る',
    'pos': 'Kuru verb - special class',
    'expected': [
      'こない', // Negative
      'きます', // Polite
      'きた', // Past
      'くれば', // Provisional
      'こい', // Imperative
      'こられる' // Passive
    ],
  },
  {
    'verb': 'する',
    'pos': 'suru verb - included',
    'expected': [
      'しない', // Negative
      'します', // Polite
      'した', // Past
      'すれば', // Provisional
      'しろ', // Imperative
      'される' // Passive
    ],
  },
];
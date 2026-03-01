/// Defines low-level test cases for the [selectMaxLengthWord] and 
/// [posFromTokeNodes] functions.
/// 
/// These tests focus strictly on grammatical grouping logic, ensuring that 
/// verbs bind to their conjugations, while distinct syntactic units 
/// (like nouns and particles) remain separate.
final List<Map<String, dynamic>> selectWordTestCases = [
  {
    'description': 'Groups a verb stem with its auxiliary conjugation',
    'input': '行きます',
    'expectedGroupedNodesCount': 2, // '行き' + 'ます'
    'expectedCombinedSurface': '行きます',
    'expectedPrimaryPos': '動詞',
  },
  {
    'description': 'Does NOT group a noun and a following particle',
    'input': '学校に',
    'expectedGroupedNodesCount': 1, // '学校' only. 'に' should remain unselected.
    'expectedCombinedSurface': '学校',
    'expectedPrimaryPos': '名詞',
  },
  {
    'description': 'Groups a noun with a valid suffix',
    'input': '子供たち',
    'expectedGroupedNodesCount': 2, // '子供' + 'たち' (Assuming たち is tagged as a suffix)
    'expectedCombinedSurface': '子供たち',
    'expectedPrimaryPos': '名詞',
  },
  {
    'description': 'Identifies and groups Na-adjectives correctly',
    'input': '静かな',
    'expectedGroupedNodesCount': 2, // '静か' + 'な'
    'expectedCombinedSurface': '静かな',
    'expectedPrimaryPos': '形状詞', // UniDic tag for Na-adjectives
  },
  {
    'description': 'Groups complex multi-conjugation chains',
    'input': '食べさせられた',
    'expectedGroupedNodesCount': 4, // '食べ' + 'させ' + 'られ' + 'た'
    'expectedCombinedSurface': '食べさせられた',
    'expectedPrimaryPos': '動詞',
  },
];
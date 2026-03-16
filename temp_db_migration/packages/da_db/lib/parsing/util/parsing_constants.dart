// --- INDEX ---
const String indexFileName = "index.json";
/// used as index name in audio dicts for uniquness
const String yomitanIndexFile = "yomitan_index.json";

// --- Yomitan DICTIONARY BANKS ---
const String audioListName = "audio_list.json";
const String tagBankPrefix = "tag_bank_";
const String termBankPrefix = "term_bank_";
const String termMetaBankPrefix = "term_meta_bank_";
const String kanjiBankPrefix = "kanji_bank_";
const String kanjiMetaBankPrefix = "kanji_meta_bank_";


/// All files that yomitan parser should parse
const List<String> yomitanDictFiles = [
  audioListName,
  tagBankPrefix,
  termBankPrefix,
  termMetaBankPrefix,
  kanjiBankPrefix,
  kanjiMetaBankPrefix,
];

// --- AUDIO BANKS ---
const String audioIndexFile = "index.json";
const String audioEntriesFile = "entries.json";

// --- EXAMPLE SENTENCE BANKS ---
const String exampleBankPrefix = "example_bank_";
const String exampleTextBankPrefix = "example_text_bank_";
const String exampleTextMetaBankPrefix = "example_text_meta_bank_";

/// All files that the example parser should parse
const List<String> exampleDictFiles = [
  exampleBankPrefix,
  exampleTextBankPrefix,
  tagBankPrefix,
];
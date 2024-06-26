


/// filed filteres as defined in JMDict
Map<String, String> jmDictFields = {
  "MA" : "martial arts term",
  "X" : "rude or X-rated term",
  "archit" : "architecture term",
  "astron" : "astronomy, etc. term",
  "baseb" : "baseball term",
  "biol" : "biology term",
  "bot" : "botany term",
  "bus" : "business term",
  "econ" : "economics term",
  "engr" : "engineering term",
  "finc" : "finance term",
  "geol" : "geology, etc. term",
  "law" : "law, etc. term",
  "mahj" : "mahjong term",
  "med" : "medicine, etc. term",
  "music" : "music term",
  "Shinto" : "Shinto term",
  "shogi" : "shogi term",
  "sports" : "sports term",
  "sumo" : "sumo term",
  "zool" : "zoology term",
  "joc" : "jocular, humorous term",
  "anat" : "anatomical term",
  "physics" : "physics terminology",
  "rare" : "rare",
  "sens" : "sensitive",
  "sl" : "slang",
  "num" : "numeric",
  "oK" : "word containing out-dated kanji",
  "obs" : "obsolete term",
  "obsc" : "obscure term",
  "abbr" : "abbreviation",
  "arch" : "archaism",
  "Buddh" : "Buddhist term",
  "chem" : "chemistry term",
  "chn" : "children's language",
  "col" : "colloquialism",
  "comp" : "computer terminology",
  "derog" : "derogatory",
  "fam" : "familiar language",
  "fem" : "female term or language",
  "food" : "food term",
  "geom" : "geometry term",
  "exp" : "expressions (phrases, clauses, etc.)",
  "ling" : "linguistics terminology",
  "m-sl" : "manga slang",
  "male" : "male term or language",
  "male-sl" : "male slang",
  "math" : "mathematics",
  "mil" : "military",
  "vulg" : "vulgar expression or word",
  "kyb" : "Kyoto-ben",
  "osb" : "Osaka-ben",
  "ksb" : "Kansai-ben",
  "ktb" : "Kantou-ben",
  "tsb" : "Tosa-ben",
  "thb" : "Touhoku-ben",
  "tsug" : "Tsugaru-ben",
  "kyu" : "Kyuushuu-ben",
  "rkb" : "Ryuukyuu-ben",
  "nab" : "Nagano-ben",
  "hob" : "Hokkaido-ben",
  "poet" : "poetical term",
  "pol" : "polite (teineigo) language",
  "hon" : "honorific or respectful (sonkeigo) language",
  "hum" : "humble (kenjougo) language",
  "yoji" : "yojijukugo",
  "on-mim" : "onomatopoeic or mimetic word",
  "proverb" : "proverb",
  "unc" : "unclassified",
  "id" : "idiomatic expression",
};

/// general part of speech filters that apply to many specific filters
Map<String, String> jmDictPosGeneral = {
  "adj" : "adjective",
  "adv" : "adverb (fukushi)",
  "aux" : "auxiliary",
  "ctr" : "counter",
  "noun" : "noun",
  "verb" : "verb",
  "proverb" : "proverb",
  "pn" : "pronoun",
  "pref" : "prefix",
  "prt" : "particle",
  "suf" : "suffix",
};

/// part of speech filteres as defined in JMDict
Map<String, String> jmDictPos = {
  "vt" : "transitive verb",
  "adj-i" : "adjective (keiyoushi)",
  "adj-ix" : "adjective (keiyoushi) - yoi/ii class",
  "adj-na" : "adjectival nouns or quasi-adjectives (keiyodoshi)",
  "adj-no" : "nouns which may take the genitive case particle `no'",
  "adj-pn" : "pre-noun adjectival (rentaishi)",
  "adj-t" : "`taru' adjective",
  "adj-f" : "noun or verb acting prenominally",
  "adv" : "adverb (fukushi)",
  "adv-to" : "adverb taking the `to' particle",
  "aux" : "auxiliary",
  "aux-v" : "auxiliary verb",
  "aux-adj" : "auxiliary adjective",
  "conj" : "conjunction",
  "cop-da" : "copula",
  "ctr" : "counter",
  "int" : "interjection (kandoushi)",
  "io" : "irregular okurigana usage",
  "iv" : "irregular verb",
  "n" : "noun (common) (futsuumeishi)",
  "n-adv" : "adverbial noun (fukushitekimeishi)",
  "n-suf" : "noun, used as a suffix",
  "n-pref" : "noun, used as a prefix",
  "n-t" : "noun (temporal) (jisoumeishi)",
  "pn" : "pronoun",
  "pref" : "prefix",
  "prt" : "particle",
  "suf" : "suffix",
  "v1" : "Ichidan verb",
  "v1-s" : "Ichidan verb - kureru special class",
  "v2a-s" : "Nidan verb with 'u' ending (archaic)",
  "v4h" : "Yodan verb with `hu/fu' ending (archaic)",
  "v4r" : "Yodan verb with `ru' ending (archaic)",
  "v5aru" : "Godan verb - -aru special class",
  "v5b" : "Godan verb with `bu' ending",
  "v5g" : "Godan verb with `gu' ending",
  "v5k" : "Godan verb with `ku' ending",
  "v5k-s" : "Godan verb - Iku/Yuku special class",
  "v5m" : "Godan verb with `mu' ending",
  "v5n" : "Godan verb with `nu' ending",
  "v5r" : "Godan verb with `ru' ending",
  "v5r-i" : "Godan verb with `ru' ending (irregular verb)",
  "v5s" : "Godan verb with `su' ending",
  "v5t" : "Godan verb with `tsu' ending",
  "v5u" : "Godan verb with `u' ending",
  "v5u-s" : "Godan verb with `u' ending (special class)",
  "v5uru" : "Godan verb - Uru old class verb (old form of Eru)",
  "vz" : "Ichidan verb - zuru verb (alternative form of -jiru verbs)",
  "vi" : "intransitive verb",
  "vk" : "Kuru verb - special class",
  "vn" : "irregular nu verb",
  "vr" : "irregular ru verb, plain form ends with -ri",
  "vs" : "noun or participle which takes the aux. verb suru",
  "vs-c" : "su verb - precursor to the modern suru",
  "vs-s" : "suru verb - special class",
  "vs-i" : "suru verb - irregular",
  "adj-kari" : "`kari' adjective (archaic)",
  "adj-ku" : "`ku' adjective (archaic)",
  "adj-shiku" : "`shiku' adjective (archaic)",
  "adj-nari" : "archaic/formal form of na-adjective",
  "n-pr" : "proper noun",
  "v-unspec" : "verb unspecified",
  "v4k" : "Yodan verb with `ku' ending (archaic)",
  "v4g" : "Yodan verb with `gu' ending (archaic)",
  "v4s" : "Yodan verb with `su' ending (archaic)",
  "v4t" : "Yodan verb with `tsu' ending (archaic)",
  "v4n" : "Yodan verb with `nu' ending (archaic)",
  "v4b" : "Yodan verb with `bu' ending (archaic)",
  "v4m" : "Yodan verb with `mu' ending (archaic)",
  "v2k-k" : "Nidan verb (upper class) with `ku' ending (archaic)",
  "v2g-k" : "Nidan verb (upper class) with `gu' ending (archaic)",
  "v2t-k" : "Nidan verb (upper class) with `tsu' ending (archaic)",
  "v2d-k" : "Nidan verb (upper class) with `dzu' ending (archaic)",
  "v2h-k" : "Nidan verb (upper class) with `hu/fu' ending (archaic)",
  "v2b-k" : "Nidan verb (upper class) with `bu' ending (archaic)",
  "v2m-k" : "Nidan verb (upper class) with `mu' ending (archaic)",
  "v2y-k" : "Nidan verb (upper class) with `yu' ending (archaic)",
  "v2r-k" : "Nidan verb (upper class) with `ru' ending (archaic)",
  "v2k-s" : "Nidan verb (lower class) with `ku' ending (archaic)",
  "v2g-s" : "Nidan verb (lower class) with `gu' ending (archaic)",
  "v2s-s" : "Nidan verb (lower class) with `su' ending (archaic)",
  "v2z-s" : "Nidan verb (lower class) with `zu' ending (archaic)",
  "v2t-s" : "Nidan verb (lower class) with `tsu' ending (archaic)",
  "v2d-s" : "Nidan verb (lower class) with `dzu' ending (archaic)",
  "v2n-s" : "Nidan verb (lower class) with `nu' ending (archaic)",
  "v2h-s" : "Nidan verb (lower class) with `hu/fu' ending (archaic)",
  "v2b-s" : "Nidan verb (lower class) with `bu' ending (archaic)",
  "v2m-s" : "Nidan verb (lower class) with `mu' ending (archaic)",
  "v2y-s" : "Nidan verb (lower class) with `yu' ending (archaic)",
  "v2r-s" : "Nidan verb (lower class) with `ru' ending (archaic)",
  "v2w-s" : "Nidan verb (lower class) with `u' ending and `we' conjugation (archaic)",
};

/// All part of speech filters (sames as `jmDictPos`) but sorted alphabetically
Map<String, String> jmDictPosSorted = Map.fromEntries(
  jmDictPos.entries.toList()..sort((a, b) => 
    a.value.replaceAll(RegExp(r"[^a-zA-Z]+"), "").toLowerCase()
      .compareTo(b.value.replaceAll(RegExp(r"[^a-zA-Z]+"), "").toLowerCase())
  )
);

/// All part of speech filters (sames as `jmDictPos`) but sorted alphabetically
Map<String, String> jmDictPosGeneralSorted = Map.fromEntries(
  jmDictPosGeneral.entries.toList()..sort((a, b) => 
    a.value.replaceAll(RegExp(r"[^a-zA-Z]+"), "").toLowerCase()
      .compareTo(b.value.replaceAll(RegExp(r"[^a-zA-Z]+"), "").toLowerCase())
  )
);

/// All field filters (sames as `jmDictFields`) but sorted alphabetically
Map<String, String> jmDictFieldsSorted = Map.fromEntries(
  jmDictFields.entries.toList()..sort((a, b) => 
    a.value.replaceAll(RegExp(r"[^a-zA-Z]+"), "").toLowerCase()
      .compareTo(b.value.replaceAll(RegExp(r"[^a-zA-Z]+"), "").toLowerCase())
  )
// add the entries from the dict that is longer
);

/// all filters that are available
Map<String, String> jmDictAllFilters = jmDictPosGeneral..addAll(jmDictFields)..addAll(jmDictPos);

/// all filters that are available (sorted)
Map<String, String> jmDictAllFiltersSorted = Map.fromEntries(
  jmDictAllFilters.entries.toList()..sort((a, b) => 
    a.value.replaceAll(RegExp(r"[^a-zA-Z]+"), "").toLowerCase()
      .compareTo(b.value.replaceAll(RegExp(r"[^a-zA-Z]+"), "").toLowerCase())
  )
);

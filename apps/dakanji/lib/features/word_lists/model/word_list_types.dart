/// types of nodes in the word lists
enum WordListNodeType{
  folder,
  folderDefault,
  wordList,
  wordListDefault,
  root
}

/// List containing all types that are a folders
List<WordListNodeType> get wordListFolderTypes => [
  WordListNodeType.folder,
  WordListNodeType.folderDefault,
];

/// List containing all types that are a word lists
List<WordListNodeType> get wordListListypes => [
  WordListNodeType.wordList,
  WordListNodeType.wordListDefault,
];

/// List containing all types that are a default nodes
List<WordListNodeType>  get wordListDefaultTypes => [
  WordListNodeType.folderDefault,
  WordListNodeType.wordListDefault,
];

/// List containing all types that are a user created nodes
List<WordListNodeType> get wordListUserTypes => [
  WordListNodeType.folder,
  WordListNodeType.wordList,
];
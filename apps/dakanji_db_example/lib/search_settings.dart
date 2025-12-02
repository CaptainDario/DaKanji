class SearchSettings {
  bool normalizedSearch;
  bool convertRomaji;
  bool deconjugation;
  bool spellfix;
  bool groupResults;

  SearchSettings({
    this.normalizedSearch = true,
    this.convertRomaji = true,
    this.deconjugation = true,
    this.spellfix = true,
    this.groupResults = true,
  });

  // Helper to clone current settings so we don't mutate state directly until saved
  SearchSettings copy() => SearchSettings(
    normalizedSearch: normalizedSearch,
    convertRomaji: convertRomaji,
    deconjugation: deconjugation,
    spellfix: spellfix,
    groupResults: groupResults,
  );
}
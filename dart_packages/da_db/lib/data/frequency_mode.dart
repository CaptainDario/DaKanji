enum FrequencyMode {
  /// Higher value = More frequent (e.g. 15000 occurrences)
  /// [Sort DESC]
  occurrenceBased,

  /// Lower value = More frequent (e.g. Rank #1)
  /// [Sort ASC (or normalized to negative)]
  rankBased,
}
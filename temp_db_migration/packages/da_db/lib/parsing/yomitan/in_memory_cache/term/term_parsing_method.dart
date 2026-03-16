/// Enum to identify which parsing strategy was used for a definition.
enum TermParsingMethod {
  /// A simple, plain string definition.
  plainString,
  /// A modern structured-content block with an explicit "glossary" tag.
  modernStructured,
  /// A legacy structured-content block without a "glossary" tag.
  legacyStructured,
  /// A simple text object e.g. { "type": "text", "text": "..." }.
  textObject,
  /// A term and a list of deinflection steps
  deinflection,
  /// An image
  image,
  /// An unsupported format, like a deinflection rule.
  unsupported,
}
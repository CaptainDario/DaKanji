
/// Returns null if the string is null or empty, otherwise returns the string.
extension NullableStringExtensions on String? {
  String? get nullIfEmptyOrNull {
    if (this == null || this!.isEmpty) {
      return null;
    }
    return this;
  }
}
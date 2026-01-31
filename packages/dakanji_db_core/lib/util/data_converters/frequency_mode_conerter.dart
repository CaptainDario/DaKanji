import 'package:dakanji_db_core/data/frequency_mode.dart';



FrequencyMode? mapFrequencyMode(String? mode) {
  switch (mode) {
    case 'occurrence-based':
      return FrequencyMode.occurrenceBased;
    case 'rank-based':
      return FrequencyMode.rankBased;
    default:
      return null;
  }
}
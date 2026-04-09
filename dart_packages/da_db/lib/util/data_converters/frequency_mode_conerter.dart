import 'package:da_db/data/frequency_mode.dart';



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
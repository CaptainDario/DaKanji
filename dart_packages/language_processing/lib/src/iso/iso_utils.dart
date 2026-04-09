import 'package:language_processing/src/iso/iso_data.dart';
import 'package:language_processing/src/iso/iso_table.dart';



({Iso639_1? iso1, Iso639_2B? iso2b, Iso639_2T? iso2t, Iso639_3? iso3}) parseToIso(String? isoString) {
  
  // Find the ISO3 entry using the generated map.
  final foundIso3 = isoToIso639_3[isoString];

  if (foundIso3 == null) {
    return (iso1: null, iso2b: null, iso2t: null, iso3: null);
  }

  // Use the name of the found ISO3 (e.g., 'deu') to look up the others.
  final String key = foundIso3.name;

  return (
    iso1: isoToIso639_1[key],
    iso2b: isoToIso639_2B[key],
    iso2t: isoToIso639_2T[key],
    iso3: foundIso3,
  );
}

/// Returns `true` if the language uses space separation (e.g. English, German, 
/// etc.), `false` if it does not (e.g. Japanese, Chinese, etc.)
bool usesSpaceSeparation(Iso639_3? languageCode) {

  if (nonSpaceLanguages.contains(languageCode) || languageCode == null) return false;
  
  return true;
}
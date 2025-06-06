// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/da_kanji_icons.dart';
import 'package:da_kanji_mobile/entities/da_kanji_icons_icons.dart';
import 'package:da_kanji_mobile/entities/manual/manual_types.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/manual/manual_anki.dart';
import 'package:da_kanji_mobile/widgets/manual/manual_deep_links.dart';
import 'package:da_kanji_mobile/widgets/manual/manual_dictionary.dart';
import 'package:da_kanji_mobile/widgets/manual/manual_dojg.dart';
import 'package:da_kanji_mobile/widgets/manual/manual_kana_table.dart';
import 'package:da_kanji_mobile/widgets/manual/manual_misc.dart';
import 'package:da_kanji_mobile/widgets/manual/manual_text.dart';

/// Data class to store all data related to the manual
class ManualData {

  /// the text that is shown on the ManualButtons
  List<String> manualTitles = [];
  /// the icons that are shown on the ManualButtons
  List<IconData> manualIcons = [];
  /// The different manual pages and their actual content
  List<Widget> manualPages = [];
  /// List with all manual types
  List<ManualTypes> manualTypes = [];


  ManualData() {

    manualTitles = [
      LocaleKeys.DictionaryScreen_title.tr(),
      LocaleKeys.TextScreen_title.tr(),
      LocaleKeys.ManualScreen_anki_title.tr(),
      LocaleKeys.DojgScreen_title.tr(),
      LocaleKeys.KanaTableScreen_title.tr(),
      LocaleKeys.ManualScreen_deep_links_title.tr(),
      LocaleKeys.ManualScreen_misc_title.tr()
    ];

    manualIcons = [
      DaKanjiIcons.dictionary,
      DaKanjiIcons.text,
      DaKanjiCustomIcons.anki,
      DaKanjiCustomIcons.dojg,
      DaKanjiCustomIcons.kana_table,
      DaKanjiIcons.deepLinks,
      DaKanjiIcons.misc
    ];

    manualPages = [
      const ManualDictionary(),
      const ManualTextScreen(),
      const ManualAnki(),
      const ManualDojgPage(),
      const ManualKanaTablePage(),
      const ManualDeepLinks(),
      const ManualMisc()
    ];

    manualTypes = [
      ManualTypes.dictionary,
      ManualTypes.text,
      ManualTypes.anki,
      ManualTypes.dojg,
      ManualTypes.kanaTable,
      ManualTypes.deepLinks,
      ManualTypes.misc
    ];

  }

}

import 'package:da_kanji_mobile/domain/manual/manual_types.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/data/da_kanji_icons_icons.dart';
import 'package:da_kanji_mobile/widgets/manual/manual_deep_links.dart';
import 'package:da_kanji_mobile/widgets/manual/manual_dictionary.dart';
import 'package:da_kanji_mobile/widgets/manual/manual_dojg.dart';



/// Data class to store all data related to the manual
class ManualData {

  /// the text that is shown on the ManualButtons
  List<String> manualTitles = [];
  /// the icons that are shown on the ManualButtons
  List<IconData> manualIcons = [];
  /// The different manual pages and their actual content
  List<Widget> manualPages = [];

  List<ManualTypes> manualTypes = [];


  ManualData() {

    manualTitles = [
      //"Drawing",
      LocaleKeys.ManualScreen_dict_title.tr(),
      //"Text",
      //LocaleKeys.ManualScreen_anki_title.tr(),
      LocaleKeys.ManualScreen_dojg_title.tr(),
      LocaleKeys.ManualScreen_deep_links_title.tr()
    ];

    manualIcons = [
      //Icons.brush,
      Icons.book,
      //Icons.text_snippet,
      //DaKanjiIcons.anki,
      DaKanjiIcons.dojg,
      Icons.link
    ];

    manualPages = [
      const ManualDictionary(),
      //ManualTextScreen(),
      //ManualAnki(),
      const ManualDojgPage(),
      const ManualDeepLinks(),
    ];

    manualTypes = [
      ManualTypes.dictionary,
      ManualTypes.dojg,
      ManualTypes.deepLinks,
    ];

  }

}
// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/da_kanji_icons_icons.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/settings/anki_settings_column.dart';
import 'package:provider/provider.dart';

/// All settings realted to anki
class AnkiSettings extends StatefulWidget {
    
  const AnkiSettings({super.key});

  @override
  State<AnkiSettings> createState() => _AnkiSettingsState();
}

class _AnkiSettingsState extends State<AnkiSettings> {
  @override
  Widget build(BuildContext context) {

    Settings settings = context.watch<Settings>();

    return ResponsiveHeaderTile(
      LocaleKeys.SettingsScreen_anki_title.tr(),
      DaKanjiCustomIcons.anki,
      autoSizeGroup: g_SettingsAutoSizeGroup,
      children: [
        AnkiSettingsColumn(settings)  
      ],
    );
  }
}

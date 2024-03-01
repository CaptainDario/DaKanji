// Flutter imports:
import 'package:da_kanji_mobile/widgets/settings/export_include_languages_chips.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/application/anki/anki.dart';
import 'package:da_kanji_mobile/entities/da_kanji_icons_icons.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_drop_down_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_filter_chips.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_header_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_input_field_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_slider_tile.dart';

class AnkiSettings extends StatefulWidget {
    
  /// DaKanji settings object
  final Settings settings;

  const AnkiSettings(
    this.settings,
    {
      super.key
    }
  );

  @override
  State<AnkiSettings> createState() => _AnkiSettingsState();
}

class _AnkiSettingsState extends State<AnkiSettings> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveHeaderTile(
      LocaleKeys.SettingsScreen_anki_title.tr(),
      DaKanjiIcons.anki,
      autoSizeGroup: g_SettingsAutoSizeGroup,
      children: [
        // the default deck to add cards to
      ResponsiveDropDownTile(
        text: LocaleKeys.SettingsScreen_anki_default_deck.tr(),
        value: widget.settings.anki.defaultDeck,
        items: widget.settings.anki.availableDecks.contains(widget.settings.anki.defaultDeck) ||
          widget.settings.anki.defaultDeck == null
          ? widget.settings.anki.availableDecks
          : [...widget.settings.anki.availableDecks, widget.settings.anki.defaultDeck!],
        onChanged: (value) async {
          if(value == null) return;

          setState(() {
            widget.settings.anki.defaultDeck = value;
          });

          await widget.settings.save();
        },
        leadingButtonIcon: Icons.replay_outlined,
        leadingButtonPressed: () async {
          bool ankiAvailable = await GetIt.I<Anki>().checkAnkiAvailableAndShowSnackbar(
            context,
            successMessage: LocaleKeys.SettingsScreen_anki_get_decks_success.tr(),
            failureMessage:  LocaleKeys.SettingsScreen_anki_get_decks_fail.tr());
          if(!ankiAvailable) return;

          List<String> deckNames = await GetIt.I<Anki>().getDeckNames();
          
          setState(() {
            widget.settings.anki.defaultDeck   = deckNames[0];
            widget.settings.anki.availableDecks = deckNames;
          });
        },
      ),
      // which langauges should be included
      ExportLanguagesIncludeChips(
          includedLanguages: widget.settings.anki.includedLanguages,
          selectedTranslationLanguages: widget.settings.dictionary.selectedTranslationLanguages,
          settings: widget.settings,
          setIncludeLanguagesItem: widget.settings.anki.setIncludeLanguagesItem,
        ),
      // how many different translations from entries should be included
      ResponsiveSliderTile(
        text: LocaleKeys.SettingsScreen_anki_default_no_translations.tr(),
        value: widget.settings.anki.noTranslations.toDouble(),
        min: 1,
        max: 50,
        divisions: 50,
        showLabelAsInt: true,
        autoSizeGroup: g_SettingsAutoSizeGroup,
        onChanged: (value) {
          setState(() {
            widget.settings.anki.noTranslations = value.toInt();
            widget.settings.save();
          });
        },
      ),
      // URL to communicate with anki connect
      if(Platform.isMacOS || Platform.isLinux || Platform.isWindows)
        ResponsiveInputFieldTile(
          enabled: true,
          text: widget.settings.anki.desktopAnkiURL,
          hintText: LocaleKeys.SettingsScreen_anki_desktop_url.tr(),
          onChanged: (value) {
            widget.settings.anki.desktopAnkiURL = value;
            widget.settings.save();
          },
        ),
      // include google image (disabled for now)
      if(false)
        // ignore: dead_code
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_anki_include_google_image.tr(),
          value: widget.settings.anki.includeGoogleImage,
          onTileTapped: (value) {
            setState(() {
              widget.settings.anki.includeGoogleImage = value;
              widget.settings.save();
            });
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
      // include audio (disabled for now)
      if(false)
        // ignore: dead_code
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_anki_include_audio.tr(),
          value: widget.settings.anki.includeAudio,
          onTileTapped: (value) {
            setState(() {
              widget.settings.anki.includeAudio = value;
              widget.settings.save();
            });
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
      // include screenshot (disabled for now)
      if(false)
        // ignore: dead_code
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_anki_include_screenshot.tr(),
          value: widget.settings.anki.includeScreenshot,
          onTileTapped: (value) {
            setState(() {
              widget.settings.anki.includeScreenshot = value;
              widget.settings.save();
            });
          },
          autoSizeGroup: g_SettingsAutoSizeGroup,
        ),
      ],
    );
  }
}

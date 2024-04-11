// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/application/anki/anki.dart';
import 'package:da_kanji_mobile/application/manual/manual.dart';
import 'package:da_kanji_mobile/entities/manual/manual_types.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_check_box_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_drop_down_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_icon_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_input_field_tile.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_slider_tile.dart';
import 'package:da_kanji_mobile/widgets/settings/export_include_languages_chips.dart';

/// All settings realted to anki
class AnkiSettingsColumn extends StatefulWidget {
    
  /// DaKanji settings object
  final Settings settings;

  const AnkiSettingsColumn(
    this.settings,
    {
      super.key
    }
  );

  @override
  State<AnkiSettingsColumn> createState() => _AnkiSettingsColumnState();
}

class _AnkiSettingsColumnState extends State<AnkiSettingsColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // has anki been setup
        ResponsiveIconTile(
          text: LocaleKeys.SettingsScreen_anki_setup.tr(),
          icon: GetIt.I<UserData>().ankiSetup
            ? const Icon(Icons.check, color: g_Dakanji_green,)
            : const Icon(Icons.do_not_disturb, color: g_Dakanji_red),
          onTilePressed: !GetIt.I<UserData>().ankiSetup
            ? () => pushManual(context, ManualTypes.anki)
            : null,
        ),
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
            bool ankiAvailable = await GetIt.I<Anki>().checkAnkiAvailable();
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(ankiAvailable
                  ? LocaleKeys.SettingsScreen_anki_get_decks_success.tr()
                  : LocaleKeys.SettingsScreen_anki_get_decks_fail.tr()
                )
              ),
            );
            
            if(!ankiAvailable) return;

            List<String> deckNames = await GetIt.I<Anki>().getDeckNames();
            
            setState(() {
              widget.settings.anki.defaultDeck    = deckNames[0];
              widget.settings.anki.availableDecks = deckNames;
            });
          },
        ),
        
        ResponsiveCheckBoxTile(
          text: "Show settings dialog before adding",
          value: widget.settings.anki.showAnkiSettingsDialogBeforeAdding,
          onTileTapped: (value) {
            widget.settings.anki.showAnkiSettingsDialogBeforeAdding = value;
            widget.settings.save();
          },
        ),
        // which langauges should be included
        ExportLanguagesIncludeChips(
          text: LocaleKeys.SettingsScreen_anki_languages_to_include.tr(),
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

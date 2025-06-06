// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';

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

            // first check if anki is available and show a snackbar accordingly            
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
        // Allow Duplicates
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_anki_allow_duplicates.tr(),
          value: widget.settings.anki.allowDuplicates,
          leadingIcon: Icons.info,
          onLeadingIconPressed: () async {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.noHeader,
              btnOkColor: g_Dakanji_green,
              btnOkOnPress: (){},
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MarkdownBody(
                    data: LocaleKeys.SettingsScreen_anki_allow_duplicates_explanation.tr(),
                  ),
                )
              )
            ).show();
          },
          onTileTapped: (value) {
            setState(() {
              widget.settings.anki.allowDuplicates = value;
              widget.settings.save();
            });
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
          min: 0,
          max: 10,
          divisions: 11,
          showLabelAsInt: true,
          onChanged: (value) {
            setState(() {
              widget.settings.anki.noTranslations = value.toInt();
              widget.settings.save();
            });
          },
        ),
        // URL to communicate with anki connect
        if(g_desktopPlatform)
          ResponsiveInputFieldTile(
            enabled: true,
            text: widget.settings.anki.desktopAnkiURL,
            hintText: LocaleKeys.SettingsScreen_anki_desktop_url.tr(),
            onChanged: (value) {
              widget.settings.anki.desktopAnkiURL = value;
              widget.settings.save();
            },
          ),
        // how many examples should be included
        ResponsiveSliderTile(
          text: LocaleKeys.SettingsScreen_anki_number_of_examples.tr(),
          value: widget.settings.anki.noExamples.toDouble(),
          min: 0,
          max: 5,
          divisions: 5,
          showLabelAsInt: true,
          onChanged: (value) {
            setState(() {
              widget.settings.anki.noExamples = value.toInt();
              widget.settings.save();
            });
          },
        ),
        // Should the example's translations be included
        ResponsiveCheckBoxTile(
          text: LocaleKeys.SettingsScreen_anki_include_example_translations.tr(),
          value: widget.settings.anki.includeExampleTranslations,
          onTileTapped: (value) {
            setState(() {
              widget.settings.anki.includeExampleTranslations = value;
              widget.settings.save();
            });
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
        ),
      ],
    );
  }
}

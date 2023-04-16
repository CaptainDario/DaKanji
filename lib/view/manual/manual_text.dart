import 'package:flutter/material.dart';

import 'package:simple_html_css/simple_html_css.dart';



/// The manual for the TextScreen
class ManualTextScreen extends StatelessWidget {
  ManualTextScreen({super.key});

  final String manualTextScreenText = "";
  /*
    """<h2>${LocaleKeys.ManualScreen_text_pos_title.tr()}</h2>
    ${LocaleKeys.ManualScreen_text_pos_intro.tr()} <br>
      • ${LocaleKeys.ManualScreen_text_pos_pronoun.tr()} <br>
      • ${LocaleKeys.ManualScreen_text_pos_adverb.tr()} <br>
      • ${LocaleKeys.ManualScreen_text_pos_aux_verb.tr()} <br>
      • ${LocaleKeys.ManualScreen_text_pos_particle.tr()} <br>
      • ${LocaleKeys.ManualScreen_text_pos_verb.tr()} <br>
      • ${LocaleKeys.ManualScreen_text_pos_noun.tr()} <br>
      • ${LocaleKeys.ManualScreen_text_pos_i_adj.tr()} <br>
      • ${LocaleKeys.ManualScreen_text_pos_na_adj.tr()} <br>
      • ${LocaleKeys.ManualScreen_text_pos_interjection.tr()} <br>
      • ${LocaleKeys.ManualScreen_text_pos_suffix.tr()} <br>
      • ${LocaleKeys.ManualScreen_text_pos_conjunction.tr()} <br>
      """
    .replaceAll("{ADVERB_COLOR}", colorToHtmlString(adverbColor))
    .replaceAll("{AUX_VERB_COLOR}", colorToHtmlString(auxVerbColor))
    .replaceAll("{PARTICLE_COLOR}", colorToHtmlString(particleColor))
    .replaceAll("{VERB_COLOR}", colorToHtmlString(verbColor))
    .replaceAll("{NOUN_COLOR}", colorToHtmlString(nounColor))
    .replaceAll("{I_ADJ_COLOR}", colorToHtmlString(iAdjectiveColor))
    .replaceAll("{NA_ADJ_COLOR}", colorToHtmlString(naAdjectiveColor))
    .replaceAll("{INTERJECTION_COLOR}", colorToHtmlString(interjectionColor))
    .replaceAll("{SUFFIX_COLOR}", colorToHtmlString(suffixColor))
    .replaceAll("{CONJUNCTION_COLOR}", colorToHtmlString(conjunctionColor));
  */

  @override
  Widget build(BuildContext context) {
    return HTML.toRichText(
      context, 
      manualTextScreenText,
      defaultTextStyle: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge!.color
      )
    );
  }
}
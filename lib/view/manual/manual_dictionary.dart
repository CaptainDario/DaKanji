import 'package:flutter/material.dart';

import 'package:simple_html_css/simple_html_css.dart';

import 'package:da_kanji_mobile/helper/color_conversion.dart';
import 'package:da_kanji_mobile/model/TextScreen/pos_colors.dart';



class ManualDictionary extends StatelessWidget {
  ManualDictionary({super.key});

  final String manualTextScreenText =
    """The {COLOR} button allows for showing the part of speech information (POS) of words. The colors:<br/>
      • pronoun: <a style="color:{PRONOUN_COLOR}">this is a <b>pronoun</b> example.</a><br/>
      • adverb: <a style="color:{ADVERB_COLOR}">this is an adverb example.</a><br/>
      • auxillary verb: <a style="color:{AUX_VERB_COLOR}">this is an auxillary verb example.</a><br/>
      • particle: <a style="color:{PARTICLE_COLOR}">this is a particle example.</a><br/>
      • verb: <a style="color:{VERB_COLOR}">this is an verb example.</a><br/>
      • noun: <a style="color:{NOUN_COLOR}">this is an noun example.</a><br/>
      • い-adjective: <a style="color:{I_ADJ_COLOR}">this is an い-adjective example.</a><br/>
      • な-adjective: <a style="color:{NA_ADJ_COLOR}">this is an な-adjective example.</a><br/>
      • interjection: <a style="color:{INTERJECTION_COLOR}">this is an interjection example.</a><br/>
      • suffix: <a style="color:{SUFFIX_COLOR}">this is a suffix example.</a><br/>
      • conjunction: <a style="color:{CONJUNCTION_COLOR}">this is an conjunction example.</a><br/>
      """
    .replaceAll("{PRONOUN_COLOR}", colorToHtmlString(pronounColor))
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

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: HTML.toTextSpan(context, manualTextScreenText),
    );
  }
}
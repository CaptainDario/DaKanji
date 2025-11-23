// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:feedback/feedback.dart';

// Project imports:
import 'package:da_kanji_mobile/locales_keys.dart';

class CustomFeedbackLocalizations implements FeedbackLocalizations {
  
  @override
  late final draw = LocaleKeys.FeedbackScreen_draw.tr();

  @override
  late final feedbackDescriptionText = LocaleKeys.FeedbackScreen_feedback_description_text.tr();

  @override
  late final navigate = LocaleKeys.FeedbackScreen_navigate.tr();

  @override
  late final submitButtonText = LocaleKeys.FeedbackScreen_submit.tr();

}

class CustomFeedbackLocalizationsDelegate extends GlobalFeedbackLocalizationsDelegate {

  @override
  // ignore: overridden_fields
  var supportedLocales = <Locale, FeedbackLocalizations>{
    // remember to change the locale identifier
    // as well as that defaultLocale (defaults to en) should ALWAYS be
    // present here or overridden
    const Locale('en'): CustomFeedbackLocalizations(),
  };
  
}

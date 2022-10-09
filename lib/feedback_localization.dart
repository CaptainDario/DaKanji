import 'package:feedback/feedback.dart';




import 'package:flutter/cupertino.dart';class CustomFeedbackLocalizations implements FeedbackLocalizations {
  
  @override
  final draw = "draw";

  @override
  final feedbackDescriptionText = "Please describe your matter as detailed as possible. After pressing submit you can share your annotated screenshot and text (email contact: daapplab@gmail.com)";

  @override
  final navigate = "navigate";

  @override
  final submitButtonText = "submit";

}

class CustomFeedbackLocalizationsDelegate extends GlobalFeedbackLocalizationsDelegate {

  @override
  final supportedLocales = <Locale, FeedbackLocalizations>{
    // remember to change the locale identifier
    // as well as that defaultLocale (defaults to en) should ALWAYS be
    // present here or overridden
    const Locale('en'): CustomFeedbackLocalizations(),
  };
  
}
// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> cn = {
  "AboutScreen": {
    "about_text": "",
    "software_informations_button": "",
  },
  "ChangelogScreen": {
  },
  "DrawScreen": {
    "tutorial_clear": "",
    "tutorial_double_tap_prediction": "",
    "tutorial_long_press_prediction": "",
    "tutorial_multi_search_double_tap": "",
    "tutorial_multi_search_short_press": "",
    "tutorial_predictions": "",
    "tutorial_skip": "",
  },
  "General": {
    "close": "",
    "dark": "",
    "light": "",
    "restarts_app": "",
    "web": ""
  },
  "HomeScreen": {
    "RatePopup_text": ""
  },
  "OnBoarding": {
    "Onboarding_1_title": "",
    "Onboarding_2_title": ""
  },
  "SettingsScreen": {
    "advanced_settings_title": "",
    "custom_url_format": "",
    "dictionary_system_translator": "",
    "empty_canvas_after_double_tap": "",
    "long_press_opens": "",
    "show_tutorial": "",
    "title": "",
  },
  "WebviewScreen": {
    "title": ""
  }
};
static const Map<String,dynamic> de = {
  "AboutScreen": {
    "about_text": "DaKanji ist für alle, die Japanisch lernen oder benutzen.\nMit DaKanji kann man handgeschriebene Zeichen nachschlagen. Im Moment können alle 漢字 von 漢字検定, ひらがな (auch Historische: ゑ, etc.) und カタカナ (auch Historische: ヱ, etc.) erkannt werden.\nIn der Zukunft wird der Funktionsumfang aber stark erweitert werden.\nDaKanji ist verfügbar für, [iOS](APPSTORE_PAGE), [Android](PLAYSTORE_PAGE), [MacOS](), [Linux]() und [Windows]()\n\nSchau dir auch meine [anderen Apps](DAAPPLAB_STORE_PAGE) an. \nFalls du Probleme mit der App hast oder Verbesserungsvorschläge, bitte öffne einen [GitHub-issue](GITHUB_ISSUES), tritt dem [Discordserver](DISCORD_SERVER) bei oder schicke eine E-Mail an daapplab@gmail.com.\n\nDie Privacy policy kann [hier](PRIVACY_POLICE) gefunden werden.",
    "show_changelog": "Zeig mir alle Änderungen.",
    "software_informations_button": "Softwareinformationen",
    "title": "Über die App"
  },
  "ChangelogScreen": {
    "title": "Änderungen"
  },
  "DrawScreen": {
    "title": "Zeichnen",
    "tutorial_clear": "Lösche all Striche",
    "tutorial_dictionary_settings": "In den Einstellung kann die Methode zum übersetzen gewählt werden",
    "tutorial_double_tap_prediction": "Tippe doppelt um das Zeichen der Suchbox hinzuzufügen",
    "tutorial_drawing": "Male ein Zeichen hier",
    "tutorial_long_press_prediction": "Lange auf eine Vorhersage drücken öffnet sie in einem Wörterbuch",
    "tutorial_multi_search": "Mit dieser Suchbox können mehrere Zeichen auf einmal gesucht werden",
    "tutorial_multi_search_double_tap": "Doppelt auf das Feld zutippen löscht den Inhalt",
    "tutorial_multi_search_long_press": "Lange auf die Suchbox zu klicken öffnet sie in einem Wörterbuch",
    "tutorial_multi_search_short_press": "Kurz auf die Suchbox zu drücken kopiert die Zeichen in den Zwischenspeicher",
    "tutorial_multi_search_swipe_left": "Links auf der Suchbox zu swipen löscht das letzte Zeichen",
    "tutorial_predictions": "Die vorhergesagten Zeichen werden hier angezeigt",
    "tutorial_short_press_prediction": "Einmal kurz drücken kopiert das vorhergesagte Zeichen",
    "tutorial_skip": "ÜBERSPRINGEN",
    "tutorial_undo": "Macht den letzten Strich rückgängig"
  },
  "General": {
    "app": "App",
    "close": "Schließen",
    "custom_url": "selbstdefinierte URL",
    "dark": "Dunkel",
    "language": "Sprache",
    "light": "Hell",
    "rate_this_app": "Bewerte",
    "restarts_app": "startet app neu",
    "system": "System",
    "web": "Web"
  },
  "HomeScreen": {
    "RatePopup_dont_ask_again": "Nie wieder!",
    "RatePopup_text": "Es sieht so aus als würde dir DaKanji gefallen.\nFalls das stimmt würde eine Bewertung dem Projekt extrem weiter helfen!"
  },
  "OnBoarding": {
    "Onboarding_1_text": "Male es mit deinem Finger und DaKanji zeigt dir das Zeichen",
    "Onboarding_1_title": "Du kennst ein Kanji nicht?",
    "Onboarding_2_text": "Mit DaKanji kannst du schnell Wörter in Web- und App-Wörterbüchern nachschlagen",
    "Onboarding_2_title": "Schlage Zeichen und Wörter nach"
  },
  "SettingsScreen": {
    "advanced_settings_drawing_inference_backend": "Inferenz Backend (die App muss neugestartet gestartet)",
    "advanced_settings_title": "Erweiterte Einstellungen",
    "custom_url_explanation": "Die App ersetzt einen Platzhalter in der gegbenen URL mit dem vorhergesagten Zeichen. Dieser Plathalter ist: {kanjiPlaceholder}\n\nBeispiel:\nDas vorhergesagte Zeichen ist: '口' und man wil es auf 'jisho.org' nachschlagen. Dafür muss als erste die URL der website, welche für das Suchen benutzt wird, herausgefunden werden. Für 'jisho.org' ist das: 'https://jisho.org/search/口'. Nun muss nur noch das Zeichen aus der URL mit dem Platzhalter ersetzt werden. Das führt zu 'https://jisho.org/search/{kanjiPlaceholder}'.",
    "custom_url_format": "Benutzerdefiniertes URL format",
    "custom_url_hint": "URL von dem Wörterbuch das benutzt werden soll",
    "dictionary_system_translator": "betriebssysteminternes Übersetzer",
    "drawing_title": "Zeichnen",
    "empty_canvas_after_double_tap": "Lösche alle Striche nach doppeltem Tippen",
    "invert_short_long_press": "Invertiere kurzes und langes drücken",
    "long_press_opens": "Langes drücken öffnet",
    "miscellaneous_title": "Verschiedenes",
    "show_tutorial": "Zeige Tutorial erneut (startet app neu)",
    "theme": "Thema (@:restarts_app)",
    "title": "Einstellungen",
    "use_default_browser_for_online_dictionaries": "Benutze einen webview für web Wörterbücher"
  },
  "WebviewScreen": {
    "loading": "Suche",
    "title": "Webview"
  }
};
static const Map<String,dynamic> en = {
  "AboutScreen": {
    "about_text": "DaKanji helps students of the Japanese language and people who use it.\nRight now it can recognize handwritten characters, all 漢字 from 漢字検定, ひらがな (also historical ones: ゑ, etc.) and カタカナ (also historical ones: ヱ, etc.)\nBut the feature set will be vastly improved in the coming releases.\nDaKanji is available for, [iOS](IOS), [Android](), [MacOS](), [Linux]() and [Windows]()\n\nAlso check out [my other apps.](DAAPPLAB_STORE_PAGE)\nIf you have problems using this app or suggestions how to improve it please report them [here](GITHUB_ISSUES), join the [discord server.](DISCORD_SERVER) or send an e-mail to daapplab@gmail.com.\n\nThe privacy police can be found [here](PRIVACY_POLICE)",
    "show_changelog": "Show me the complete changelog.",
    "software_informations_button": "Software informations",
    "title": "About"
  },
  "ChangelogScreen": {
    "title": "Changelog"
  },
  "DrawScreen": {
    "title": "Drawing",
    "tutorial_clear": "Erases all strokes",
    "tutorial_dictionary_settings": "In the settings the translation service can be chosen",
    "tutorial_double_tap_prediction": "A Double Tap adds the character to the search box",
    "tutorial_drawing": "Draw a character here",
    "tutorial_long_press_prediction": "A long press opens the prediction in a dictionary",
    "tutorial_multi_search": "Here you can search multiple characters at once",
    "tutorial_multi_search_double_tap": "A double tap empties the field",
    "tutorial_multi_search_long_press": "A long press opens the characters in a dictionary",
    "tutorial_multi_search_short_press": "A short press copies the characters to the clipboard",
    "tutorial_multi_search_swipe_left": "Swiping left on this field deletes the last character",
    "tutorial_predictions": "The predicted characters will be shown here",
    "tutorial_short_press_prediction": "A short press copies the prediction",
    "tutorial_skip": "SKIP",
    "tutorial_undo": "Press to undo the last stroke"
  },
  "General": {
    "app": "app",
    "close": "Close",
    "custom_url": "custom URL",
    "dark": "dark",
    "language": "language",
    "light": "light",
    "rate_this_app": "Rate",
    "restarts_app": "restarts app",
    "system": "system",
    "web": "web"
  },
  "HomeScreen": {
    "RatePopup_dont_ask_again": "Not again!",
    "RatePopup_text": "Do you like DaKanji?\nIf that is the case a rating would be awesome and it would help this project alot!"
  },
  "OnBoarding": {
    "Onboarding_1_text": "Just draw it and DaKanji will show the character you need.",
    "Onboarding_1_title": "You do not know a Kanji?",
    "Onboarding_2_text": "With DaKanji you can quickly lookup words using web and app dictionaries.",
    "Onboarding_2_title": "Lookup characters and words"
  },
  "SettingsScreen": {
    "advanced_settings_drawing_inference_backend": "Inference backend (the app needs to be restarted)",
    "advanced_settings_title": "Advanced settings",
    "custom_url_explanation": "The app will replace a placeholder in the URL with the predicted character. This placeholder is: {kanjiPlaceholder}\n\nExample:\nThe predicted character is: '口' and you want to open it on 'jisho.org'. First you have to get the URL of the website for searching. In this case: 'https://jisho.org/search/口'. Now only the character in the URL has to be replaced with the placeholder. This leads to 'https://jisho.org/search/{kanjiPlaceholder}'.",
    "custom_url_format": "Custom URL format",
    "custom_url_hint": "URL of your dictionary",
    "dictionary_system_translator": "OS integrated translator",
    "drawing_title": "Drawing",
    "empty_canvas_after_double_tap": "Empty canvas after double tap",
    "invert_short_long_press": "Invert long/short press",
    "long_press_opens": "Long press opens",
    "miscellaneous_title": "Miscellaneous",
    "show_tutorial": "Reshow tutorial (restarts app)",
    "theme": "theme (@:restarts_app)",
    "title": "Settings",
    "use_default_browser_for_online_dictionaries": "Use a webview for web dictionaries"
  },
  "WebviewScreen": {
    "loading": "Searching",
    "title": "Webview"
  }
};
static const Map<String,dynamic> es = {
  "AboutScreen": {
    "about_text": "",
    "software_informations_button": "",
  },
  "ChangelogScreen": {
  },
  "DrawScreen": {
    "tutorial_clear": "",
    "tutorial_double_tap_prediction": "",
    "tutorial_long_press_prediction": "",
    "tutorial_multi_search_double_tap": "",
    "tutorial_multi_search_short_press": "",
    "tutorial_predictions": "",
    "tutorial_skip": "",
  },
  "General": {
    "close": "",
    "dark": "",
    "light": "",
    "restarts_app": "",
    "web": ""
  },
  "HomeScreen": {
    "RatePopup_text": ""
  },
  "OnBoarding": {
    "Onboarding_1_title": "",
    "Onboarding_2_title": ""
  },
  "SettingsScreen": {
    "advanced_settings_title": "",
    "custom_url_format": "",
    "dictionary_system_translator": "",
    "empty_canvas_after_double_tap": "",
    "long_press_opens": "",
    "show_tutorial": "",
    "title": "",
  },
  "WebviewScreen": {
    "title": ""
  }
};
static const Map<String,dynamic> fr = {
  "AboutScreen": {
    "about_text": "",
    "software_informations_button": "",
  },
  "ChangelogScreen": {
  },
  "DrawScreen": {
    "tutorial_clear": "",
    "tutorial_double_tap_prediction": "",
    "tutorial_long_press_prediction": "",
    "tutorial_multi_search_double_tap": "",
    "tutorial_multi_search_short_press": "",
    "tutorial_predictions": "",
    "tutorial_skip": "",
  },
  "General": {
    "close": "",
    "dark": "",
    "light": "",
    "restarts_app": "",
    "web": ""
  },
  "HomeScreen": {
    "RatePopup_text": ""
  },
  "OnBoarding": {
    "Onboarding_1_title": "",
    "Onboarding_2_title": ""
  },
  "SettingsScreen": {
    "advanced_settings_title": "",
    "custom_url_format": "",
    "dictionary_system_translator": "",
    "empty_canvas_after_double_tap": "",
    "long_press_opens": "",
    "show_tutorial": "",
    "title": "",
  },
  "WebviewScreen": {
    "title": ""
  }
};
static const Map<String,dynamic> it = {
  "AboutScreen": {
    "about_text": "",
    "software_informations_button": "",
  },
  "ChangelogScreen": {
  },
  "DrawScreen": {
    "tutorial_clear": "",
    "tutorial_double_tap_prediction": "",
    "tutorial_long_press_prediction": "",
    "tutorial_multi_search_double_tap": "",
    "tutorial_multi_search_short_press": "",
    "tutorial_predictions": "",
    "tutorial_skip": "",
  },
  "General": {
    "close": "",
    "dark": "",
    "light": "",
    "restarts_app": "",
    "web": ""
  },
  "HomeScreen": {
    "RatePopup_text": ""
  },
  "OnBoarding": {
    "Onboarding_1_title": "",
    "Onboarding_2_title": ""
  },
  "SettingsScreen": {
    "advanced_settings_title": "",
    "custom_url_format": "",
    "dictionary_system_translator": "",
    "empty_canvas_after_double_tap": "",
    "long_press_opens": "",
    "show_tutorial": "",
    "title": "",
  },
  "WebviewScreen": {
    "title": ""
  }
};
static const Map<String,dynamic> jp = {
  "AboutScreen": {
    "about_text": "",
    "software_informations_button": "",
  },
  "ChangelogScreen": {
  },
  "DrawScreen": {
    "tutorial_clear": "",
    "tutorial_double_tap_prediction": "",
    "tutorial_long_press_prediction": "",
    "tutorial_multi_search_double_tap": "",
    "tutorial_multi_search_short_press": "",
    "tutorial_predictions": "",
    "tutorial_skip": "",
  },
  "General": {
    "close": "",
    "dark": "",
    "light": "",
    "restarts_app": "",
    "web": ""
  },
  "HomeScreen": {
    "RatePopup_text": ""
  },
  "OnBoarding": {
    "Onboarding_1_title": "",
    "Onboarding_2_title": ""
  },
  "SettingsScreen": {
    "advanced_settings_title": "",
    "custom_url_format": "",
    "dictionary_system_translator": "",
    "empty_canvas_after_double_tap": "",
    "long_press_opens": "",
    "show_tutorial": "",
    "title": "",
  },
  "WebviewScreen": {
    "title": ""
  }
};
static const Map<String,dynamic> localizations = {
  "AboutScreen": {
    "about_text": {
      "en": "DaKanji helps students of the Japanese language and people who use it.\nRight now it can recognize handwritten characters, all 漢字 from 漢字検定, ひらがな (also historical ones: ゑ, etc.) and カタカナ (also historical ones: ヱ, etc.)\nBut the feature set will be vastly improved in the coming releases.\nDaKanji is available for, [iOS](IOS), [Android](), [MacOS](), [Linux]() and [Windows]()\n\nAlso check out [my other apps.](DAAPPLAB_STORE_PAGE)\nIf you have problems using this app or suggestions how to improve it please report them [here](GITHUB_ISSUES), join the [discord server.](DISCORD_SERVER) or send an e-mail to daapplab@gmail.com.\n\nThe privacy police can be found [here](PRIVACY_POLICE)",
      "de": "DaKanji ist für alle, die Japanisch lernen oder benutzen.\nMit DaKanji kann man handgeschriebene Zeichen nachschlagen. Im Moment können alle 漢字 von 漢字検定, ひらがな (auch Historische: ゑ, etc.) und カタカナ (auch Historische: ヱ, etc.) erkannt werden.\nIn der Zukunft wird der Funktionsumfang aber stark erweitert werden.\nDaKanji ist verfügbar für, [iOS](APPSTORE_PAGE), [Android](PLAYSTORE_PAGE), [MacOS](), [Linux]() und [Windows]()\n\nSchau dir auch meine [anderen Apps](DAAPPLAB_STORE_PAGE) an. \nFalls du Probleme mit der App hast oder Verbesserungsvorschläge, bitte öffne einen [GitHub-issue](GITHUB_ISSUES), tritt dem [Discordserver](DISCORD_SERVER) bei oder schicke eine E-Mail an daapplab@gmail.com.\n\nDie Privacy policy kann [hier](PRIVACY_POLICE) gefunden werden."
    },
    "": {},
    "show_changelog": {
      "en": "Show me the complete changelog.",
      "de": "Zeig mir alle Änderungen."
    },
    "software_informations_button": {
      "en": "Software informations",
      "de": "Softwareinformationen"
    },
    "title": {
      "en": "About",
      "de": "Über die App"
    }
  },
  "ChangelogScreen": {
    "title": {
      "en": "Changelog",
      "de": "Änderungen"
    }
  },
  "DrawScreen": {
    "tutorial_clear": {
      "en": "Erases all strokes",
      "de": "Lösche all Striche"
    },
    "tutorial_double_tap_prediction": {
      "en": "A Double Tap adds the character to the search box",
      "de": "Tippe doppelt um das Zeichen der Suchbox hinzuzufügen"
    },
    "tutorial_drawing": {
      "en": "Draw a character here",
      "de": "Male ein Zeichen hier"
    },
    "tutorial_long_press_prediction": {
      "en": "A long press opens the prediction in a dictionary",
      "de": "Lange auf eine Vorhersage drücken öffnet sie in einem Wörterbuch"
    },
    "tutorial_multi_search_double_tap": {
      "en": "A double tap empties the field",
      "de": "Doppelt auf das Feld zutippen löscht den Inhalt"
    },
    "tutorial_multi_search_long_press": {
      "en": "A long press opens the characters in a dictionary",
      "de": "Lange auf die Suchbox zu klicken öffnet sie in einem Wörterbuch"
    },
    "tutorial_multi_search_short_press": {
      "en": "A short press copies the characters to the clipboard",
      "de": "Kurz auf die Suchbox zu drücken kopiert die Zeichen in den Zwischenspeicher"
    },
    "tutorial_multi_search_swipe_left": {
      "en": "Swiping left on this field deletes the last character",
      "de": "Links auf der Suchbox zu swipen löscht das letzte Zeichen"
    },
    "tutorial_multi_search": {
      "en": "Here you can search multiple characters at once",
      "de": "Mit dieser Suchbox können mehrere Zeichen auf einmal gesucht werden"
    },
    "tutorial_predictions": {
      "en": "The predicted characters will be shown here",
      "de": "Die vorhergesagten Zeichen werden hier angezeigt"
    },
    "tutorial_short_press_prediction": {
      "en": "A short press copies the prediction",
      "de": "Einmal kurz drücken kopiert das vorhergesagte Zeichen"
    },
    "tutorial_skip": {
      "en": "SKIP",
      "de": "ÜBERSPRINGEN"
    },
    "tutorial_undo": {
      "en": "Press to undo the last stroke",
      "de": "Macht den letzten Strich rückgängig"
    },
    "tutorial_dictionary_settings": {
      "en": "In the settings the translation service can be chosen",
      "de": "In den Einstellung kann die Methode zum übersetzen gewählt werden"
    },
    "title": {
      "en": "Drawing",
      "de": "Zeichnen"
    }
  },
  "General": {
    "app": {
      "en": "app",
      "de": "App"
    },
    "close": {
      "en": "Close",
      "de": "Schließen"
    },
    "custom_url": {
      "en": "custom URL",
      "de": "selbstdefinierte URL"
    },
    "dark": {
      "en": "dark",
      "de": "Dunkel"
    },
    "light": {
      "en": "light",
      "de": "Hell"
    },
    "restarts_app": {
      "en": "restarts app",
      "de": "startet app neu"
    },
    "system": {
      "en": "system",
      "de": "System"
    },
    "web": {
      "en": "web",
      "de": "Web"
    },
    "language": {
      "en": "language",
      "de": "Sprache"
    },
    "rate_this_app": {
      "en": "Rate",
      "de": "Bewerte"
    }
  },
  "HomeScreen": {
    "RatePopup_dont_ask_again": {
      "en": "Not again!",
      "de": "Nie wieder!"
    },
    "RatePopup_text": {
      "en": "Do you like DaKanji?\nIf that is the case a rating would be awesome and it would help this project alot!",
      "de": "Es sieht so aus als würde dir DaKanji gefallen.\nFalls das stimmt würde eine Bewertung dem Projekt extrem weiter helfen!"
    }
  },
  "OnBoarding": {
    "Onboarding_1_title": {
      "en": "You do not know a Kanji?",
      "de": "Du kennst ein Kanji nicht?"
    },
    "Onboarding_1_text": {
      "en": "Just draw it and DaKanji will show the character you need.",
      "de": "Male es mit deinem Finger und DaKanji zeigt dir das Zeichen"
    },
    "Onboarding_2_title": {
      "en": "Lookup characters and words",
      "de": "Schlage Zeichen und Wörter nach"
    },
    "Onboarding_2_text": {
      "en": "With DaKanji you can quickly lookup words using web and app dictionaries.",
      "de": "Mit DaKanji kannst du schnell Wörter in Web- und App-Wörterbüchern nachschlagen"
    }
  },
  "SettingsScreen": {
    "custom_url_hint": {
      "en": "URL of your dictionary",
      "de": "URL von dem Wörterbuch das benutzt werden soll"
    },
    "dictionary_system_translator": {
      "en": "OS integrated translator",
      "de": "betriebssysteminternes Übersetzer"
    },
    "drawing_title": {
      "en": "Drawing",
      "de": "Zeichnen"
    },
    "empty_canvas_after_double_tap": {
      "en": "Empty canvas after double tap",
      "de": "Lösche alle Striche nach doppeltem Tippen"
    },
    "invert_short_long_press": {
      "en": "Invert long/short press",
      "de": "Invertiere kurzes und langes drücken"
    },
    "long_press_opens": {
      "en": "Long press opens",
      "de": "Langes drücken öffnet"
    },
    "miscellaneous_title": {
      "en": "Miscellaneous",
      "de": "Verschiedenes"
    },
    "show_tutorial": {
      "en": "Reshow tutorial (restarts app)",
      "de": "Zeige Tutorial erneut (startet app neu)"
    },
    "theme": {
      "en": "theme (@:restarts_app)",
      "de": "Thema (@:restarts_app)"
    },
    "title": {
      "en": "Settings",
      "de": "Einstellungen"
    },
    "use_default_browser_for_online_dictionaries": {
      "en": "Use a webview for web dictionaries",
      "de": "Benutze einen webview für web Wörterbücher"
    },
    "custom_url_format": {
      "en": "Custom URL format",
      "de": "Benutzerdefiniertes URL format"
    },
    "custom_url_explanation": {
      "en": "The app will replace a placeholder in the URL with the predicted character. This placeholder is: {kanjiPlaceholder}\n\nExample:\nThe predicted character is: '口' and you want to open it on 'jisho.org'. First you have to get the URL of the website for searching. In this case: 'https://jisho.org/search/口'. Now only the character in the URL has to be replaced with the placeholder. This leads to 'https://jisho.org/search/{kanjiPlaceholder}'.",
      "de": "Die App ersetzt einen Platzhalter in der gegbenen URL mit dem vorhergesagten Zeichen. Dieser Plathalter ist: {kanjiPlaceholder}\n\nBeispiel:\nDas vorhergesagte Zeichen ist: '口' und man wil es auf 'jisho.org' nachschlagen. Dafür muss als erste die URL der website, welche für das Suchen benutzt wird, herausgefunden werden. Für 'jisho.org' ist das: 'https://jisho.org/search/口'. Nun muss nur noch das Zeichen aus der URL mit dem Platzhalter ersetzt werden. Das führt zu 'https://jisho.org/search/{kanjiPlaceholder}'."
    },
    "advanced_settings_drawing_inference_backend": {
      "en": "Inference backend (the app needs to be restarted)",
      "de": "Inferenz Backend (die App muss neugestartet gestartet)"
    },
    "advanced_settings_title": {
      "en": "Advanced settings",
      "de": "Erweiterte Einstellungen"
    }
  },
  "WebviewScreen": {
    "loading": {
      "en": "Searching",
      "de": "Suche"
    },
    "title": {
      "en": "Webview",
      "de": "Webview"
    }
  }
};
static const Map<String,dynamic> ru = {
  "AboutScreen": {
    "about_text": "",
    "software_informations_button": "",
  },
  "ChangelogScreen": {
  },
  "DrawScreen": {
    "tutorial_clear": "",
    "tutorial_double_tap_prediction": "",
    "tutorial_long_press_prediction": "",
    "tutorial_multi_search_double_tap": "",
    "tutorial_multi_search_short_press": "",
    "tutorial_predictions": "",
    "tutorial_skip": "",
  },
  "General": {
    "close": "",
    "dark": "",
    "light": "",
    "restarts_app": "",
    "web": ""
  },
  "HomeScreen": {
    "RatePopup_text": ""
  },
  "OnBoarding": {
    "Onboarding_1_title": "",
    "Onboarding_2_title": ""
  },
  "SettingsScreen": {
    "advanced_settings_title": "",
    "custom_url_format": "",
    "dictionary_system_translator": "",
    "empty_canvas_after_double_tap": "",
    "long_press_opens": "",
    "show_tutorial": "",
    "title": "",
  },
  "WebviewScreen": {
    "title": ""
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"cn": cn, "de": de, "en": en, "es": es, "fr": fr, "it": it, "jp": jp, "localizations": localizations, "ru": ru};
}

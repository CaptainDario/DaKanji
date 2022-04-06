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
    "show_changelog": "",
    "title": ""
  },
  "ChangelogScreen": {
  },
  "DrawScreen": {
    "tutorial_begin_continue": "",
    "tutorial_begin_title": "",
    "tutorial_dictionary_settings": "",
    "tutorial_drawing": "",
    "tutorial_multi_search": "",
    "tutorial_multi_search_long_press": "",
    "tutorial_multi_search_swipe_left": "",
    "tutorial_short_press_prediction": "",
    "tutorial_undo": ""
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
    "about_text": "DaKanji ist für alle, die Japanisch lernen oder benutzen.\nDaKanji ist verfügbar für, [iOS](APPSTORE_PAGE), [Android](PLAYSTORE_PAGE), [MacOS](MACSTORE_PAGE), [Linux (Snap)](SNAPSTORE_PAGE) und [Windows](MICROSOFT_STORE_PAGE)\nDu findest alle releases auch auf [GitHub.](GITHUB_RELEASES_PAGE)\n\nSchau dir auch meine [anderen Apps](DAAPPLAB_STORE_PAGE) an. \nFalls du Probleme mit der App hast oder Verbesserungsvorschläge, bitte öffne einen [GitHub-issue](GITHUB_ISSUES),\ntritt dem [Discordserver](DISCORD_SERVER) bei oder schicke eine [E-Mail](daapplab@gmail.com).\n\nDie Privacy policy kann [hier](PRIVACY_POLICE) gefunden werden.",
    "show_changelog": "Zeig mir alle Änderungen.",
    "software_informations_button": "Softwareinformationen",
    "title": "Über die App"
  },
  "ChangelogScreen": {
    "title": "Änderungen"
  },
  "DrawScreen": {
    "title": "Zeichnen",
    "tutorial_begin_continue": "Berühre, um fortzufahren...",
    "tutorial_begin_text": "Wir zeigen dir ein kurzes Tutorial damit du loslegen kannst.",
    "tutorial_begin_title": "Wilkommen zu der Zeichenerkennung!",
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
    "advanced_settings_drawing_inference_backend": "Inferenz Backend (manueller neugestartet notwendig)",
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
    "show_tutorial": "Zeige Tutorials erneut (@:General.restarts_app)",
    "theme": "Thema (@:General.restarts_app)",
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
    "about_text": "DaKanji helps students of the Japanese language and people who use it.\nDaKanji is available for, [iOS](APPSTORE_PAGE), [Android](PLAYSTORE_PAGE), [MacOS](MACSTORE_PAGE), [Linux (Snap)](SNAPSTORE_PAGE), [Windows](MICROSOFT_STORE_PAGE).\nYou can also find all releases on [GitHub.](GITHUB_RELEASES_PAGE).\n\nAlso check out [my other apps.](DAAPPLAB_STORE_PAGE)\nIf you have problems using this app or suggestions how to improve it please report them [here](GITHUB_ISSUES), join the [discord server](DISCORD_SERVER) or send an [e-mail](daapplab@gmail.com).\n\nThe privacy police can be found [here](PRIVACY_POLICE)",
    "show_changelog": "Show me the complete changelog.",
    "software_informations_button": "Software informations",
    "title": "About"
  },
  "ChangelogScreen": {
    "title": "Changelog"
  },
  "DrawScreen": {
    "title": "Drawing",
    "tutorial_begin_continue": "Tap to continue...",
    "tutorial_begin_text": "We will show you a quick tutorial to get you started.",
    "tutorial_begin_title": "Welcome to the drawing recognition!",
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
    "advanced_settings_drawing_inference_backend": "Inference backend (manual restart required)",
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
    "show_tutorial": "Reshow tutorials (@:General.restarts_app)",
    "theme": "theme (@:General.restarts_app)",
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
    "show_changelog": "",
    "title": ""
  },
  "ChangelogScreen": {
  },
  "DrawScreen": {
    "tutorial_begin_continue": "",
    "tutorial_begin_title": "",
    "tutorial_dictionary_settings": "",
    "tutorial_drawing": "",
    "tutorial_multi_search": "",
    "tutorial_multi_search_long_press": "",
    "tutorial_multi_search_swipe_left": "",
    "tutorial_short_press_prediction": "",
    "tutorial_undo": ""
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
    "show_changelog": "",
    "title": ""
  },
  "ChangelogScreen": {
  },
  "DrawScreen": {
    "tutorial_begin_continue": "",
    "tutorial_begin_title": "",
    "tutorial_dictionary_settings": "",
    "tutorial_drawing": "",
    "tutorial_multi_search": "",
    "tutorial_multi_search_long_press": "",
    "tutorial_multi_search_swipe_left": "",
    "tutorial_short_press_prediction": "",
    "tutorial_undo": ""
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
    "show_changelog": "",
    "title": ""
  },
  "ChangelogScreen": {
  },
  "DrawScreen": {
    "tutorial_begin_continue": "",
    "tutorial_begin_title": "",
    "tutorial_dictionary_settings": "",
    "tutorial_drawing": "",
    "tutorial_multi_search": "",
    "tutorial_multi_search_long_press": "",
    "tutorial_multi_search_swipe_left": "",
    "tutorial_short_press_prediction": "",
    "tutorial_undo": ""
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
    "show_changelog": "",
    "title": ""
  },
  "ChangelogScreen": {
  },
  "DrawScreen": {
    "tutorial_begin_continue": "",
    "tutorial_begin_title": "",
    "tutorial_dictionary_settings": "",
    "tutorial_drawing": "",
    "tutorial_multi_search": "",
    "tutorial_multi_search_long_press": "",
    "tutorial_multi_search_swipe_left": "",
    "tutorial_short_press_prediction": "",
    "tutorial_undo": ""
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
      "en": "DaKanji helps students of the Japanese language and people who use it.\nDaKanji is available for, [iOS](APPSTORE_PAGE), [Android](PLAYSTORE_PAGE), [MacOS](MACSTORE_PAGE), [Linux (Snap)](SNAPSTORE_PAGE), [Windows](MICROSOFT_STORE_PAGE).\nYou can also find all releases on [GitHub.](GITHUB_RELEASES_PAGE).\n\nAlso check out [my other apps.](DAAPPLAB_STORE_PAGE)\nIf you have problems using this app or suggestions how to improve it please report them [here](GITHUB_ISSUES), join the [discord server](DISCORD_SERVER) or send an [e-mail](daapplab@gmail.com).\n\nThe privacy police can be found [here](PRIVACY_POLICE)",
      "de": "DaKanji ist für alle, die Japanisch lernen oder benutzen.\nDaKanji ist verfügbar für, [iOS](APPSTORE_PAGE), [Android](PLAYSTORE_PAGE), [MacOS](MACSTORE_PAGE), [Linux (Snap)](SNAPSTORE_PAGE) und [Windows](MICROSOFT_STORE_PAGE)\nDu findest alle releases auch auf [GitHub.](GITHUB_RELEASES_PAGE)\n\nSchau dir auch meine [anderen Apps](DAAPPLAB_STORE_PAGE) an. \nFalls du Probleme mit der App hast oder Verbesserungsvorschläge, bitte öffne einen [GitHub-issue](GITHUB_ISSUES),\ntritt dem [Discordserver](DISCORD_SERVER) bei oder schicke eine [E-Mail](daapplab@gmail.com).\n\nDie Privacy policy kann [hier](PRIVACY_POLICE) gefunden werden.",
      "pl": "DaKanji stworzone jest, aby pomagać osobom uczącym się języka japońskiego oraz jego użytkownikom. \nAktualnie jest ono w stanie rozpoznać pismo odręczne takie jak 漢字 z 漢字検定 oraz ひらがな (również tą historyczną: ゑ, itp.) i カタカナ. \nFunkcjonalność aplikacji zostanie poprawiona w najbliższych wydaniach. DaKanji dostępne jest dla [iOS](IOS), [Android](PLAYSTORE_PAGE), [MacOS](MACSTORE_PAGE), [Linux (Snap)](SNAPSTORE_PAGE) i [Windows](MICROSOFT_STORE_PAGE).\n\nSprawdź inne [moje aplikacje](DAAPPLAB_STORE_PAGE). \nJeżeli napotkasz problemy korzystając ztej aplikacji, albo posiadasz sugestie na to jak ją poprawić, wyślij je [tutaj](GITHUB_ISSUES), dołącz na [serwer discord](DISCORD_SERVER) albo wyślij e-mail do daapplab@gmail.com. \nPolityka prywatności dostępna jest [tutaj](PRIVACY_POLICE)"
    },
    "show_changelog": {
      "en": "Show me the complete changelog.",
      "de": "Zeig mir alle Änderungen.",
      "pl": "Pokaż pełną historię zmian"
    },
    "software_informations_button": {
      "en": "Software informations",
      "de": "Softwareinformationen",
      "pl": "Informacje o oprogramowaniu"
    },
    "title": {
      "en": "About",
      "de": "Über die App",
      "pl": "O aplikacji"
    }
  },
  "ChangelogScreen": {
    "title": {
      "en": "Changelog",
      "de": "Änderungen",
      "pl": "Historia zmian"
    }
  },
  "DrawScreen": {
    "tutorial_begin_title": {
      "en": "Welcome to the drawing recognition!",
      "de": "Wilkommen zu der Zeichenerkennung!"
    },
    "tutorial_begin_text": {
      "en": "We will show you a quick tutorial to get you started.",
      "de": "Wir zeigen dir ein kurzes Tutorial damit du loslegen kannst."
    },
    "tutorial_begin_continue": {
      "en": "Tap to continue...",
      "de": "Berühre, um fortzufahren..."
    },
    "tutorial_clear": {
      "en": "Erases all strokes",
      "de": "Lösche all Striche",
      "pl": "Wyczyść wszystkie linie"
    },
    "tutorial_double_tap_prediction": {
      "en": "A Double Tap adds the character to the search box",
      "de": "Tippe doppelt um das Zeichen der Suchbox hinzuzufügen",
      "pl": "Podwójne kliknięcie dodaje znak do pola wyszukiwania"
    },
    "tutorial_drawing": {
      "en": "Draw a character here",
      "de": "Male ein Zeichen hier",
      "pl": "Tutaj namaluj znak"
    },
    "tutorial_long_press_prediction": {
      "en": "A long press opens the prediction in a dictionary",
      "de": "Lange auf eine Vorhersage drücken öffnet sie in einem Wörterbuch",
      "pl": "Przytrzymanie otwiera predykcję w słowniku"
    },
    "tutorial_multi_search_double_tap": {
      "en": "A double tap empties the field",
      "de": "Doppelt auf das Feld zutippen löscht den Inhalt",
      "pl": "Podwójne kliknięcie wymazuje znak"
    },
    "tutorial_multi_search_long_press": {
      "en": "A long press opens the characters in a dictionary",
      "de": "Lange auf die Suchbox zu klicken öffnet sie in einem Wörterbuch",
      "pl": "Przytrzymanie otwiera zawartość w słowniku"
    },
    "tutorial_multi_search_short_press": {
      "en": "A short press copies the characters to the clipboard",
      "de": "Kurz auf die Suchbox zu drücken kopiert die Zeichen in den Zwischenspeicher",
      "pl": "Kliknięcie kopiuje znak"
    },
    "tutorial_multi_search_swipe_left": {
      "en": "Swiping left on this field deletes the last character",
      "de": "Links auf der Suchbox zu swipen löscht das letzte Zeichen",
      "pl": "Przesunięcie w lewo usuwa ostatni znak"
    },
    "tutorial_multi_search": {
      "en": "Here you can search multiple characters at once",
      "de": "Mit dieser Suchbox können mehrere Zeichen auf einmal gesucht werden",
      "pl": "Tutaj możesz wyszukiwać wiele znaków na raz"
    },
    "tutorial_predictions": {
      "en": "The predicted characters will be shown here",
      "de": "Die vorhergesagten Zeichen werden hier angezeigt",
      "pl": "Przewidywane znaki dostępne będą tutaj"
    },
    "tutorial_short_press_prediction": {
      "en": "A short press copies the prediction",
      "de": "Einmal kurz drücken kopiert das vorhergesagte Zeichen",
      "pl": "Kliknięcie kopiuje znak"
    },
    "tutorial_skip": {
      "en": "SKIP",
      "de": "ÜBERSPRINGEN",
      "pl": "POMIŃ"
    },
    "tutorial_undo": {
      "en": "Press to undo the last stroke",
      "de": "Macht den letzten Strich rückgängig",
      "pl": "Kliknij aby cofnąć ostatnie pociągnięcie"
    },
    "tutorial_dictionary_settings": {
      "en": "In the settings the translation service can be chosen",
      "de": "In den Einstellung kann die Methode zum übersetzen gewählt werden",
      "pl": "W ustawieniach możliwe jest wybranie usługi tłumaczenia"
    },
    "title": {
      "en": "Drawing",
      "de": "Zeichnen",
      "pl": "Obraz"
    }
  },
  "General": {
    "app": {
      "en": "app",
      "de": "App",
      "pl": "aplikacja"
    },
    "close": {
      "en": "Close",
      "de": "Schließen",
      "pl": "Zamknij"
    },
    "custom_url": {
      "en": "custom URL",
      "de": "selbstdefinierte URL",
      "pl": "niestandardowy URL"
    },
    "dark": {
      "en": "dark",
      "de": "Dunkel",
      "pl": "ciemny"
    },
    "light": {
      "en": "light",
      "de": "Hell",
      "pl": "jasny"
    },
    "restarts_app": {
      "en": "restarts app",
      "de": "startet app neu",
      "pl": "restart aplikacji"
    },
    "system": {
      "en": "system",
      "de": "System",
      "pl": "system"
    },
    "web": {
      "en": "web",
      "de": "Web",
      "pl": "web"
    },
    "language": {
      "en": "language",
      "de": "Sprache",
      "pl": "język"
    },
    "rate_this_app": {
      "en": "Rate",
      "de": "Bewerte",
      "pl": "Oceń"
    }
  },
  "HomeScreen": {
    "RatePopup_dont_ask_again": {
      "en": "Not again!",
      "de": "Nie wieder!",
      "pl": "Nie powtarzaj!"
    },
    "RatePopup_text": {
      "en": "Do you like DaKanji?\nIf that is the case a rating would be awesome and it would help this project alot!",
      "de": "Es sieht so aus als würde dir DaKanji gefallen.\nFalls das stimmt würde eine Bewertung dem Projekt extrem weiter helfen!",
      "pl": "Lubisz DaKanji?\nJeżeli tak, to ocenienie aplikacji znacznie pomogłoby projektowi!"
    }
  },
  "OnBoarding": {
    "Onboarding_1_title": {
      "en": "You do not know a Kanji?",
      "de": "Du kennst ein Kanji nicht?",
      "pl": "Nie znasz Kanji?"
    },
    "Onboarding_1_text": {
      "en": "Just draw it and DaKanji will show the character you need.",
      "de": "Male es mit deinem Finger und DaKanji zeigt dir das Zeichen",
      "pl": "Po prostu go narysuj i DaKanji pokaże Ci znak którego potrzebujesz"
    },
    "Onboarding_2_title": {
      "en": "Lookup characters and words",
      "de": "Schlage Zeichen und Wörter nach",
      "pl": "Podejrzyj znaki i wyrazy"
    },
    "Onboarding_2_text": {
      "en": "With DaKanji you can quickly lookup words using web and app dictionaries.",
      "de": "Mit DaKanji kannst du schnell Wörter in Web- und App-Wörterbüchern nachschlagen",
      "pl": "Z DaKanji możesz szybko podglądnąć słówka używając internetu oraz słowników"
    }
  },
  "SettingsScreen": {
    "custom_url_hint": {
      "en": "URL of your dictionary",
      "de": "URL von dem Wörterbuch das benutzt werden soll",
      "pl": "URL twojego słownika"
    },
    "dictionary_system_translator": {
      "en": "OS integrated translator",
      "de": "betriebssysteminternes Übersetzer",
      "pl": "Tłumacz systemowy"
    },
    "drawing_title": {
      "en": "Drawing",
      "de": "Zeichnen",
      "pl": "Obraz"
    },
    "empty_canvas_after_double_tap": {
      "en": "Empty canvas after double tap",
      "de": "Lösche alle Striche nach doppeltem Tippen",
      "pl": "Puste płótno po podwójnym kliknięciu"
    },
    "invert_short_long_press": {
      "en": "Invert long/short press",
      "de": "Invertiere kurzes und langes drücken",
      "pl": "Odwróć długie/krótkie kliknięcie"
    },
    "long_press_opens": {
      "en": "Long press opens",
      "de": "Langes drücken öffnet",
      "pl": "Długie kliknięcie otwiera"
    },
    "miscellaneous_title": {
      "en": "Miscellaneous",
      "de": "Verschiedenes",
      "pl": "Inne"
    },
    "show_tutorial": {
      "en": "Reshow tutorials (@:General.restarts_app)",
      "de": "Zeige Tutorials erneut (@:General.restarts_app)",
      "pl": "Powtórz tutorial (@:General.restarts_app)"
    },
    "theme": {
      "en": "theme (@:General.restarts_app)",
      "de": "Thema (@:General.restarts_app)",
      "pl": "Motyw(@:General.restarts_app)"
    },
    "title": {
      "en": "Settings",
      "de": "Einstellungen",
      "pl": "Ustawienia"
    },
    "use_default_browser_for_online_dictionaries": {
      "en": "Use a webview for web dictionaries",
      "de": "Benutze einen webview für web Wörterbücher",
      "pl": "Użyj webview dla słowników internetowych"
    },
    "custom_url_format": {
      "en": "Custom URL format",
      "de": "Benutzerdefiniertes URL format",
      "pl": "Niestandardowy format URL"
    },
    "custom_url_explanation": {
      "en": "The app will replace a placeholder in the URL with the predicted character. This placeholder is: {kanjiPlaceholder}\n\nExample:\nThe predicted character is: '口' and you want to open it on 'jisho.org'. First you have to get the URL of the website for searching. In this case: 'https://jisho.org/search/口'. Now only the character in the URL has to be replaced with the placeholder. This leads to 'https://jisho.org/search/{kanjiPlaceholder}'.",
      "de": "Die App ersetzt einen Platzhalter in der gegbenen URL mit dem vorhergesagten Zeichen. Dieser Plathalter ist: {kanjiPlaceholder}\n\nBeispiel:\nDas vorhergesagte Zeichen ist: '口' und man wil es auf 'jisho.org' nachschlagen. Dafür muss als erste die URL der website, welche für das Suchen benutzt wird, herausgefunden werden. Für 'jisho.org' ist das: 'https://jisho.org/search/口'. Nun muss nur noch das Zeichen aus der URL mit dem Platzhalter ersetzt werden. Das führt zu 'https://jisho.org/search/{kanjiPlaceholder}'.",
      "pl": "Aplikacja podmieni symbol zastępczy predykowanym znakiem. Symbolem zastępczym jest: {kanjiPlaceholder}\n\nPrzykład:\nPredykowany znak to '口'  i chcemy otworzyć go na 'jisho.org'. Najpierw musimy posiadać adres URL strony internetowej wykorzystywany do wyszukiwania. W tym przypadku jest to 'https://jisho.org/search/口'. Teraz musimy podmienić jedynie znak na symbol zastępczy. Tym samym otrzymujemy 'https://jisho.org/search/{kanjiPlaceholder}'."
    },
    "advanced_settings_drawing_inference_backend": {
      "en": "Inference backend (manual restart required)",
      "de": "Inferenz Backend (manueller neugestartet notwendig)",
      "pl": "System wnioskowania (aplikacja musi zostać zrestartowana)"
    },
    "advanced_settings_title": {
      "en": "Advanced settings",
      "de": "Erweiterte Einstellungen",
      "pl": "Ustawienia zaawansowane"
    }
  },
  "WebviewScreen": {
    "loading": {
      "en": "Searching",
      "de": "Suche",
      "pl": "Ładowanie"
    },
    "title": {
      "en": "Webview",
      "de": "Webview",
      "pl": "Webview"
    }
  }
};
static const Map<String,dynamic> pl = {
  "AboutScreen": {
    "about_text": "DaKanji stworzone jest, aby pomagać osobom uczącym się języka japońskiego oraz jego użytkownikom. \nAktualnie jest ono w stanie rozpoznać pismo odręczne takie jak 漢字 z 漢字検定 oraz ひらがな (również tą historyczną: ゑ, itp.) i カタカナ. \nFunkcjonalność aplikacji zostanie poprawiona w najbliższych wydaniach. DaKanji dostępne jest dla [iOS](IOS), [Android](PLAYSTORE_PAGE), [MacOS](MACSTORE_PAGE), [Linux (Snap)](SNAPSTORE_PAGE) i [Windows](MICROSOFT_STORE_PAGE).\n\nSprawdź inne [moje aplikacje](DAAPPLAB_STORE_PAGE). \nJeżeli napotkasz problemy korzystając ztej aplikacji, albo posiadasz sugestie na to jak ją poprawić, wyślij je [tutaj](GITHUB_ISSUES), dołącz na [serwer discord](DISCORD_SERVER) albo wyślij e-mail do daapplab@gmail.com. \nPolityka prywatności dostępna jest [tutaj](PRIVACY_POLICE)",
    "show_changelog": "Pokaż pełną historię zmian",
    "software_informations_button": "Informacje o oprogramowaniu",
    "title": "O aplikacji"
  },
  "ChangelogScreen": {
    "title": "Historia zmian"
  },
  "DrawScreen": {
    "title": "Obraz",
    "tutorial_begin_text": "",
    "tutorial_clear": "Wyczyść wszystkie linie",
    "tutorial_dictionary_settings": "W ustawieniach możliwe jest wybranie usługi tłumaczenia",
    "tutorial_double_tap_prediction": "Podwójne kliknięcie dodaje znak do pola wyszukiwania",
    "tutorial_drawing": "Tutaj namaluj znak",
    "tutorial_long_press_prediction": "Przytrzymanie otwiera predykcję w słowniku",
    "tutorial_multi_search": "Tutaj możesz wyszukiwać wiele znaków na raz",
    "tutorial_multi_search_double_tap": "Podwójne kliknięcie wymazuje znak",
    "tutorial_multi_search_long_press": "Przytrzymanie otwiera zawartość w słowniku",
    "tutorial_multi_search_short_press": "Kliknięcie kopiuje znak",
    "tutorial_multi_search_swipe_left": "Przesunięcie w lewo usuwa ostatni znak",
    "tutorial_predictions": "Przewidywane znaki dostępne będą tutaj",
    "tutorial_short_press_prediction": "Kliknięcie kopiuje znak",
    "tutorial_skip": "POMIŃ",
    "tutorial_undo": "Kliknij aby cofnąć ostatnie pociągnięcie"
  },
  "General": {
    "app": "aplikacja",
    "close": "Zamknij",
    "custom_url": "niestandardowy URL",
    "dark": "ciemny",
    "language": "język",
    "light": "jasny",
    "rate_this_app": "Oceń",
    "restarts_app": "restart aplikacji",
    "system": "system",
    "web": "web"
  },
  "HomeScreen": {
    "RatePopup_dont_ask_again": "Nie powtarzaj!",
    "RatePopup_text": "Lubisz DaKanji?\nJeżeli tak, to ocenienie aplikacji znacznie pomogłoby projektowi!"
  },
  "OnBoarding": {
    "Onboarding_1_text": "Po prostu go narysuj i DaKanji pokaże Ci znak którego potrzebujesz",
    "Onboarding_1_title": "Nie znasz Kanji?",
    "Onboarding_2_text": "Z DaKanji możesz szybko podglądnąć słówka używając internetu oraz słowników",
    "Onboarding_2_title": "Podejrzyj znaki i wyrazy"
  },
  "SettingsScreen": {
    "advanced_settings_drawing_inference_backend": "System wnioskowania (aplikacja musi zostać zrestartowana)",
    "advanced_settings_title": "Ustawienia zaawansowane",
    "custom_url_explanation": "Aplikacja podmieni symbol zastępczy predykowanym znakiem. Symbolem zastępczym jest: {kanjiPlaceholder}\n\nPrzykład:\nPredykowany znak to '口'  i chcemy otworzyć go na 'jisho.org'. Najpierw musimy posiadać adres URL strony internetowej wykorzystywany do wyszukiwania. W tym przypadku jest to 'https://jisho.org/search/口'. Teraz musimy podmienić jedynie znak na symbol zastępczy. Tym samym otrzymujemy 'https://jisho.org/search/{kanjiPlaceholder}'.",
    "custom_url_format": "Niestandardowy format URL",
    "custom_url_hint": "URL twojego słownika",
    "dictionary_system_translator": "Tłumacz systemowy",
    "drawing_title": "Obraz",
    "empty_canvas_after_double_tap": "Puste płótno po podwójnym kliknięciu",
    "invert_short_long_press": "Odwróć długie/krótkie kliknięcie",
    "long_press_opens": "Długie kliknięcie otwiera",
    "miscellaneous_title": "Inne",
    "show_tutorial": "Powtórz tutorial (@:General.restarts_app)",
    "theme": "Motyw(@:General.restarts_app)",
    "title": "Ustawienia",
    "use_default_browser_for_online_dictionaries": "Użyj webview dla słowników internetowych"
  },
  "WebviewScreen": {
    "loading": "Ładowanie",
    "title": "Webview"
  }
};
static const Map<String,dynamic> ru = {
  "AboutScreen": {
    "show_changelog": "",
    "title": ""
  },
  "ChangelogScreen": {
  },
  "DrawScreen": {
    "tutorial_begin_continue": "",
    "tutorial_begin_title": "",
    "tutorial_dictionary_settings": "",
    "tutorial_drawing": "",
    "tutorial_multi_search": "",
    "tutorial_multi_search_long_press": "",
    "tutorial_multi_search_swipe_left": "",
    "tutorial_short_press_prediction": "",
    "tutorial_undo": ""
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
static const Map<String, Map<String,dynamic>> mapLocales = {"cn": cn, "de": de, "en": en, "es": es, "fr": fr, "it": it, "jp": jp, "localizations": localizations, "pl": pl, "ru": ru};
}

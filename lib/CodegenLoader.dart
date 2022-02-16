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

  static const Map<String,dynamic> de = {
  "DrawScreen": {
    "tutorial": {
      "clear": "Lösche all Striche",
      "double_tap_prediction": "Tippe doppelt um das Zeichen der Suchbox hinzuzufügen",
      "drawing": "Male ein Zeichen hier",
      "long_press_prediction": "Lange auf eine Vorhersage drücken öffnet sie in einem Wörterbuch",
      "multi_search_double_tap": "Doppelt auf das Feld zutippen löscht den Inhalt",
      "multi_search_long_press": "Lange auf die Suchbox zu klicken öffnet sie in einem Wörterbuch",
      "multi_search_short_press": "Kurz auf die Suchbox zu drücken kopiert die Zeichen in den Zwischenspeicher",
      "multi_search_swipe_left": "Links auf der Suchbox zu swipen löscht das letzte Zeichen",
      "multi_search": "Mit dieser Suchbox können mehrere Zeichen auf einmal gesucht werden",
      "predictions": "Die vorhergesagten Zeichen werden hier angezeigt",
      "short_press_prediction": "Einmal kurz drücken kopiert das vorhergesagte Zeichen",
      "skip": "ÜBERSPRINGEN",
      "undo": "Macht den letzten Strich rückgängig",
      "dictionary_settings": "In den Einstellung kann die Methode zum übersetzen gewählt werden"
    },
    "title": "Zeichnen"
  },
  "SettingsScreen": {
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
    "use_default_browser_for_online_dictionaries": "Benutze einen webview für web Wörterbücher",
    "custom_url_format": "Benutzerdefiniertes URL format",
    "custom_url_explanation": "Die App ersetzt einen Platzhalter in der gegbenen URL mit dem vorhergesagten Zeichen. Dieser Plathalter ist: {kanjiPlaceholder}\n\nBeispiel:\nDas vorhergesagte Zeichen ist: '口' und man wil es auf 'jisho.org' nachschlagen. Dafür muss als erste die URL der website, welche für das Suchen benutzt wird, herausgefunden werden. Für 'jisho.org' ist das: 'https://jisho.org/search/口'. Nun muss nur noch das Zeichen aus der URL mit dem Platzhalter ersetzt werden. Das führt zu 'https://jisho.org/search/{kanjiPlaceholder}'.",
    "language": "Sprache",
    "advanced_settings": {
      "drawing_inference_backend": "Inferenz Backend (die App muss neugestartet gestartet)",
      "title": "Erweiterte Einstellungen"
    }
  },
  "HomeScreen": {
    "RatePopup": {
      "close": "Schließen",
      "dont_ask_again": "Frag nie wieder",
      "rate": "Bewerten",
      "text": "Es sieht so aus als würde dir DaKanji gefallen.\nFalls das stimmt würde eine Bewertung dem Projekt extrem weiter helfen!"
    }
  },
  "app": "App",
  "web": "Web",
  "custom_url": "selbstdefinierte URL",
  "restarts_app": "startet app neu",
  "dark": "Dunkel",
  "light": "Hell",
  "system": "System",
  "AboutScreen": {
    "title": "Über die App",
    "rate_this_app": "Bewerte die App",
    "about_text": "DaKanji ist für alle die Japanisch lernen oder benutzen.\nMit DaKanji kann man handgeschriebene Zeichen nachschlagen. Im Moment können:\n\n- alle 漢字 von 漢字検定\n- ひらがな (auch Historische: ゑ, etc.)\n- カタカナ (auch Historische: ヱ, etc.)\n\nerkannt werden. \nIn der Zukunft wird der Funktionsumfang aber stark erweitert werden.\nEine Desktop version gibt es [hier.](GITHUB_DESKTOP_REPO)\nDaKanji wurde mit dart und dem Flutter framework entwickelt und steht unter einer \"source available\"-Lizenz.\nDas GitHub-repository kann [hier](GITHUB_MOBILE_REPO) gefunden werden.\nWenn du mehr über die machine learning Modelle efahren willst [schau hier.](GITHUB_ML_REPO)\n\nSchau dir auch meine [anderen apps](DAAPPLAB_STORE_PAGE) an. \nFalls du Probleme mit der App hast oder Verbesserungsvorschläge, bitte öffne einen [GitHub-issue](GITHUB_ISSUES) oder tritt dem [discord server](DISCORD_SERVER) bei.\n\nDie privacy police kann [hier](PRIVACY_POLICE) gefunden werden.",
    "show_changelog": "Zeig mir alle Änderungen.",
    "software_informations_button": "Softwareinformationen"
  },
  "ChangelogScreen": {
    "title": "Änderungen"
  },
  "WebviewScreen": {
    "loading": "Suche",
    "title": "Webview"
  },
  "close": "Schließen",
  "OnBoarding": {
    "Onboarding_1_title": "Du kennst ein Kanji nicht?",
    "Onboarding_1_text": "Male es mit deinem Finger und DaKanji zeigt dir das Zeichen",
    "Onboarding_2_text": "Mit DaKanji kannst du schnell Wörter in Web- und App-Wörterbüchern nachschlagen",
    "Onboarding_2_title": "Schlage Zeichen und Wörter nach"
  }
};
static const Map<String,dynamic> en = {
  "HomeScreen": {
    "RatePopup": {
      "text": "Do you like DaKanji?\nIf that is the case a rating would be awesome and it would help this project alot!",
      "dont_ask_again": "Do not ask again",
      "rate": "Rate",
      "close": "Close"
    }
  },
  "DrawScreen": {
    "title": "Drawing",
    "tutorial": {
      "clear": "Erases all strokes",
      "drawing": "Draw a character here",
      "undo": "Press to undo the last stroke",
      "predictions": "The predicted characters will be shown here",
      "short_press_prediction": "A short press copies the prediction",
      "long_press_prediction": "A long press opens the prediction in a dictionary",
      "multi_search": "Here you can search multiple characters at once",
      "double_tap_prediction": "A Double Tap adds the character to the search box",
      "multi_search_short_press": "A short press copies the characters to the clipboard",
      "skip": "SKIP",
      "multi_search_long_press": "A long press opens the characters in a dictionary",
      "multi_search_double_tap": "A double tap empties the field",
      "multi_search_swipe_left": "Swiping left on this field deletes the last character",
      "dictionary_settings": "In the settings the translation service can be chosen"
    }
  },
  "SettingsScreen": {
    "long_press_opens": "Long press opens",
    "drawing_title": "Drawing",
    "custom_url_hint": "URL of your dictionary",
    "custom_url_format": "Custom URL format",
    "custom_url_explanation": "The app will replace a placeholder in the URL with the predicted character. This placeholder is: {kanjiPlaceholder}\n\nExample:\nThe predicted character is: '口' and you want to open it on 'jisho.org'. First you have to get the URL of the website for searching. In this case: 'https://jisho.org/search/口'. Now only the character in the URL has to be replaced with the placeholder. This leads to 'https://jisho.org/search/{kanjiPlaceholder}'.",
    "invert_short_long_press": "Invert long/short press",
    "empty_canvas_after_double_tap": "Empty canvas after double tap",
    "use_default_browser_for_online_dictionaries": "Use a webview for web dictionaries",
    "miscellaneous_title": "Miscellaneous",
    "theme": "theme (@:restarts_app)",
    "show_tutorial": "Reshow tutorial (restarts app)",
    "title": "Settings",
    "dictionary_system_translator": "OS integrated translator",
    "language": "Language",
    "advanced_settings": {
      "drawing_inference_backend": "Inference backend (the app needs to be restarted)",
      "title": "Advanced settings"
    }
  },
  "app": "app",
  "web": "web",
  "custom_url": "custom URL",
  "restarts_app": "restarts app",
  "dark": "dark",
  "light": "light",
  "system": "system",
  "AboutScreen": {
    "title": "About",
    "rate_this_app": "Rate this app",
    "about_text": "DaKanji helps students of the Japanese language and people who use it.\nRight now it can recognize handwritten characters:\n\n- all 漢字 from 漢字検定\n- ひらがな (also historical ones: ゑ, etc.)\n- カタカナ (also historical ones: ヱ, etc.)\n\nBut the feature set will be vastly improved in the coming releases.\n\nA desktop version is available [here.](GITHUB_DESKTOP_REPO)\nThe app was developed using dart with the Flutter framework and is source available.\nIf you want to learn more about the development of the app, [visit its GitHub repository.](GITHUB_MOBILE_REPO)\nIf you want to learn more about the machine learning models powering this app, [take a look here.](GITHUB_ML_REPO)\n\nAlso check out [my other apps.](DAAPPLAB_STORE_PAGE)\nIf you have problems using this app or suggestions how to improve it please report them [here](GITHUB_ISSUES) or join the [discord server.](DISCORD_SERVER)\n\nThe privacy police can be found [here](PRIVACY_POLICE)",
    "show_changelog": "Show me the complete changelog.",
    "software_informations_button": "Software informations"
  },
  "ChangelogScreen": {
    "title": "Changelog"
  },
  "WebviewScreen": {
    "loading": "Searching",
    "title": "Webview"
  },
  "close": "Close",
  "OnBoarding": {
    "Onboarding_1_title": "You do not know a Kanji?",
    "Onboarding_1_text": "Just draw it and DaKanji will show the character you need.",
    "Onboarding_2_text": "With DaKanji you can quickly lookup words using web and app dictionaries.",
    "Onboarding_2_title": "Lookup characters and words"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"de": de, "en": en};
}

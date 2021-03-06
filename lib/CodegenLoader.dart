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
  "AboutScreen": {
    "about_text": "DaKanji ist für alle, die Japanisch lernen oder benutzen.\nDaKanji ist verfügbar für, [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}) und [Windows]({MICROSOFT_STORE_PAGE})\nDu findest alle releases auch auf [GitHub.]({GITHUB_RELEASES_PAGE})\n\nSchau dir auch meine [anderen Apps]({DAAPPLAB_STORE_PAGE}) an. \nFalls du Probleme mit der App hast oder Verbesserungsvorschläge, bitte öffne einen [GitHub-issue]({GITHUB_ISSUES}),\ntritt dem [Discordserver]({DISCORD_SERVER}) bei oder schicke eine [E-Mail](daapplab@gmail.com).\n\nDie Privacy policy kann [hier]({PRIVACY_POLICE}) gefunden werden.",
    "show_changelog": "Zeig mir alle Änderungen.",
    "software_informations_button": "Softwareinformationen",
    "title": "Über die App"
  },
  "ChangelogScreen": {
    "title": "Änderungen"
  },
  "DrawScreen": {
    "not_installed": "{DICTIONARY} nicht installiert",
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
    "complete_log": "vollständiges Log",
    "custom_url": "selbstdefinierte URL",
    "dark": "Dunkel",
    "download": "herunterladen",
    "language": "Sprache",
    "light": "Hell",
    "next": "Weiter",
    "rate_this_app": "Bewerte",
    "restarts_app": "startet app neu",
    "skip": "Überspingen",
    "system": "System",
    "web": "Web",
    "whats_new": "Was gibt's neues"
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
  "Overview": {
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
  "Stores": {
    "long_description": "Du lernst Japanisch? Dann musst du DaKanji ausprobieren.\r\n\r\nHast du schon mal versucht, einen japanischen Text zu lesen, aber kanntest ein Kanji nicht?\r\nDaKanji kann dir dabei helfen. Zeichne ein Kanji und die App wandelt es in einen digitales Zeichen um. Nicht einmal die Strichfolge ist wichtig! Male Zeichen und kombiniere sie zu Wörtern, die du dann übersetzen kannst und all das komplett offline.\r\n\r\nFunktionen:\r\n* Erkennt mehr als 6500 Kanji und alle Kana komplett offline\r\n* Benutze web und App Wörterbücher, um Zeichen und Wörter nachzuschlagen",
    "mockup_1_1": "Du kennst das Kanji nicht? Mal' es einfach!",
    "mockup_1_2": "Selbst die Strichfolge ist unwichtig.",
    "mockup_2": "Suche Wörter",
    "mockup_3": "Übersetze mit Wörterbüchern",
    "short_description": "Du lernst japanisch? Dann musst du DaKanji ausprobieren!\nFinde das Zeichen das du suchst einfach in dem du es malst.",
    "shortest_description": "Du lernst japanisch? Dann musst du DaKanji ausprobieren"
  },
  "WebviewScreen": {
    "loading": "Suche",
    "title": "Webview"
  }
};
static const Map<String,dynamic> en = {
  "AboutScreen": {
    "about_text": "DaKanji helps students of the Japanese language and people who use it.\nDaKanji is available for, [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}).\nYou can also find all releases on [GitHub.]({GITHUB_RELEASES_PAGE}).\n\nAlso check out [my other apps.]({DAAPPLAB_STORE_PAGE})\nIf you have problems using this app or suggestions how to improve it please report them [here]({GITHUB_ISSUES}), join the [discord server]({DISCORD_SERVER}) or send an [e-mail](daapplab@gmail.com).\n\nThe privacy police can be found [here]({PRIVACY_POLICE})",
    "show_changelog": "Show me the complete changelog.",
    "software_informations_button": "Software informations",
    "title": "About"
  },
  "ChangelogScreen": {
    "title": "Changelog"
  },
  "DrawScreen": {
    "not_installed": "{DICTIONARY} not installed",
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
    "complete_log": "complete log",
    "custom_url": "custom URL",
    "dark": "dark",
    "download": "download",
    "language": "language",
    "light": "light",
    "next": "next",
    "rate_this_app": "Rate",
    "restarts_app": "restarts app",
    "skip": "skip",
    "system": "system",
    "web": "web",
    "whats_new": "what's new"
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
  "Overview": {
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
  "Stores": {
    "long_description": "You are learning Japanese? Then you need to give DaKanji a try!\n\nDid you ever try to read a Japanese text but did not know how to read some Kanji? DaKanji is here to help you. Draw a Kanji and the app will convert it to a digital character. You do not even need to know the stroke order! Write characters and build words to then translate them, and all of that is completely offline.\n\nFeature overview:\n* Recognize 6500+ Kanji and all Kana offline\n* Use web and app dictionaries to translate characters or words",
    "mockup_1_1": "Don't know a Kanji? Just draw it!",
    "mockup_1_2": "Even the stroke order doesn't matter.",
    "mockup_2": "Search words",
    "mockup_3": "Translate with dictionaries",
    "short_description": "You are learning Japanese? Then you need to give DaKanji a try!\nFind characters and translate them just by drawing.",
    "shortest_description": "You are learning Japanese? Then you need to give DaKanji a try!"
  },
  "WebviewScreen": {
    "loading": "Searching",
    "title": "Webview"
  }
};
static const Map<String,dynamic> localizations = {
  "Overview": {
    "": {},
    "en": {},
    "de": {},
    "ru": {},
    "jp": {},
    "cn": {},
    "it": {},
    "fr": {},
    "es": {},
    "pl": {}
  },
  "Stores": {
    "shortest_description": {
      "en": "You are learning Japanese? Then you need to give DaKanji a try!",
      "de": "Du lernst japanisch? Dann musst du DaKanji ausprobieren",
      "es": "¿Estás aprendiendo Japonés? ¡Tienes que probar DaKanji!",
      "pl": "Uczysz się japońskiego? Musisz spróbować DaKanji!"
    },
    "short_description": {
      "en": "You are learning Japanese? Then you need to give DaKanji a try!\nFind characters and translate them just by drawing.",
      "de": "Du lernst japanisch? Dann musst du DaKanji ausprobieren!\nFinde das Zeichen das du suchst einfach in dem du es malst.",
      "es": "¿Estás aprendiendo Japonés? ¡Tienes que probar DaKanji!\nEncuentra carácteres y tradúcelos solamente dibujándolos.",
      "pl": "Uczysz się japońskiego? Musisz spróbować DaKanji!\nZa pomocą malowania możesz odnajdować i tłumaczyć znaki."
    },
    "long_description": {
      "en": "You are learning Japanese? Then you need to give DaKanji a try!\n\nDid you ever try to read a Japanese text but did not know how to read some Kanji? DaKanji is here to help you. Draw a Kanji and the app will convert it to a digital character. You do not even need to know the stroke order! Write characters and build words to then translate them, and all of that is completely offline.\n\nFeature overview:\n* Recognize 6500+ Kanji and all Kana offline\n* Use web and app dictionaries to translate characters or words",
      "de": "Du lernst Japanisch? Dann musst du DaKanji ausprobieren.\r\n\r\nHast du schon mal versucht, einen japanischen Text zu lesen, aber kanntest ein Kanji nicht?\r\nDaKanji kann dir dabei helfen. Zeichne ein Kanji und die App wandelt es in einen digitales Zeichen um. Nicht einmal die Strichfolge ist wichtig! Male Zeichen und kombiniere sie zu Wörtern, die du dann übersetzen kannst und all das komplett offline.\r\n\r\nFunktionen:\r\n* Erkennt mehr als 6500 Kanji und alle Kana komplett offline\r\n* Benutze web und App Wörterbücher, um Zeichen und Wörter nachzuschlagen",
      "es": "¿Estás aprendiendo Japonés? ¡Tienes que probar DaKanji!\n\n¿Alguna vez intentaste leer un texto en Japonés pero no sabías como leer un kanji? DaKanji está para ayudarte. Dibuja un kanji y la app lo convertirá en un carácter digital. ¡Ni siquiera debes saber el orden de los trazos! Escribe caracteres y construye palabras para luego traducirlas, y todo esto siendo completamente offline.\n\nCaracterísticas:\n* Reconocer más de 6500 Kanji y todos los Kana de manera offline\n* Poder usar apps de diccionarios o diccionarios en la web para traducir caracteres o palabras",
      "pl": "Uczysz się japońskiego? Musisz spróbować DaKanji!\n\nCzy próbowałeś kiedyś przeczytać tekst po japońsku ale nie wiedziałeś jak przeczytać niektóre Kanji? DaKanji jest tutaj żeby Ci z tym pomóc. Namaluj Kanji a aplikacja zmieni go w cyfrowy znak. Nie musisz znać kolejności pisania! Maluj znaki i buduj słowa które możesz później tłumaczyć, a to wszystko kompletnie offline.\n\nFunkcjonalności:\n* Rozpoznawanie 6500+ Kanji i całej Kany offline\n* Używaj słowników internetowych oraz aplikacji aby tłumaczyć znaki i słowa"
    },
    "mockup_1_1": {
      "en": "Don't know a Kanji? Just draw it!",
      "de": "Du kennst das Kanji nicht? Mal' es einfach!",
      "es": "¿No sabes un Kanji? ¡Solo dibújalo!",
      "pl": "Nie znasz Kanji? Po prostu je namaluj!"
    },
    "mockup_1_2": {
      "en": "Even the stroke order doesn't matter.",
      "de": "Selbst die Strichfolge ist unwichtig.",
      "es": "Ni siquiera importa el orden de los trazos.",
      "pl": "Kolejność malowania znaków nie ma znaczenia."
    },
    "mockup_2": {
      "en": "Search words",
      "de": "Suche Wörter",
      "es": "Busca palabras",
      "pl": "Wyszukuj słowa"
    },
    "mockup_3": {
      "en": "Translate with dictionaries",
      "de": "Übersetze mit Wörterbüchern",
      "es": "Traduce con diccionarios",
      "pl": "Tłumacz za pomocą słownika"
    },
    "mockup_4": {},
    "mockup_5": {},
    "mockup_6": {},
    "mockup_7": {},
    "mockup_8": {},
    "mockup_9": {},
    "mockup_10": {}
  },
  "AboutScreen": {
    "about_text": {
      "en": "DaKanji helps students of the Japanese language and people who use it.\nDaKanji is available for, [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}).\nYou can also find all releases on [GitHub.]({GITHUB_RELEASES_PAGE}).\n\nAlso check out [my other apps.]({DAAPPLAB_STORE_PAGE})\nIf you have problems using this app or suggestions how to improve it please report them [here]({GITHUB_ISSUES}), join the [discord server]({DISCORD_SERVER}) or send an [e-mail](daapplab@gmail.com).\n\nThe privacy police can be found [here]({PRIVACY_POLICE})",
      "de": "DaKanji ist für alle, die Japanisch lernen oder benutzen.\nDaKanji ist verfügbar für, [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}) und [Windows]({MICROSOFT_STORE_PAGE})\nDu findest alle releases auch auf [GitHub.]({GITHUB_RELEASES_PAGE})\n\nSchau dir auch meine [anderen Apps]({DAAPPLAB_STORE_PAGE}) an. \nFalls du Probleme mit der App hast oder Verbesserungsvorschläge, bitte öffne einen [GitHub-issue]({GITHUB_ISSUES}),\ntritt dem [Discordserver]({DISCORD_SERVER}) bei oder schicke eine [E-Mail](daapplab@gmail.com).\n\nDie Privacy policy kann [hier]({PRIVACY_POLICE}) gefunden werden.",
      "es": "DaKanji ayuda tanto a los estudiantes de Japonés como a los que lo usan.\nDaKanji está disponible para  [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}).\nAdemás, puedes encontrar todas las releases en [GitHub]({GITHUB_RELEASES_PAGE}).\n\nTambién puedes ver [mis otras apps.]({DAAPPLAB_STORE_PAGE})\nSi tienes problemas usando la app o tienes sugerencias para mejorarla, porfavor reportalas [aquí]({GITHUB_ISSUES}),   uniendote a nuestro [servidor de discord]({DISCORD_SERVER}) o enviando un (correo)(daapplab@gmail.com).\n\nPuedes encontrar la política de privacidad [aquí]({PRIVACY_POLICE})",
      "pl": "DaKanji stworzone jest, aby pomagać osobom uczącym się języka japońskiego oraz jego użytkownikom. \nDaKanji dostępne jest dla [iOS](IOS), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}) i [Windows]({MICROSOFT_STORE_PAGE}). \nWszystkie wersje możesz zobaczyć na [GitHub.]({GITHUB_RELEASES_PAGE}).\n\nSprawdź również inne [moje aplikacje]({DAAPPLAB_STORE_PAGE}). \nJeżeli napotkasz problemy korzystając z tej aplikacji, albo posiadasz sugestie na to jak ją poprawić, wyślij je [tutaj]({GITHUB_ISSUES}), dołącz na [serwer discord]({DISCORD_SERVER}) albo wyślij [e-mail](daapplab@gmail.com). \nPolityka prywatności dostępna jest [tutaj]({PRIVACY_POLICE})"
    },
    "show_changelog": {
      "en": "Show me the complete changelog.",
      "de": "Zeig mir alle Änderungen.",
      "es": "Muéstrame la lista de cambios completa.",
      "pl": "Pokaż pełną historię zmian"
    },
    "software_informations_button": {
      "en": "Software informations",
      "de": "Softwareinformationen",
      "es": "Información del software",
      "pl": "Informacje o oprogramowaniu"
    },
    "title": {
      "en": "About",
      "de": "Über die App",
      "es": "Acerca de",
      "pl": "O aplikacji"
    }
  },
  "ChangelogScreen": {
    "title": {
      "en": "Changelog",
      "de": "Änderungen",
      "es": "Lista de cambios",
      "pl": "Historia zmian"
    }
  },
  "HomeScreen": {
    "RatePopup_dont_ask_again": {
      "en": "Not again!",
      "de": "Nie wieder!",
      "ru": "deepl()",
      "es": "No de nuevo!",
      "pl": "Nie powtarzaj!"
    },
    "RatePopup_text": {
      "en": "Do you like DaKanji?\nIf that is the case a rating would be awesome and it would help this project alot!",
      "de": "Es sieht so aus als würde dir DaKanji gefallen.\nFalls das stimmt würde eine Bewertung dem Projekt extrem weiter helfen!",
      "ru": "asd",
      "es": "Te gusta DaKanji?\nSi ese es el caso, dejarnos una calificación sería genial y ayudaría mucho al proyecto!",
      "pl": "Lubisz DaKanji?\nJeżeli tak, to ocenienie aplikacji znacznie pomogłoby projektowi!"
    }
  },
  "DrawScreen": {
    "tutorial_begin_title": {
      "en": "Welcome to the drawing recognition!",
      "de": "Wilkommen zu der Zeichenerkennung!",
      "es": "Bienvenido al reconocimiento por dibujo!",
      "pl": "Witaj do rozpoznawania pisma!"
    },
    "tutorial_begin_text": {
      "en": "We will show you a quick tutorial to get you started.",
      "de": "Wir zeigen dir ein kurzes Tutorial damit du loslegen kannst.",
      "es": "Vamos a mostrarte un corto tutorial para que empieces.",
      "pl": "Pokażemy Ci krótki poradnik jak korzystać z aplikacji"
    },
    "tutorial_begin_continue": {
      "en": "Tap to continue...",
      "de": "Berühre, um fortzufahren...",
      "es": "Toca para continuar...",
      "pl": "Kliknij aby kontynuować..."
    },
    "tutorial_clear": {
      "en": "Erases all strokes",
      "de": "Lösche all Striche",
      "es": "Borrar todos los trazos",
      "pl": "Wyczyść wszystkie linie"
    },
    "tutorial_double_tap_prediction": {
      "en": "A Double Tap adds the character to the search box",
      "de": "Tippe doppelt um das Zeichen der Suchbox hinzuzufügen",
      "es": "Tocar dos veces para añadir el caracter a la barra de busqueda",
      "pl": "Podwójne kliknięcie dodaje znak do pola wyszukiwania"
    },
    "tutorial_drawing": {
      "en": "Draw a character here",
      "de": "Male ein Zeichen hier",
      "es": "Dibuja un caracter aquí",
      "pl": "Tutaj namaluj znak"
    },
    "tutorial_long_press_prediction": {
      "en": "A long press opens the prediction in a dictionary",
      "de": "Lange auf eine Vorhersage drücken öffnet sie in einem Wörterbuch",
      "es": "Una pulsación larga abre la predicción en un diccionario",
      "pl": "Przytrzymanie otwiera predykcję w słowniku"
    },
    "tutorial_multi_search_double_tap": {
      "en": "A double tap empties the field",
      "de": "Doppelt auf das Feld zutippen löscht den Inhalt",
      "es": "Una pulsación doble vacía el campo",
      "pl": "Podwójne kliknięcie wymazuje znak"
    },
    "tutorial_multi_search_long_press": {
      "en": "A long press opens the characters in a dictionary",
      "de": "Lange auf die Suchbox zu klicken öffnet sie in einem Wörterbuch",
      "es": "Una pulsación larga abre los caracteres en un diccionario",
      "pl": "Przytrzymanie otwiera zawartość w słowniku"
    },
    "tutorial_multi_search_short_press": {
      "en": "A short press copies the characters to the clipboard",
      "de": "Kurz auf die Suchbox zu drücken kopiert die Zeichen in den Zwischenspeicher",
      "es": "Una pulsación breve copia los caracteres al porta papeles",
      "pl": "Kliknięcie kopiuje znak"
    },
    "tutorial_multi_search_swipe_left": {
      "en": "Swiping left on this field deletes the last character",
      "de": "Links auf der Suchbox zu swipen löscht das letzte Zeichen",
      "es": "Deslizar a la izquierda para borrar el último caracter",
      "pl": "Przesunięcie w lewo usuwa ostatni znak"
    },
    "tutorial_multi_search": {
      "en": "Here you can search multiple characters at once",
      "de": "Mit dieser Suchbox können mehrere Zeichen auf einmal gesucht werden",
      "es": "Aquí puedes buscar buscar mutiples caracteres a la vez",
      "pl": "Tutaj możesz wyszukiwać wiele znaków na raz"
    },
    "tutorial_predictions": {
      "en": "The predicted characters will be shown here",
      "de": "Die vorhergesagten Zeichen werden hier angezeigt",
      "es": "Las predicciones se mostrarán aquí",
      "pl": "Przewidywane znaki dostępne będą tutaj"
    },
    "tutorial_short_press_prediction": {
      "en": "A short press copies the prediction",
      "de": "Einmal kurz drücken kopiert das vorhergesagte Zeichen",
      "es": "Una pulsación breve copia la predicción",
      "pl": "Kliknięcie kopiuje znak"
    },
    "tutorial_skip": {
      "en": "SKIP",
      "de": "ÜBERSPRINGEN",
      "es": "OMITIR",
      "pl": "POMIŃ"
    },
    "tutorial_undo": {
      "en": "Press to undo the last stroke",
      "de": "Macht den letzten Strich rückgängig",
      "es": "Presiona para deshacer el último trazo",
      "pl": "Kliknij aby cofnąć ostatnie pociągnięcie"
    },
    "tutorial_dictionary_settings": {
      "en": "In the settings the translation service can be chosen",
      "de": "In den Einstellung kann die Methode zum übersetzen gewählt werden",
      "es": "En los ajustes puedes seleccionar el servicio de traducción",
      "pl": "W ustawieniach możliwe jest wybranie usługi tłumaczenia"
    },
    "title": {
      "en": "Drawing",
      "de": "Zeichnen",
      "es": "Dibujo",
      "pl": "Obraz"
    },
    "not_installed": {
      "en": "{DICTIONARY} not installed",
      "de": "{DICTIONARY} nicht installiert",
      "es": "{DICTIONARY} no instalado",
      "pl": "{DICTIONARY} nie zainstalowany"
    }
  },
  "General": {
    "app": {
      "en": "app",
      "de": "App",
      "es": "aplicación",
      "pl": "aplikacja"
    },
    "close": {
      "en": "Close",
      "de": "Schließen",
      "es": "Cerrar",
      "pl": "Zamknij"
    },
    "custom_url": {
      "en": "custom URL",
      "de": "selbstdefinierte URL",
      "es": "URL personalizada",
      "pl": "niestandardowy URL"
    },
    "dark": {
      "en": "dark",
      "de": "Dunkel",
      "es": "oscuro",
      "pl": "ciemny"
    },
    "light": {
      "en": "light",
      "de": "Hell",
      "es": "claro",
      "pl": "jasny"
    },
    "restarts_app": {
      "en": "restarts app",
      "de": "startet app neu",
      "es": "reinicia la app",
      "pl": "restart aplikacji"
    },
    "system": {
      "en": "system",
      "de": "System",
      "es": "sistema",
      "pl": "system"
    },
    "web": {
      "en": "web",
      "de": "Web",
      "es": "web",
      "pl": "web"
    },
    "language": {
      "en": "language",
      "de": "Sprache",
      "es": "idioma",
      "pl": "język"
    },
    "rate_this_app": {
      "en": "Rate",
      "de": "Bewerte",
      "es": "Calificar",
      "pl": "Oceń"
    },
    "next": {
      "en": "next",
      "de": "Weiter",
      "es": "siguiente",
      "pl": "następny"
    },
    "skip": {
      "en": "skip",
      "de": "Überspingen",
      "es": "omitir",
      "pl": "pomiń"
    },
    "whats_new": {
      "en": "what's new",
      "de": "Was gibt's neues",
      "es": "qué hay de nuevo",
      "pl": "co nowego"
    },
    "complete_log": {
      "en": "complete log",
      "de": "vollständiges Log",
      "es": "registro completo",
      "pl": "pełny rejestr"
    },
    "download": {
      "en": "download",
      "de": "herunterladen",
      "es": "descargar",
      "pl": "pobierz"
    }
  },
  "OnBoarding": {
    "Onboarding_1_title": {
      "en": "You do not know a Kanji?",
      "de": "Du kennst ein Kanji nicht?",
      "es": "No sabes un Kanji?",
      "pl": "Nie znasz Kanji?"
    },
    "Onboarding_1_text": {
      "en": "Just draw it and DaKanji will show the character you need.",
      "de": "Male es mit deinem Finger und DaKanji zeigt dir das Zeichen",
      "es": "Solo dibújalo y DaKanji te mostrará el caracter que necesitas.",
      "pl": "Po prostu go narysuj i DaKanji pokaże Ci znak którego potrzebujesz"
    },
    "Onboarding_2_title": {
      "en": "Lookup characters and words",
      "de": "Schlage Zeichen und Wörter nach",
      "es": "Busca caracteres y palabras",
      "pl": "Podejrzyj znaki i wyrazy"
    },
    "Onboarding_2_text": {
      "en": "With DaKanji you can quickly lookup words using web and app dictionaries.",
      "de": "Mit DaKanji kannst du schnell Wörter in Web- und App-Wörterbüchern nachschlagen",
      "es": "Con DaKanji puedes buscar rápidamente palabras usando la web y diccionarios.",
      "pl": "Z DaKanji możesz szybko podglądnąć słówka używając internetu oraz słowników"
    }
  },
  "SettingsScreen": {
    "custom_url_hint": {
      "en": "URL of your dictionary",
      "de": "URL von dem Wörterbuch das benutzt werden soll",
      "es": "URL de tu diccionario",
      "pl": "URL twojego słownika"
    },
    "dictionary_system_translator": {
      "en": "OS integrated translator",
      "de": "betriebssysteminternes Übersetzer",
      "es": "Traductor integrado de tu SO",
      "pl": "Tłumacz systemowy"
    },
    "drawing_title": {
      "en": "Drawing",
      "de": "Zeichnen",
      "es": "Dibujar",
      "pl": "Obraz"
    },
    "empty_canvas_after_double_tap": {
      "en": "Empty canvas after double tap",
      "de": "Lösche alle Striche nach doppeltem Tippen",
      "es": "Vaciar lienzo después de una pulsación doble",
      "pl": "Puste płótno po podwójnym kliknięciu"
    },
    "invert_short_long_press": {
      "en": "Invert long/short press",
      "de": "Invertiere kurzes und langes drücken",
      "es": "Invertir pulsación larga/breve",
      "pl": "Odwróć długie/krótkie kliknięcie"
    },
    "long_press_opens": {
      "en": "Long press opens",
      "de": "Langes drücken öffnet",
      "es": "Pulsación larga abre",
      "pl": "Długie kliknięcie otwiera"
    },
    "miscellaneous_title": {
      "en": "Miscellaneous",
      "de": "Verschiedenes",
      "es": "Misceláneo",
      "pl": "Inne"
    },
    "show_tutorial": {
      "en": "Reshow tutorials (@:General.restarts_app)",
      "de": "Zeige Tutorials erneut (@:General.restarts_app)",
      "es": "Volver a mostrar el tutorial (@:General.restarts_app)",
      "pl": "Powtórz tutorial (@:General.restarts_app)"
    },
    "theme": {
      "en": "theme (@:General.restarts_app)",
      "de": "Thema (@:General.restarts_app)",
      "es": "tema (@:General.restarts_app)",
      "pl": "Motyw(@:General.restarts_app)"
    },
    "title": {
      "en": "Settings",
      "de": "Einstellungen",
      "es": "Ajustes",
      "pl": "Ustawienia"
    },
    "use_default_browser_for_online_dictionaries": {
      "en": "Use a webview for web dictionaries",
      "de": "Benutze einen webview für web Wörterbücher",
      "es": "Usar una webview para los diccionarios en la web",
      "pl": "Użyj webview dla słowników internetowych"
    },
    "custom_url_format": {
      "en": "Custom URL format",
      "de": "Benutzerdefiniertes URL format",
      "es": "Formato de la URL personalizada",
      "pl": "Niestandardowy format URL"
    },
    "custom_url_explanation": {
      "en": "The app will replace a placeholder in the URL with the predicted character. This placeholder is: {kanjiPlaceholder}\n\nExample:\nThe predicted character is: '口' and you want to open it on 'jisho.org'. First you have to get the URL of the website for searching. In this case: 'https://jisho.org/search/口'. Now only the character in the URL has to be replaced with the placeholder. This leads to 'https://jisho.org/search/{kanjiPlaceholder}'.",
      "de": "Die App ersetzt einen Platzhalter in der gegbenen URL mit dem vorhergesagten Zeichen. Dieser Plathalter ist: {kanjiPlaceholder}\n\nBeispiel:\nDas vorhergesagte Zeichen ist: '口' und man wil es auf 'jisho.org' nachschlagen. Dafür muss als erste die URL der website, welche für das Suchen benutzt wird, herausgefunden werden. Für 'jisho.org' ist das: 'https://jisho.org/search/口'. Nun muss nur noch das Zeichen aus der URL mit dem Platzhalter ersetzt werden. Das führt zu 'https://jisho.org/search/{kanjiPlaceholder}'.",
      "es": "La app va a reemplazar el comodín en la URL con la predicción. El comodín es: {kanjiPlaceholder}\n\nEjemplo:\nLa predicción es \"口\" y quieres abrirlo en \"jisho.org\". Primero tienes que buscar la URL de la página web que estás buscando. En este caso, \"https://jisho.org/口\". Ahora solo hay que reemplazar el caracter por el comodín. Esto es \"https://jisho.org/search/{kanjiPlaceholder}\".",
      "pl": "Aplikacja podmieni symbol zastępczy predykowanym znakiem. Symbolem zastępczym jest: {kanjiPlaceholder}\n\nPrzykład:\nPredykowany znak to '口'  i chcemy otworzyć go na 'jisho.org'. Najpierw musimy posiadać adres URL strony internetowej wykorzystywanej do wyszukiwania. W tym przypadku jest to 'https://jisho.org/search/口'. Następnie symbol zastępczy zostanie podmieniony na nasz znak. Tym samym otrzymujemy 'https://jisho.org/search/{kanjiPlaceholder}'."
    },
    "advanced_settings_drawing_inference_backend": {
      "en": "Inference backend (manual restart required)",
      "de": "Inferenz Backend (manueller neugestartet notwendig)",
      "es": "Backend de inferencia (reinicio manual requerido)",
      "pl": "System wnioskowania (aplikacja musi zostać zrestartowana)"
    },
    "advanced_settings_title": {
      "en": "Advanced settings",
      "de": "Erweiterte Einstellungen",
      "es": "Ajustes avanzados",
      "pl": "Ustawienia zaawansowane"
    }
  },
  "WebviewScreen": {
    "loading": {
      "en": "Searching",
      "de": "Suche",
      "es": "Buscando",
      "pl": "Ładowanie"
    },
    "title": {
      "en": "Webview",
      "de": "Webview",
      "es": "Webview",
      "pl": "Webview"
    }
  }
};
static const Map<String,dynamic> pl = {
  "AboutScreen": {
    "about_text": "DaKanji stworzone jest, aby pomagać osobom uczącym się języka japońskiego oraz jego użytkownikom. \nDaKanji dostępne jest dla [iOS](IOS), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}) i [Windows]({MICROSOFT_STORE_PAGE}). \nWszystkie wersje możesz zobaczyć na [GitHub.]({GITHUB_RELEASES_PAGE}).\n\nSprawdź również inne [moje aplikacje]({DAAPPLAB_STORE_PAGE}). \nJeżeli napotkasz problemy korzystając z tej aplikacji, albo posiadasz sugestie na to jak ją poprawić, wyślij je [tutaj]({GITHUB_ISSUES}), dołącz na [serwer discord]({DISCORD_SERVER}) albo wyślij [e-mail](daapplab@gmail.com). \nPolityka prywatności dostępna jest [tutaj]({PRIVACY_POLICE})",
    "show_changelog": "Pokaż pełną historię zmian",
    "software_informations_button": "Informacje o oprogramowaniu",
    "title": "O aplikacji"
  },
  "ChangelogScreen": {
    "title": "Historia zmian"
  },
  "DrawScreen": {
    "not_installed": "{DICTIONARY} nie zainstalowany",
    "title": "Obraz",
    "tutorial_begin_continue": "Kliknij aby kontynuować...",
    "tutorial_begin_text": "Pokażemy Ci krótki poradnik jak korzystać z aplikacji",
    "tutorial_begin_title": "Witaj do rozpoznawania pisma!",
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
    "complete_log": "pełny rejestr",
    "custom_url": "niestandardowy URL",
    "dark": "ciemny",
    "download": "pobierz",
    "language": "język",
    "light": "jasny",
    "next": "następny",
    "rate_this_app": "Oceń",
    "restarts_app": "restart aplikacji",
    "skip": "pomiń",
    "system": "system",
    "web": "web",
    "whats_new": "co nowego"
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
  "Overview": {
  },
  "SettingsScreen": {
    "advanced_settings_drawing_inference_backend": "System wnioskowania (aplikacja musi zostać zrestartowana)",
    "advanced_settings_title": "Ustawienia zaawansowane",
    "custom_url_explanation": "Aplikacja podmieni symbol zastępczy predykowanym znakiem. Symbolem zastępczym jest: {kanjiPlaceholder}\n\nPrzykład:\nPredykowany znak to '口'  i chcemy otworzyć go na 'jisho.org'. Najpierw musimy posiadać adres URL strony internetowej wykorzystywanej do wyszukiwania. W tym przypadku jest to 'https://jisho.org/search/口'. Następnie symbol zastępczy zostanie podmieniony na nasz znak. Tym samym otrzymujemy 'https://jisho.org/search/{kanjiPlaceholder}'.",
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
  "Stores": {
    "long_description": "Uczysz się japońskiego? Musisz spróbować DaKanji!\n\nCzy próbowałeś kiedyś przeczytać tekst po japońsku ale nie wiedziałeś jak przeczytać niektóre Kanji? DaKanji jest tutaj żeby Ci z tym pomóc. Namaluj Kanji a aplikacja zmieni go w cyfrowy znak. Nie musisz znać kolejności pisania! Maluj znaki i buduj słowa które możesz później tłumaczyć, a to wszystko kompletnie offline.\n\nFunkcjonalności:\n* Rozpoznawanie 6500+ Kanji i całej Kany offline\n* Używaj słowników internetowych oraz aplikacji aby tłumaczyć znaki i słowa",
    "mockup_1_1": "Nie znasz Kanji? Po prostu je namaluj!",
    "mockup_1_2": "Kolejność malowania znaków nie ma znaczenia.",
    "mockup_2": "Wyszukuj słowa",
    "mockup_3": "Tłumacz za pomocą słownika",
    "short_description": "Uczysz się japońskiego? Musisz spróbować DaKanji!\nZa pomocą malowania możesz odnajdować i tłumaczyć znaki.",
    "shortest_description": "Uczysz się japońskiego? Musisz spróbować DaKanji!"
  },
  "WebviewScreen": {
    "loading": "Ładowanie",
    "title": "Webview"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"de": de, "en": en, "localizations": localizations, "pl": pl};
}

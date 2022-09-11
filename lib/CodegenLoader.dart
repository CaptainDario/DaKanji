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
    "about_text": "\"DaKanji\" ist für alle, die Japanisch lernen oder benutzen.\n\"DaKanji\" ist verfügbar für, [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}) und [Windows]({MICROSOFT_STORE_PAGE})\nDu findest alle releases auch auf [GitHub.]({GITHUB_RELEASES_PAGE})\n\nSchau dir auch meine [anderen Apps]({DAAPPLAB_STORE_PAGE}) an. \nFalls du Probleme mit der App hast oder Verbesserungsvorschläge, bitte öffne einen [GitHub-issue]({GITHUB_ISSUES}),\ntritt dem [Discordserver]({DISCORD_SERVER}) bei oder schicke eine [E-Mail](daapplab@gmail.com).\n\nDie Privacy policy kann [hier]({PRIVACY_POLICE}) gefunden werden.",
    "credits": "Credits",
    "show_changelog": "Zeig mir alle Änderungen.",
    "software_informations_button": "Softwareinformationen",
    "title": "Über die App"
  },
  "ChangelogScreen": {
    "title": "Änderungen"
  },
  "Dictionary": {
    "title": "Wörterbuch"
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
    "advanced_settings_drawing_inference_backend": "Inferenz Backend (Neustart notwendig)",
    "advanced_settings_snap": "Ich bin unvermeidbar...",
    "advanced_settings_title": "Erweiterte Einstellungen",
    "custom_url_explanation": "Die App ersetzt einen Platzhalter in der gegbenen URL mit dem vorhergesagten Zeichen. Dieser Plathalter ist: {kanjiPlaceholder}\n\nBeispiel:\nDas vorhergesagte Zeichen ist: '口' und man wil es auf 'jisho.org' nachschlagen. Dafür muss als erste die URL der website, welche für das Suchen benutzt wird, herausgefunden werden. Für 'jisho.org' ist das: 'https://jisho.org/search/口'. Nun muss nur noch das Zeichen aus der URL mit dem Platzhalter ersetzt werden. Das führt zu 'https://jisho.org/search/{kanjiPlaceholder}'.",
    "custom_url_format": "Benutzerdefiniertes URL format",
    "custom_url_hint": "URL von dem Wörterbuch das benutzt werden soll",
    "dictionary_system_translator": "betriebssysteminternes Übersetzer",
    "drawing_title": "Zeichnen",
    "empty_canvas_after_double_tap": "Lösche alle Striche nach doppeltem Tippen",
    "invert_short_long_press": "Invertiere kurzes und langes drücken",
    "long_press_opens": "Langes drücken öffnet",
    "misc_settings_window_size": "Speicher die momentanige Fenster größe",
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
    "shortest_description": "Du lernst japanisch? Dann musst du DaKanji ausprobieren!\nFinde das Zeichen das du suchst, in dem du es malst."
  },
  "TextScreen": {
    "title": "Text"
  },
  "WebviewScreen": {
    "loading": "Suche",
    "title": "Webview"
  }
};
static const Map<String,dynamic> en = {
  "AboutScreen": {
    "about_text": "\"DaKanji\" helps students of the Japanese language and people who use it.\n\"DaKanji\" is available for, [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}).\nYou can also find all releases on [GitHub.]({GITHUB_RELEASES_PAGE}).\n\nAlso check out [my other apps.]({DAAPPLAB_STORE_PAGE})\nIf you have problems using this app or suggestions how to improve it please report them [here]({GITHUB_ISSUES}), join the [discord server]({DISCORD_SERVER}) or send an [e-mail](daapplab@gmail.com).\n\nThe privacy police can be found [here]({PRIVACY_POLICE})",
    "credits": "Credits",
    "show_changelog": "Show me the complete changelog.",
    "software_informations_button": "Software informations",
    "title": "About"
  },
  "ChangelogScreen": {
    "title": "Changelog"
  },
  "Dictionary": {
    "title": "Dictionary"
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
    "RatePopup_text": "Do you like \"DaKanji\"?\nIf that is the case a rating would be awesome and it would help this project a lot!"
  },
  "OnBoarding": {
    "Onboarding_1_text": "Just draw it and \"DaKanji\" will show the character you need.",
    "Onboarding_1_title": "You do not know a Kanji?",
    "Onboarding_2_text": "With \"DaKanji\" you can quickly lookup words using web and app dictionaries.",
    "Onboarding_2_title": "Lookup characters and words"
  },
  "Overview": {
  },
  "SettingsScreen": {
    "advanced_settings_drawing_inference_backend": "Inference backend (requires restart)",
    "advanced_settings_snap": "I am inevitable...",
    "advanced_settings_title": "Advanced settings",
    "custom_url_explanation": "The app will replace a placeholder in the URL with the predicted character. This placeholder is: {kanjiPlaceholder}\n\nExample:\nThe predicted character is: '口' and you want to open it on 'jisho.org'. First you have to get the URL of the website for searching. In this case: 'https://jisho.org/search/口'. Now only the character in the URL has to be replaced with the placeholder. This leads to 'https://jisho.org/search/{kanjiPlaceholder}'.",
    "custom_url_format": "Custom URL format",
    "custom_url_hint": "URL of your dictionary",
    "dictionary_system_translator": "OS integrated translator",
    "drawing_title": "Drawing",
    "empty_canvas_after_double_tap": "Empty canvas after double tap",
    "invert_short_long_press": "Invert long/short press",
    "long_press_opens": "Long press opens",
    "misc_settings_window_size": "Save current window size",
    "miscellaneous_title": "Miscellaneous",
    "show_tutorial": "Reshow tutorials (@:General.restarts_app)",
    "theme": "theme (@:General.restarts_app)",
    "title": "Settings",
    "use_default_browser_for_online_dictionaries": "Use a webview for web dictionaries"
  },
  "Stores": {
    "long_description": "You are learning Japanese? Then you need to give \"DaKanji\" a try!\n\nDid you ever try to read a Japanese text but did not know how to read some Kanji? \"DaKanji\" is here to help you. Draw a Kanji and the app will convert it to a digital character. You do not even need to know the stroke order! Write characters and build words to then translate them, and all of that is completely offline.\n\nFeature overview:\n* Recognize 6500+ Kanji and all Kana offline\n* Use web and app dictionaries to translate characters or words",
    "mockup_1_1": "Don't know a Kanji? Just draw it!",
    "mockup_1_2": "Even the stroke order doesn't matter.",
    "mockup_2": "Search words",
    "mockup_3": "Translate with dictionaries",
    "short_description": "You are learning Japanese? Then you need to give \"DaKanji\" a try!\nFind characters and translate them just by drawing.",
    "shortest_description": "You are learning Japanese? Then you need to give \"DaKanji\" a try!"
  },
  "TextScreen": {
    "title": "Text"
  },
  "WebviewScreen": {
    "loading": "Searching",
    "title": "Webview"
  }
};
static const Map<String,dynamic> es = {
  "AboutScreen": {
    "about_text": "DaKanji ayuda tanto a los estudiantes de Japonés como a los que lo usan.\nDaKanji está disponible para  [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}).\nAdemás, puedes encontrar todas las releases en [GitHub]({GITHUB_RELEASES_PAGE}).\n\nTambién puedes ver [mis otras apps.]({DAAPPLAB_STORE_PAGE})\nSi tienes problemas usando la app o tienes sugerencias para mejorarla, porfavor reportalas [aquí]({GITHUB_ISSUES}),   uniendote a nuestro [servidor de discord]({DISCORD_SERVER}) o enviando un (correo)(daapplab@gmail.com).\n\nPuedes encontrar la política de privacidad [aquí]({PRIVACY_POLICE})",
    "credits": "Créditos",
    "show_changelog": "Muéstrame la lista de cambios completa.",
    "software_informations_button": "Información del software",
    "title": "Acerca de"
  },
  "ChangelogScreen": {
    "title": "Lista de cambios"
  },
  "Dictionary": {
    "title": "Diccionario"
  },
  "DrawScreen": {
    "not_installed": "{DICTIONARY} no instalado",
    "title": "Dibujo",
    "tutorial_begin_continue": "Toca para continuar...",
    "tutorial_begin_text": "Vamos a mostrarte un corto tutorial para que empieces.",
    "tutorial_begin_title": "Bienvenido al reconocimiento por dibujo!",
    "tutorial_clear": "Borrar todos los trazos",
    "tutorial_dictionary_settings": "En los ajustes puedes seleccionar el servicio de traducción",
    "tutorial_double_tap_prediction": "Tocar dos veces para añadir el caracter a la barra de busqueda",
    "tutorial_drawing": "Dibuja un caracter aquí",
    "tutorial_long_press_prediction": "Una pulsación larga abre la predicción en un diccionario",
    "tutorial_multi_search": "Aquí puedes buscar buscar mutiples caracteres a la vez",
    "tutorial_multi_search_double_tap": "Una pulsación doble vacía el campo",
    "tutorial_multi_search_long_press": "Una pulsación larga abre los caracteres en un diccionario",
    "tutorial_multi_search_short_press": "Una pulsación breve copia los caracteres al porta papeles",
    "tutorial_multi_search_swipe_left": "Deslizar a la izquierda para borrar el último caracter",
    "tutorial_predictions": "Las predicciones se mostrarán aquí",
    "tutorial_short_press_prediction": "Una pulsación breve copia la predicción",
    "tutorial_skip": "OMITIR",
    "tutorial_undo": "Presiona para deshacer el último trazo"
  },
  "General": {
    "app": "aplicación",
    "close": "Cerrar",
    "complete_log": "registro completo",
    "custom_url": "URL personalizada",
    "dark": "oscuro",
    "download": "descargar",
    "language": "idioma",
    "light": "claro",
    "next": "siguiente",
    "rate_this_app": "Calificar",
    "restarts_app": "reinicia la app",
    "skip": "omitir",
    "system": "sistema",
    "web": "web",
    "whats_new": "qué hay de nuevo"
  },
  "HomeScreen": {
    "RatePopup_dont_ask_again": "No de nuevo!",
    "RatePopup_text": "Te gusta DaKanji?\nSi ese es el caso, dejarnos una calificación sería genial y ayudaría mucho al proyecto!"
  },
  "OnBoarding": {
    "Onboarding_1_text": "Solo dibújalo y DaKanji te mostrará el caracter que necesitas.",
    "Onboarding_1_title": "No sabes un Kanji?",
    "Onboarding_2_text": "Con DaKanji puedes buscar rápidamente palabras usando la web y diccionarios.",
    "Onboarding_2_title": "Busca caracteres y palabras"
  },
  "Overview": {
  },
  "SettingsScreen": {
    "advanced_settings_drawing_inference_backend": "Backend de inferencia (reinicio manual requerido)",
    "advanced_settings_snap": "Soy inevitable...",
    "advanced_settings_title": "Ajustes avanzados",
    "custom_url_explanation": "La app va a reemplazar el comodín en la URL con la predicción. El comodín es: {kanjiPlaceholder}\n\nEjemplo:\nLa predicción es \"口\" y quieres abrirlo en \"jisho.org\". Primero tienes que buscar la URL de la página web que estás buscando. En este caso, \"https://jisho.org/口\". Ahora solo hay que reemplazar el caracter por el comodín. Esto es \"https://jisho.org/search/{kanjiPlaceholder}\".",
    "custom_url_format": "Formato de la URL personalizada",
    "custom_url_hint": "URL de tu diccionario",
    "dictionary_system_translator": "Traductor integrado de tu SO",
    "drawing_title": "Dibujar",
    "empty_canvas_after_double_tap": "Vaciar lienzo después de una pulsación doble",
    "invert_short_long_press": "Invertir pulsación larga/breve",
    "long_press_opens": "Pulsación larga abre",
    "misc_settings_window_size": "Guardar el tamaño actual de la ventana",
    "miscellaneous_title": "Misceláneo",
    "show_tutorial": "Volver a mostrar el tutorial (@:General.restarts_app)",
    "theme": "tema (@:General.restarts_app)",
    "title": "Ajustes",
    "use_default_browser_for_online_dictionaries": "Usar una webview para los diccionarios en la web"
  },
  "Stores": {
    "long_description": "¿Estás aprendiendo Japonés? ¡Tienes que probar DaKanji!\n\n¿Alguna vez intentaste leer un texto en Japonés pero no sabías como leer un kanji? DaKanji está para ayudarte. Dibuja un kanji y la app lo convertirá en un carácter digital. ¡Ni siquiera debes saber el orden de los trazos! Escribe caracteres y construye palabras para luego traducirlas, y todo esto siendo completamente offline.\n\nCaracterísticas:\n* Reconocer más de 6500 Kanji y todos los Kana de manera offline\n* Poder usar apps de diccionarios o diccionarios en la web para traducir caracteres o palabras",
    "mockup_1_1": "¿No sabes un Kanji? ¡Solo dibújalo!",
    "mockup_1_2": "Ni siquiera importa el orden de los trazos.",
    "mockup_2": "Busca palabras",
    "mockup_3": "Traduce con diccionarios",
    "short_description": "¿Estás aprendiendo Japonés? ¡Tienes que probar DaKanji!\nEncuentra carácteres y tradúcelos solamente dibujándolos.",
    "shortest_description": "¿Estás aprendiendo Japonés? ¡Tienes que probar DaKanji!"
  },
  "TextScreen": {
    "title": "Texto"
  },
  "WebviewScreen": {
    "loading": "Buscando",
    "title": "Webview"
  }
};
static const Map<String,dynamic> fr = {
  "AboutScreen": {
    "about_text": "\"DaKanji\" aide les étudiants de la langue japonaise et les personnes qui l'utilisent.\n\"DaKanji est disponible pour [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}).\nVous pouvez également trouver toutes les versions sur [GitHub.]({GITHUB_RELEASES_PAGE}).\n\nConsultez également [mes autres applications]({DAAPPLAB_STORE_PAGE}).\nSi vous avez des problèmes d'utilisation de cette application ou des suggestions pour l'améliorer, veuillez les signaler [ici]({GITHUB_ISSUES}), rejoindre le [serveur discord]({DISCORD_SERVER}) ou envoyer un [e-mail](daapplab@gmail.com).\n\nLa police de la vie privée peut être trouvée [ici]({PRIVACY_POLICE}).",
    "credits": "Crédits",
    "show_changelog": "Montrez-moi le journal complet des modifications.",
    "software_informations_button": "Informations sur le logiciel",
    "title": "À propos de"
  },
  "ChangelogScreen": {
    "title": "Changelog"
  },
  "Dictionary": {
    "title": "Dictionnaire"
  },
  "DrawScreen": {
    "not_installed": "{DICTIONARY} non installé",
    "title": "Dessin",
    "tutorial_begin_continue": "Tapez pour continuer...",
    "tutorial_begin_text": "Nous allons vous montrer un tutoriel rapide pour vous aider à démarrer.",
    "tutorial_begin_title": "Bienvenue à la reconnaissance du dessin !",
    "tutorial_clear": "Efface tous les traits",
    "tutorial_dictionary_settings": "Dans les paramètres, le service de traduction peut être choisi",
    "tutorial_double_tap_prediction": "Un double tapotement ajoute le caractère au champ de recherche.",
    "tutorial_drawing": "Dessinez un personnage ici",
    "tutorial_long_press_prediction": "Une pression longue ouvre la prédiction dans un dictionnaire.",
    "tutorial_multi_search": "Ici, vous pouvez rechercher plusieurs caractères à la fois",
    "tutorial_multi_search_double_tap": "Un double tapotement vide le champ",
    "tutorial_multi_search_long_press": "Un appui long ouvre les caractères d'un dictionnaire",
    "tutorial_multi_search_short_press": "Une pression courte permet de copier les caractères dans le presse-papiers.",
    "tutorial_multi_search_swipe_left": "En glissant vers la gauche sur ce champ, vous supprimez le dernier caractère.",
    "tutorial_predictions": "Les caractères prédits seront affichés ici",
    "tutorial_short_press_prediction": "Une courte presse copie la prédiction",
    "tutorial_skip": "SKIP",
    "tutorial_undo": "Appuyez pour annuler le dernier trait"
  },
  "General": {
    "app": "application",
    "close": "Fermer",
    "complete_log": "journal complet",
    "custom_url": "URL personnalisée",
    "dark": "sombre",
    "download": "télécharger",
    "language": "langue",
    "light": "lumière",
    "next": "suivant",
    "rate_this_app": "Taux",
    "restarts_app": "redémarre l'application",
    "skip": "sauter",
    "system": "système",
    "web": "web",
    "whats_new": "Quoi de neuf ?"
  },
  "HomeScreen": {
    "RatePopup_dont_ask_again": "Pas encore !",
    "RatePopup_text": "Est-ce que vous aimez \"DaKanji\" ?\nSi c'est le cas, une évaluation serait géniale et cela aiderait beaucoup ce projet !"
  },
  "OnBoarding": {
    "Onboarding_1_text": "Il suffit de le dessiner et \"DaKanji\" affichera le caractère dont vous avez besoin.",
    "Onboarding_1_title": "Vous ne connaissez pas un Kanji ?",
    "Onboarding_2_text": "Avec \"DaKanji\", vous pouvez rechercher rapidement des mots en utilisant les dictionnaires du web et des applications.",
    "Onboarding_2_title": "Recherche de caractères et de mots"
  },
  "Overview": {
  },
  "SettingsScreen": {
    "advanced_settings_drawing_inference_backend": "Backend d'inférence (nécessite un redémarrage)",
    "advanced_settings_snap": "Je suis inévitable...",
    "advanced_settings_title": "Paramètres avancés",
    "custom_url_explanation": "L'application remplacera un caractère de remplacement dans l'URL par le caractère prédit. Ce caractère de remplacement est : {kanjiPlaceholder}\n\nExemple :\nLe caractère prédit est : '口' et vous voulez l'ouvrir sur 'jisho.org'. Tout d'abord, vous devez obtenir l'URL du site Web à rechercher. Dans ce cas : 'https://jisho.org/search/口'. Maintenant, seul le caractère dans l'URL doit être remplacé par le caractère de remplacement. Cela donne 'https://jisho.org/search/{kanjiPlaceholder}'.",
    "custom_url_format": "Format d'URL personnalisé",
    "custom_url_hint": "URL de votre dictionnaire",
    "dictionary_system_translator": "Traducteur intégré au système d'exploitation",
    "drawing_title": "Dessin",
    "empty_canvas_after_double_tap": "Toile vide après un double tapotement",
    "invert_short_long_press": "Inverser la presse long/short",
    "long_press_opens": "Une pression longue ouvre",
    "misc_settings_window_size": "Sauvegarder la taille actuelle de la fenêtre",
    "miscellaneous_title": "Divers",
    "show_tutorial": "Relancer les didacticiels (@:General.restarts_app)",
    "theme": "thème (@:General.restarts_app)",
    "title": "Paramètres",
    "use_default_browser_for_online_dictionaries": "Utiliser une vue web pour les dictionnaires web"
  },
  "Stores": {
    "long_description": "Vous apprenez le japonais ? Alors vous devez essayer \"DaKanji\" !\n\nAvez-vous déjà essayé de lire un texte japonais sans savoir comment lire certains Kanji ? \"DaKanji\" est là pour vous aider. Dessinez un Kanji et l'application le convertira en un caractère numérique. Vous n'avez même pas besoin de connaître l'ordre des traits ! Écrivez des caractères et construisez des mots pour ensuite les traduire, et tout cela est complètement hors ligne.\n\nAperçu des fonctionnalités :\n* Reconnaît 6500 Kanji et tous les Kana hors ligne.\n* Utilisez les dictionnaires du Web et des applications pour traduire des caractères ou des mots.",
    "mockup_1_1": "Vous ne connaissez pas un Kanji ? Il suffit de le dessiner !",
    "mockup_1_2": "Même l'ordre des coups n'a pas d'importance.",
    "mockup_2": "Mots à rechercher",
    "mockup_3": "Traduire avec des dictionnaires",
    "short_description": "Vous apprenez le japonais ? Alors vous devez essayer \"DaKanji\" !\nTrouvez des caractères et traduisez-les simplement en les dessinant.",
    "shortest_description": "Vous apprenez le japonais ? Alors vous devez essayer \"DaKanji\" !"
  },
  "TextScreen": {
    "title": "Texte"
  },
  "WebviewScreen": {
    "loading": "Recherche",
    "title": "Webview"
  }
};
static const Map<String,dynamic> it = {
  "AboutScreen": {
    "about_text": "\"DaKanji\" aiuta gli studenti della lingua giapponese e le persone che la utilizzano.\n\"DaKanji\" è disponibile per [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}).\nTutte le versioni sono disponibili anche su [GitHub]({GITHUB_RELEASES_PAGE}).\n\nDate anche un'occhiata a [le mie altre applicazioni] ({DAAPPLAB_STORE_PAGE}).\nSe avete problemi nell'utilizzo di questa applicazione o suggerimenti su come migliorarla, segnalateli [qui]({GITHUB_ISSUES}), unitevi al [server discord]({DISCORD_SERVER}) o inviate una [e-mail](daapplab@gmail.com).\n\nLa polizia della privacy può essere trovata [qui]({PRIVACY_POLICE})",
    "credits": "Crediti",
    "show_changelog": "Mostrami il changelog completo.",
    "software_informations_button": "Informazioni sul software",
    "title": "Circa"
  },
  "ChangelogScreen": {
    "title": "Changelog"
  },
  "Dictionary": {
    "title": "Dizionario"
  },
  "DrawScreen": {
    "not_installed": "{DICTIONARY} non installato",
    "title": "Disegno",
    "tutorial_begin_continue": "Toccare per continuare...",
    "tutorial_begin_text": "Vi mostreremo una rapida esercitazione per iniziare.",
    "tutorial_begin_title": "Benvenuti al riconoscimento del disegno!",
    "tutorial_clear": "Cancella tutti i tratti",
    "tutorial_dictionary_settings": "Nelle impostazioni è possibile scegliere il servizio di traduzione",
    "tutorial_double_tap_prediction": "Un doppio tocco aggiunge il carattere alla casella di ricerca.",
    "tutorial_drawing": "Disegnare un personaggio qui",
    "tutorial_long_press_prediction": "Una pressione prolungata apre la previsione in un dizionario.",
    "tutorial_multi_search": "Qui è possibile cercare più caratteri contemporaneamente",
    "tutorial_multi_search_double_tap": "Un doppio tocco svuota il campo",
    "tutorial_multi_search_long_press": "Una pressione prolungata apre i caratteri di un dizionario",
    "tutorial_multi_search_short_press": "Premendo brevemente si copiano i caratteri negli appunti.",
    "tutorial_multi_search_swipe_left": "Passando il dito a sinistra su questo campo si cancella l'ultimo carattere.",
    "tutorial_predictions": "I caratteri previsti saranno mostrati qui",
    "tutorial_short_press_prediction": "Una breve pressione copia la previsione",
    "tutorial_skip": "SALTA",
    "tutorial_undo": "Premere per annullare l'ultima pennellata"
  },
  "General": {
    "app": "app",
    "close": "Chiudere",
    "complete_log": "registro completo",
    "custom_url": "URL personalizzato",
    "dark": "scuro",
    "download": "scaricare",
    "language": "lingua",
    "light": "luce",
    "next": "prossimo",
    "rate_this_app": "Tasso",
    "restarts_app": "riavvia l'applicazione",
    "skip": "saltare",
    "system": "sistema",
    "web": "web",
    "whats_new": "cosa c'è di nuovo"
  },
  "HomeScreen": {
    "RatePopup_dont_ask_again": "Non di nuovo!",
    "RatePopup_text": "Ti piace \"DaKanji\"?\nSe è così, una valutazione sarebbe fantastica e aiuterebbe molto questo progetto!"
  },
  "OnBoarding": {
    "Onboarding_1_text": "Basta disegnarlo e \"DaKanji\" mostrerà il carattere desiderato.",
    "Onboarding_1_title": "Non conosci un kanji?",
    "Onboarding_2_text": "Con \"DaKanji\" è possibile cercare rapidamente le parole utilizzando dizionari web e app.",
    "Onboarding_2_title": "Ricerca di caratteri e parole"
  },
  "Overview": {
  },
  "SettingsScreen": {
    "advanced_settings_drawing_inference_backend": "Backend di inferenza (richiede il riavvio)",
    "advanced_settings_snap": "Sono inevitabile...",
    "advanced_settings_title": "Impostazioni avanzate",
    "custom_url_explanation": "L'applicazione sostituirà un segnaposto nell'URL con il carattere previsto. Questo segnaposto è: {kanjiPlaceholder}\n\nEsempio:\nIl carattere previsto è: \"口\" e si vuole aprire il sito \"jisho.org\". Per prima cosa è necessario ottenere l'URL del sito web per la ricerca. In questo caso: \"https://jisho.org/search/口\". Ora solo il carattere dell'URL deve essere sostituito con il segnaposto. Questo porta a 'https://jisho.org/search/{kanjiPlaceholder}'.",
    "custom_url_format": "Formato URL personalizzato",
    "custom_url_hint": "URL del vostro dizionario",
    "dictionary_system_translator": "Traduttore integrato nel sistema operativo",
    "drawing_title": "Disegno",
    "empty_canvas_after_double_tap": "Tela vuota dopo il doppio tocco",
    "invert_short_long_press": "Invertire la pressione lunga/corta",
    "long_press_opens": "La pressione prolungata apre",
    "misc_settings_window_size": "Salva la dimensione attuale della finestra",
    "miscellaneous_title": "Varie",
    "show_tutorial": "Ripresenta le esercitazioni (@:General.restarts_app)",
    "theme": "tema (@:General.restarts_app)",
    "title": "Impostazioni",
    "use_default_browser_for_online_dictionaries": "Utilizzare una webview per i dizionari web"
  },
  "Stores": {
    "long_description": "State imparando il giapponese? Allora dovete provare \"DaKanji\"!\n\nAvete mai provato a leggere un testo giapponese ma non sapete come leggere alcuni Kanji? \"DaKanji\" è qui per aiutarvi. Disegnate un Kanji e l'applicazione lo convertirà in un carattere digitale. Non è nemmeno necessario conoscere l'ordine dei tratti! Scrivete i caratteri e costruite le parole per poi tradurle, il tutto completamente offline.\n\nPanoramica delle funzioni:\n* Riconoscimento di 6500 Kanji e di tutti i Kana offline\n* Utilizza i dizionari del web e delle app per tradurre caratteri o parole",
    "mockup_1_1": "Non conosci un Kanji? Basta disegnarlo!",
    "mockup_1_2": "Anche l'ordine dei tratti non ha importanza.",
    "mockup_2": "Parole di ricerca",
    "mockup_3": "Tradurre con i dizionari",
    "short_description": "State imparando il giapponese? Allora dovete provare \"DaKanji\"!\nTrovate i caratteri e traduceteli semplicemente disegnando.",
    "shortest_description": "State imparando il giapponese? Allora dovete provare \"DaKanji\"!"
  },
  "TextScreen": {
    "title": "Testo"
  },
  "WebviewScreen": {
    "loading": "Ricerca",
    "title": "Vista sul web"
  }
};
static const Map<String,dynamic> ja = {
  "AboutScreen": {
    "about_text": "「大漢字」は、日本語を学ぶ人、日本語を使う人を支援します。\n「大漢字」は、[iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}) で使用することができます。\nまた、すべてのリリースは [GitHub.]({GITHUB_RELEASES_PAGE}) で見ることができます。\n\nまた、[私の他のアプリ]({DAAPPLAB_STORE_PAGE})もチェックしてください。\nこのアプリの使用上の問題や改善案があれば、[ここ]({GITHUB_ISSUES})、[discordサーバー]({DISCORD_SERVER})に参加するか、[メール](daapplab@gmail.com)で報告してください。\n\nプライバシーポリスは[こちら]({PRIVACY_POLICE})で確認できます。",
    "credits": "クレジット",
    "show_changelog": "完全なチェンジログを表示してください。",
    "software_informations_button": "ソフトウェア情報",
    "title": "について"
  },
  "ChangelogScreen": {
    "title": "チェンジログ"
  },
  "Dictionary": {
    "title": "辞書"
  },
  "DrawScreen": {
    "not_installed": "{DICTIONARY}はインストールされていません。",
    "title": "図面",
    "tutorial_begin_continue": "タップして続ける...",
    "tutorial_begin_text": "簡単なチュートリアルをお見せします。",
    "tutorial_begin_title": "描画認識へようこそ!",
    "tutorial_clear": "すべてのストロークの消去",
    "tutorial_dictionary_settings": "設定で翻訳サービスを選択することができます",
    "tutorial_double_tap_prediction": "ダブルタップすると、その文字が検索ボックスに追加されます",
    "tutorial_drawing": "ここにキャラクターを描いてください",
    "tutorial_long_press_prediction": "長押しで予測値が辞書で表示される",
    "tutorial_multi_search": "ここでは、複数の文字を一度に検索することができます",
    "tutorial_multi_search_double_tap": "ダブルタップでフィールドを空にする",
    "tutorial_multi_search_long_press": "長押しで辞書の文字が開く",
    "tutorial_multi_search_short_press": "短押しで文字がクリップボードにコピーされる",
    "tutorial_multi_search_swipe_left": "このフィールドを左にスワイプすると、最後の文字が削除されます。",
    "tutorial_predictions": "予測される文字はここに表示されます。",
    "tutorial_short_press_prediction": "短押は予測をコピーする",
    "tutorial_skip": "スキップ",
    "tutorial_undo": "を押して、最後のストロークを元に戻す"
  },
  "General": {
    "app": "アプリ",
    "close": "閉じる",
    "complete_log": "かんぜんログ",
    "custom_url": "カスタムURL",
    "dark": "暗い",
    "download": "ダウンロード",
    "language": "言語",
    "light": "ライト",
    "next": "次",
    "rate_this_app": "レート",
    "restarts_app": "アプリを再起動する",
    "skip": "跳躍",
    "system": "システム",
    "web": "ウェブ",
    "whats_new": "更新情報"
  },
  "HomeScreen": {
    "RatePopup_dont_ask_again": "またかよ！？",
    "RatePopup_text": "あなたは「DaKanji」が好きですか？\nもしそうなら、評価をいただけると、このプロジェクトの助けになります。"
  },
  "OnBoarding": {
    "Onboarding_1_text": "描くだけで、「DaKanji」が必要な文字を表示します。",
    "Onboarding_1_title": "漢字を知らないのですか？",
    "Onboarding_2_text": "「DaKanji」は、Webやアプリの辞書を使って素早く単語を調べることができます。",
    "Onboarding_2_title": "文字や言葉を調べる"
  },
  "Overview": {
  },
  "SettingsScreen": {
    "advanced_settings_drawing_inference_backend": "推論バックエンド（再起動が必要）",
    "advanced_settings_snap": "私は必然的に・・・。",
    "advanced_settings_title": "詳細設定",
    "custom_url_explanation": "このアプリは、URL内のプレースホルダーを予測される文字に置き換えます。このプレースホルダーは、{kanjiPlaceholder}です。\n\n例\n予測される文字は'口'で、'jisho.org'で開きたいとします。まず、検索対象のウェブサイトのURLを取得する必要があります。この場合、'https://jisho.org/search/口'です。ここで、URLの中の文字だけをプレースホルダーに置き換える必要があります。これは、'https://jisho.org/search/{kanjiPlaceholder}'につながります。",
    "custom_url_format": "カスタムURLフォーマット",
    "custom_url_hint": "お使いの辞書のURL",
    "dictionary_system_translator": "OS統合トランスレータ",
    "drawing_title": "図面",
    "empty_canvas_after_double_tap": "ダブルタップ後にキャンバスが空っぽになる",
    "invert_short_long_press": "インバートロング/ショートプレス",
    "long_press_opens": "長押しで開く",
    "misc_settings_window_size": "現在のウィンドウサイズを保存",
    "miscellaneous_title": "その他",
    "show_tutorial": "チュートリアルの再表示 (@:General.restarts_app)",
    "theme": "テーマ (@:General.restarts_app)",
    "title": "設定",
    "use_default_browser_for_online_dictionaries": "ウェブ辞書にウェブビューを使用する"
  },
  "Stores": {
    "long_description": "日本語を勉強しているんですか？それなら「DaKanji」を試してみる必要があります。\n\n日本語の文章を読もうとしたとき、漢字の読み方が分からなかったことはありませんか？「DaKanji」はそんなあなたのためにあります。漢字を描くと、それをデジタル文字に変換してくれます。書き順を知らなくても大丈夫です。漢字を書き、単語を作り、それを翻訳します。\n\n機能の概要\n* オフラインで6500字の漢字と全カナを認識します。\n* ウェブやアプリの辞書を利用して、文字や単語を翻訳することができます。",
    "mockup_1_1": "漢字がわからない？描けばいいじゃん",
    "mockup_1_2": "筆順さえも関係ない。",
    "mockup_2": "検索ワード",
    "mockup_3": "辞書を使った翻訳",
    "short_description": "日本語を勉強しているんですか？それなら「DaKanji」を試してみてください。\n絵を描くだけで、漢字を探し、翻訳することができます。",
    "shortest_description": "日本語を勉強しているんですか？それなら「DaKanji」を試してみる必要があります。"
  },
  "TextScreen": {
    "title": "テキスト"
  },
  "WebviewScreen": {
    "loading": "検索中",
    "title": "ウェブビュー"
  }
};
static const Map<String,dynamic> localizations = {
  "Overview": {
    "": {
      "A cell has a red background when there is no translation": "Stores",
      "A cell has a yellow background when the reference (English) localization was updated.": "AboutScreen",
      "A cell has a blue background when the translation was made by DeepL (and not checked)": "ChangelogScreen"
    },
    "en": {
      "A cell has a red background when there is no translation": "0 ; 0 ; 0",
      "A cell has a yellow background when the reference (English) localization was updated.": "0 ; 0 ; 0",
      "A cell has a blue background when the translation was made by DeepL (and not checked)": "0 ; 0 ; 0"
    },
    "de": {
      "A cell has a red background when there is no translation": "0 ; 0 ; 0",
      "A cell has a yellow background when the reference (English) localization was updated.": "0 ; 0 ; 0",
      "A cell has a blue background when the translation was made by DeepL (and not checked)": "0 ; 0 ; 0"
    },
    "ru": {
      "A cell has a red background when there is no translation": "0 ; 0 ; 7",
      "A cell has a yellow background when the reference (English) localization was updated.": "0 ; 0 ; 5",
      "A cell has a blue background when the translation was made by DeepL (and not checked)": "0 ; 0 ; 1"
    },
    "ja": {
      "A cell has a red background when there is no translation": "0 ; 0 ; 7",
      "A cell has a yellow background when the reference (English) localization was updated.": "0 ; 0 ; 5",
      "A cell has a blue background when the translation was made by DeepL (and not checked)": "0 ; 0 ; 1"
    },
    "zh": {
      "A cell has a red background when there is no translation": "0 ; 0 ; 7",
      "A cell has a yellow background when the reference (English) localization was updated.": "0 ; 0 ; 5",
      "A cell has a blue background when the translation was made by DeepL (and not checked)": "0 ; 0 ; 1"
    },
    "it": {
      "A cell has a red background when there is no translation": "0 ; 0 ; 7",
      "A cell has a yellow background when the reference (English) localization was updated.": "0 ; 0 ; 5",
      "A cell has a blue background when the translation was made by DeepL (and not checked)": "0 ; 0 ; 1"
    },
    "fr": {
      "A cell has a red background when there is no translation": "0 ; 0 ; 7",
      "A cell has a yellow background when the reference (English) localization was updated.": "0 ; 0 ; 5",
      "A cell has a blue background when the translation was made by DeepL (and not checked)": "0 ; 0 ; 1"
    },
    "es": {
      "A cell has a red background when there is no translation": "0 ; 0 ; 0",
      "A cell has a yellow background when the reference (English) localization was updated.": "0 ; 0 ; 1",
      "A cell has a blue background when the translation was made by DeepL (and not checked)": "0 ; 0 ; 0"
    },
    "pl": {
      "A cell has a red background when there is no translation": "0 ; 0 ; 0",
      "A cell has a yellow background when the reference (English) localization was updated.": "0 ; 0 ; 0",
      "A cell has a blue background when the translation was made by DeepL (and not checked)": "0 ; 0 ; 0"
    }
  },
  "Stores": {
    "shortest_description": {
      "en": "You are learning Japanese? Then you need to give \"DaKanji\" a try!",
      "de": "Du lernst japanisch? Dann musst du DaKanji ausprobieren!\nFinde das Zeichen das du suchst, in dem du es malst.",
      "ru": "Вы изучаете японский язык? Тогда вам нужно попробовать \"DaKanji\"!",
      "ja": "日本語を勉強しているんですか？それなら「DaKanji」を試してみる必要があります。",
      "zh": "你正在学习日语？那么你需要尝试一下 \"DaKanji\"!",
      "it": "State imparando il giapponese? Allora dovete provare \"DaKanji\"!",
      "fr": "Vous apprenez le japonais ? Alors vous devez essayer \"DaKanji\" !",
      "es": "¿Estás aprendiendo Japonés? ¡Tienes que probar DaKanji!",
      "pl": "Uczysz się japońskiego? Musisz spróbować DaKanji!"
    },
    "short_description": {
      "en": "You are learning Japanese? Then you need to give \"DaKanji\" a try!\nFind characters and translate them just by drawing.",
      "de": "Du lernst japanisch? Dann musst du DaKanji ausprobieren!\nFinde das Zeichen das du suchst einfach in dem du es malst.",
      "ru": "Вы изучаете японский язык? Тогда вам нужно попробовать \"DaKanji\"!\nНаходите иероглифы и переводите их, просто рисуя.",
      "ja": "日本語を勉強しているんですか？それなら「DaKanji」を試してみてください。\n絵を描くだけで、漢字を探し、翻訳することができます。",
      "zh": "你正在学习日语？那么你需要尝试一下 \"DaKanji\"!\n只需通过绘画就能找到字符并进行翻译。",
      "it": "State imparando il giapponese? Allora dovete provare \"DaKanji\"!\nTrovate i caratteri e traduceteli semplicemente disegnando.",
      "fr": "Vous apprenez le japonais ? Alors vous devez essayer \"DaKanji\" !\nTrouvez des caractères et traduisez-les simplement en les dessinant.",
      "es": "¿Estás aprendiendo Japonés? ¡Tienes que probar DaKanji!\nEncuentra carácteres y tradúcelos solamente dibujándolos.",
      "pl": "Uczysz się japońskiego? Musisz spróbować DaKanji!\nZa pomocą malowania możesz odnajdować i tłumaczyć znaki."
    },
    "long_description": {
      "en": "You are learning Japanese? Then you need to give \"DaKanji\" a try!\n\nDid you ever try to read a Japanese text but did not know how to read some Kanji? \"DaKanji\" is here to help you. Draw a Kanji and the app will convert it to a digital character. You do not even need to know the stroke order! Write characters and build words to then translate them, and all of that is completely offline.\n\nFeature overview:\n* Recognize 6500+ Kanji and all Kana offline\n* Use web and app dictionaries to translate characters or words",
      "de": "Du lernst Japanisch? Dann musst du DaKanji ausprobieren.\r\n\r\nHast du schon mal versucht, einen japanischen Text zu lesen, aber kanntest ein Kanji nicht?\r\nDaKanji kann dir dabei helfen. Zeichne ein Kanji und die App wandelt es in einen digitales Zeichen um. Nicht einmal die Strichfolge ist wichtig! Male Zeichen und kombiniere sie zu Wörtern, die du dann übersetzen kannst und all das komplett offline.\r\n\r\nFunktionen:\r\n* Erkennt mehr als 6500 Kanji und alle Kana komplett offline\r\n* Benutze web und App Wörterbücher, um Zeichen und Wörter nachzuschlagen",
      "ru": "Вы изучаете японский язык? Тогда вам нужно попробовать \"DaKanji\"!\n\nВы когда-нибудь пытались прочитать японский текст, но не знали, как прочитать некоторые кандзи? \"DaKanji\" поможет вам. Нарисуйте кандзи, и приложение преобразует его в цифровой символ. Вам даже не нужно знать порядок штрихов! Пишите иероглифы и стройте слова, чтобы затем перевести их, и все это совершенно автономно.\n\nОбзор функций:\n* Распознает 6500 кандзи и все кана в автономном режиме.\n* Использование веб-словарей и словарей приложений для перевода символов или слов",
      "ja": "日本語を勉強しているんですか？それなら「DaKanji」を試してみる必要があります。\n\n日本語の文章を読もうとしたとき、漢字の読み方が分からなかったことはありませんか？「DaKanji」はそんなあなたのためにあります。漢字を描くと、それをデジタル文字に変換してくれます。書き順を知らなくても大丈夫です。漢字を書き、単語を作り、それを翻訳します。\n\n機能の概要\n* オフラインで6500字の漢字と全カナを認識します。\n* ウェブやアプリの辞書を利用して、文字や単語を翻訳することができます。",
      "zh": "你正在学习日语？那么你需要尝试一下 \"DaKanji\"!\n\n你是否曾经试图阅读一篇日语文章，但不知道如何阅读一些汉字？\"DaKanji \"在这里帮助你。画一个汉字，这个应用程序将把它转换成一个数字字符。你甚至不需要知道笔画的顺序!写字和造词，然后翻译它们，所有这些都是完全离线的。\n\n特点概述。\n* 识别6500个汉字和所有假名的脱机字符\n* 使用网络和应用程序的字典来翻译字符或单词",
      "it": "State imparando il giapponese? Allora dovete provare \"DaKanji\"!\n\nAvete mai provato a leggere un testo giapponese ma non sapete come leggere alcuni Kanji? \"DaKanji\" è qui per aiutarvi. Disegnate un Kanji e l'applicazione lo convertirà in un carattere digitale. Non è nemmeno necessario conoscere l'ordine dei tratti! Scrivete i caratteri e costruite le parole per poi tradurle, il tutto completamente offline.\n\nPanoramica delle funzioni:\n* Riconoscimento di 6500 Kanji e di tutti i Kana offline\n* Utilizza i dizionari del web e delle app per tradurre caratteri o parole",
      "fr": "Vous apprenez le japonais ? Alors vous devez essayer \"DaKanji\" !\n\nAvez-vous déjà essayé de lire un texte japonais sans savoir comment lire certains Kanji ? \"DaKanji\" est là pour vous aider. Dessinez un Kanji et l'application le convertira en un caractère numérique. Vous n'avez même pas besoin de connaître l'ordre des traits ! Écrivez des caractères et construisez des mots pour ensuite les traduire, et tout cela est complètement hors ligne.\n\nAperçu des fonctionnalités :\n* Reconnaît 6500 Kanji et tous les Kana hors ligne.\n* Utilisez les dictionnaires du Web et des applications pour traduire des caractères ou des mots.",
      "es": "¿Estás aprendiendo Japonés? ¡Tienes que probar DaKanji!\n\n¿Alguna vez intentaste leer un texto en Japonés pero no sabías como leer un kanji? DaKanji está para ayudarte. Dibuja un kanji y la app lo convertirá en un carácter digital. ¡Ni siquiera debes saber el orden de los trazos! Escribe caracteres y construye palabras para luego traducirlas, y todo esto siendo completamente offline.\n\nCaracterísticas:\n* Reconocer más de 6500 Kanji y todos los Kana de manera offline\n* Poder usar apps de diccionarios o diccionarios en la web para traducir caracteres o palabras",
      "pl": "Uczysz się japońskiego? Musisz spróbować DaKanji!\n\nCzy próbowałeś kiedyś przeczytać tekst po japońsku ale nie wiedziałeś jak przeczytać niektóre Kanji? DaKanji jest tutaj żeby Ci z tym pomóc. Namaluj Kanji a aplikacja zmieni go w cyfrowy znak. Nie musisz znać kolejności pisania! Maluj znaki i buduj słowa które możesz później tłumaczyć, a to wszystko kompletnie offline.\n\nFunkcjonalności:\n* Rozpoznawanie 6500+ Kanji i całej Kany offline\n* Używaj słowników internetowych oraz aplikacji aby tłumaczyć znaki i słowa"
    },
    "mockup_1_1": {
      "en": "Don't know a Kanji? Just draw it!",
      "de": "Du kennst das Kanji nicht? Mal' es einfach!",
      "ru": "Не знаете кандзи? Просто нарисуйте его!",
      "ja": "漢字がわからない？描けばいいじゃん",
      "zh": "不知道一个汉字？就画出来吧!",
      "it": "Non conosci un Kanji? Basta disegnarlo!",
      "fr": "Vous ne connaissez pas un Kanji ? Il suffit de le dessiner !",
      "es": "¿No sabes un Kanji? ¡Solo dibújalo!",
      "pl": "Nie znasz Kanji? Po prostu je namaluj!"
    },
    "mockup_1_2": {
      "en": "Even the stroke order doesn't matter.",
      "de": "Selbst die Strichfolge ist unwichtig.",
      "ru": "Даже порядок штрихов не имеет значения.",
      "ja": "筆順さえも関係ない。",
      "zh": "甚至笔画顺序也不重要。",
      "it": "Anche l'ordine dei tratti non ha importanza.",
      "fr": "Même l'ordre des coups n'a pas d'importance.",
      "es": "Ni siquiera importa el orden de los trazos.",
      "pl": "Kolejność malowania znaków nie ma znaczenia."
    },
    "mockup_2": {
      "en": "Search words",
      "de": "Suche Wörter",
      "ru": "Поисковые слова",
      "ja": "検索ワード",
      "zh": "搜索词",
      "it": "Parole di ricerca",
      "fr": "Mots à rechercher",
      "es": "Busca palabras",
      "pl": "Wyszukuj słowa"
    },
    "mockup_3": {
      "en": "Translate with dictionaries",
      "de": "Übersetze mit Wörterbüchern",
      "ru": "Переводите с помощью словарей",
      "ja": "辞書を使った翻訳",
      "zh": "使用字典进行翻译",
      "it": "Tradurre con i dizionari",
      "fr": "Traduire avec des dictionnaires",
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
      "en": "\"DaKanji\" helps students of the Japanese language and people who use it.\n\"DaKanji\" is available for, [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}).\nYou can also find all releases on [GitHub.]({GITHUB_RELEASES_PAGE}).\n\nAlso check out [my other apps.]({DAAPPLAB_STORE_PAGE})\nIf you have problems using this app or suggestions how to improve it please report them [here]({GITHUB_ISSUES}), join the [discord server]({DISCORD_SERVER}) or send an [e-mail](daapplab@gmail.com).\n\nThe privacy police can be found [here]({PRIVACY_POLICE})",
      "de": "\"DaKanji\" ist für alle, die Japanisch lernen oder benutzen.\n\"DaKanji\" ist verfügbar für, [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}) und [Windows]({MICROSOFT_STORE_PAGE})\nDu findest alle releases auch auf [GitHub.]({GITHUB_RELEASES_PAGE})\n\nSchau dir auch meine [anderen Apps]({DAAPPLAB_STORE_PAGE}) an. \nFalls du Probleme mit der App hast oder Verbesserungsvorschläge, bitte öffne einen [GitHub-issue]({GITHUB_ISSUES}),\ntritt dem [Discordserver]({DISCORD_SERVER}) bei oder schicke eine [E-Mail](daapplab@gmail.com).\n\nDie Privacy policy kann [hier]({PRIVACY_POLICE}) gefunden werden.",
      "ru": "\"DaKanji\" помогает изучающим японский язык и людям, которые его используют.\n\"DaKanji\" доступен для [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}).\nВы также можете найти все релизы на [GitHub.]({GITHUB_RELEASES_PAGE}).\n\nТакже посмотрите [другие мои приложения]({DAAPPLAB_STORE_PAGE}).\nЕсли у вас есть проблемы с использованием этого приложения или предложения по его улучшению, пожалуйста, сообщите о них [здесь]({GITHUB_ISSUES}), присоединяйтесь к [discord серверу]({DISCORD_SERVER}) или отправьте [e-mail](daapplab@gmail.com).\n\nПолицию конфиденциальности можно найти [здесь]({PRIVACY_POLICE})",
      "ja": "「大漢字」は、日本語を学ぶ人、日本語を使う人を支援します。\n「大漢字」は、[iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}) で使用することができます。\nまた、すべてのリリースは [GitHub.]({GITHUB_RELEASES_PAGE}) で見ることができます。\n\nまた、[私の他のアプリ]({DAAPPLAB_STORE_PAGE})もチェックしてください。\nこのアプリの使用上の問題や改善案があれば、[ここ]({GITHUB_ISSUES})、[discordサーバー]({DISCORD_SERVER})に参加するか、[メール](daapplab@gmail.com)で報告してください。\n\nプライバシーポリスは[こちら]({PRIVACY_POLICE})で確認できます。",
      "zh": "\"大汉字 \"帮助日语学生和使用日语的人。\n\"大汉字 \"可用于，[iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}) 。\n你也可以在[GitHub.]({GITHUB_RELEASES_PAGE})上找到所有版本。\n\n还可以查看[我的其他应用程序。]({DAAPPLAB_STORE_PAGE})\n如果你在使用这个应用时有问题，或者对如何改进它有建议，请在[这里]({GITHUB_ISSUES})报告，加入[discord服务器]({DISCORD_SERVER})或发送[电子邮件](daapplab@gmail.com)。\n\n隐私警察可以在[这里]({PRIVACY_POLICE})找到。",
      "it": "\"DaKanji\" aiuta gli studenti della lingua giapponese e le persone che la utilizzano.\n\"DaKanji\" è disponibile per [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}).\nTutte le versioni sono disponibili anche su [GitHub]({GITHUB_RELEASES_PAGE}).\n\nDate anche un'occhiata a [le mie altre applicazioni] ({DAAPPLAB_STORE_PAGE}).\nSe avete problemi nell'utilizzo di questa applicazione o suggerimenti su come migliorarla, segnalateli [qui]({GITHUB_ISSUES}), unitevi al [server discord]({DISCORD_SERVER}) o inviate una [e-mail](daapplab@gmail.com).\n\nLa polizia della privacy può essere trovata [qui]({PRIVACY_POLICE})",
      "fr": "\"DaKanji\" aide les étudiants de la langue japonaise et les personnes qui l'utilisent.\n\"DaKanji est disponible pour [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}).\nVous pouvez également trouver toutes les versions sur [GitHub.]({GITHUB_RELEASES_PAGE}).\n\nConsultez également [mes autres applications]({DAAPPLAB_STORE_PAGE}).\nSi vous avez des problèmes d'utilisation de cette application ou des suggestions pour l'améliorer, veuillez les signaler [ici]({GITHUB_ISSUES}), rejoindre le [serveur discord]({DISCORD_SERVER}) ou envoyer un [e-mail](daapplab@gmail.com).\n\nLa police de la vie privée peut être trouvée [ici]({PRIVACY_POLICE}).",
      "es": "DaKanji ayuda tanto a los estudiantes de Japonés como a los que lo usan.\nDaKanji está disponible para  [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}).\nAdemás, puedes encontrar todas las releases en [GitHub]({GITHUB_RELEASES_PAGE}).\n\nTambién puedes ver [mis otras apps.]({DAAPPLAB_STORE_PAGE})\nSi tienes problemas usando la app o tienes sugerencias para mejorarla, porfavor reportalas [aquí]({GITHUB_ISSUES}),   uniendote a nuestro [servidor de discord]({DISCORD_SERVER}) o enviando un (correo)(daapplab@gmail.com).\n\nPuedes encontrar la política de privacidad [aquí]({PRIVACY_POLICE})",
      "pl": "DaKanji stworzone jest, aby pomagać osobom uczącym się języka japońskiego oraz jego użytkownikom. \nDaKanji dostępne jest dla [iOS](IOS), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}) i [Windows]({MICROSOFT_STORE_PAGE}). \nWszystkie wersje możesz zobaczyć na [GitHub.]({GITHUB_RELEASES_PAGE}).\n\nSprawdź również inne [moje aplikacje]({DAAPPLAB_STORE_PAGE}). \nJeżeli napotkasz problemy korzystając z tej aplikacji, albo posiadasz sugestie na to jak ją poprawić, wyślij je [tutaj]({GITHUB_ISSUES}), dołącz na [serwer discord]({DISCORD_SERVER}) albo wyślij [e-mail](daapplab@gmail.com). \nPolityka prywatności dostępna jest [tutaj]({PRIVACY_POLICE})"
    },
    "show_changelog": {
      "en": "Show me the complete changelog.",
      "de": "Zeig mir alle Änderungen.",
      "ru": "Покажите мне полный журнал изменений.",
      "ja": "完全なチェンジログを表示してください。",
      "zh": "给我看完整的更新日志。",
      "it": "Mostrami il changelog completo.",
      "fr": "Montrez-moi le journal complet des modifications.",
      "es": "Muéstrame la lista de cambios completa.",
      "pl": "Pokaż pełną historię zmian"
    },
    "software_informations_button": {
      "en": "Software informations",
      "de": "Softwareinformationen",
      "ru": "Информация о программном обеспечении",
      "ja": "ソフトウェア情報",
      "zh": "软件信息",
      "it": "Informazioni sul software",
      "fr": "Informations sur le logiciel",
      "es": "Información del software",
      "pl": "Informacje o oprogramowaniu"
    },
    "title": {
      "en": "About",
      "de": "Über die App",
      "ru": "О сайте",
      "ja": "について",
      "zh": "关于",
      "it": "Circa",
      "fr": "À propos de",
      "es": "Acerca de",
      "pl": "O aplikacji"
    },
    "credits": {
      "en": "Credits",
      "de": "Credits",
      "ru": "Кредиты",
      "ja": "クレジット",
      "zh": "贷方",
      "it": "Crediti",
      "fr": "Crédits",
      "es": "Créditos",
      "pl": "Podziękowania"
    }
  },
  "ChangelogScreen": {
    "title": {
      "en": "Changelog",
      "de": "Änderungen",
      "ru": "Changelog",
      "ja": "チェンジログ",
      "zh": "更新日志",
      "it": "Changelog",
      "fr": "Changelog",
      "es": "Lista de cambios",
      "pl": "Historia zmian"
    }
  },
  "HomeScreen": {
    "RatePopup_dont_ask_again": {
      "en": "Not again!",
      "de": "Nie wieder!",
      "ru": "Только не это!",
      "ja": "またかよ！？",
      "zh": "不要再来了!",
      "it": "Non di nuovo!",
      "fr": "Pas encore !",
      "es": "No de nuevo!",
      "pl": "Nie powtarzaj!"
    },
    "RatePopup_text": {
      "en": "Do you like \"DaKanji\"?\nIf that is the case a rating would be awesome and it would help this project a lot!",
      "de": "Es sieht so aus als würde dir DaKanji gefallen.\nFalls das stimmt würde eine Bewertung dem Projekt extrem weiter helfen!",
      "ru": "Вам нравится \"DaKanji\"?\nЕсли это так, то оценка была бы замечательной и очень помогла бы этому проекту!",
      "ja": "あなたは「DaKanji」が好きですか？\nもしそうなら、評価をいただけると、このプロジェクトの助けになります。",
      "zh": "你喜欢 \"DaKanji \"吗？\n如果是这样的话，评分将是非常棒的，它将对这个项目有很大的帮助!",
      "it": "Ti piace \"DaKanji\"?\nSe è così, una valutazione sarebbe fantastica e aiuterebbe molto questo progetto!",
      "fr": "Est-ce que vous aimez \"DaKanji\" ?\nSi c'est le cas, une évaluation serait géniale et cela aiderait beaucoup ce projet !",
      "es": "Te gusta DaKanji?\nSi ese es el caso, dejarnos una calificación sería genial y ayudaría mucho al proyecto!",
      "pl": "Lubisz DaKanji?\nJeżeli tak, to ocenienie aplikacji znacznie pomogłoby projektowi!"
    }
  },
  "DrawScreen": {
    "tutorial_begin_title": {
      "en": "Welcome to the drawing recognition!",
      "de": "Wilkommen zu der Zeichenerkennung!",
      "ru": "Добро пожаловать на распознавание рисунка!",
      "ja": "描画認識へようこそ!",
      "zh": "欢迎大家对绘画的认可!",
      "it": "Benvenuti al riconoscimento del disegno!",
      "fr": "Bienvenue à la reconnaissance du dessin !",
      "es": "Bienvenido al reconocimiento por dibujo!",
      "pl": "Witaj do rozpoznawania pisma!"
    },
    "tutorial_begin_text": {
      "en": "We will show you a quick tutorial to get you started.",
      "de": "Wir zeigen dir ein kurzes Tutorial damit du loslegen kannst.",
      "ru": "Мы покажем вам краткое руководство, чтобы вы могли начать.",
      "ja": "簡単なチュートリアルをお見せします。",
      "zh": "我们将向你展示一个快速教程，让你开始。",
      "it": "Vi mostreremo una rapida esercitazione per iniziare.",
      "fr": "Nous allons vous montrer un tutoriel rapide pour vous aider à démarrer.",
      "es": "Vamos a mostrarte un corto tutorial para que empieces.",
      "pl": "Pokażemy Ci krótki poradnik jak korzystać z aplikacji"
    },
    "tutorial_begin_continue": {
      "en": "Tap to continue...",
      "de": "Berühre, um fortzufahren...",
      "ru": "Нажмите, чтобы продолжить...",
      "ja": "タップして続ける...",
      "zh": "点击继续...",
      "it": "Toccare per continuare...",
      "fr": "Tapez pour continuer...",
      "es": "Toca para continuar...",
      "pl": "Kliknij aby kontynuować..."
    },
    "tutorial_clear": {
      "en": "Erases all strokes",
      "de": "Lösche all Striche",
      "ru": "Стирает все штрихи",
      "ja": "すべてのストロークの消去",
      "zh": "擦除所有笔画",
      "it": "Cancella tutti i tratti",
      "fr": "Efface tous les traits",
      "es": "Borrar todos los trazos",
      "pl": "Wyczyść wszystkie linie"
    },
    "tutorial_double_tap_prediction": {
      "en": "A Double Tap adds the character to the search box",
      "de": "Tippe doppelt um das Zeichen der Suchbox hinzuzufügen",
      "ru": "Двойное нажатие добавляет символ в поле поиска",
      "ja": "ダブルタップすると、その文字が検索ボックスに追加されます",
      "zh": "双击将该字符添加到搜索框中",
      "it": "Un doppio tocco aggiunge il carattere alla casella di ricerca.",
      "fr": "Un double tapotement ajoute le caractère au champ de recherche.",
      "es": "Tocar dos veces para añadir el caracter a la barra de busqueda",
      "pl": "Podwójne kliknięcie dodaje znak do pola wyszukiwania"
    },
    "tutorial_drawing": {
      "en": "Draw a character here",
      "de": "Male ein Zeichen hier",
      "ru": "Нарисуйте персонажа здесь",
      "ja": "ここにキャラクターを描いてください",
      "zh": "在这里画一个人物",
      "it": "Disegnare un personaggio qui",
      "fr": "Dessinez un personnage ici",
      "es": "Dibuja un caracter aquí",
      "pl": "Tutaj namaluj znak"
    },
    "tutorial_long_press_prediction": {
      "en": "A long press opens the prediction in a dictionary",
      "de": "Lange auf eine Vorhersage drücken öffnet sie in einem Wörterbuch",
      "ru": "Длительное нажатие открывает предсказание в словаре",
      "ja": "長押しで予測値が辞書で表示される",
      "zh": "长按可打开字典中的预测信息",
      "it": "Una pressione prolungata apre la previsione in un dizionario.",
      "fr": "Une pression longue ouvre la prédiction dans un dictionnaire.",
      "es": "Una pulsación larga abre la predicción en un diccionario",
      "pl": "Przytrzymanie otwiera predykcję w słowniku"
    },
    "tutorial_multi_search_double_tap": {
      "en": "A double tap empties the field",
      "de": "Doppelt auf das Feld zutippen löscht den Inhalt",
      "ru": "Двойное нажатие опустошает поле",
      "ja": "ダブルタップでフィールドを空にする",
      "zh": "双击就会清空该区域",
      "it": "Un doppio tocco svuota il campo",
      "fr": "Un double tapotement vide le champ",
      "es": "Una pulsación doble vacía el campo",
      "pl": "Podwójne kliknięcie wymazuje znak"
    },
    "tutorial_multi_search_long_press": {
      "en": "A long press opens the characters in a dictionary",
      "de": "Lange auf die Suchbox zu klicken öffnet sie in einem Wörterbuch",
      "ru": "Длительное нажатие открывает символы в словаре",
      "ja": "長押しで辞書の文字が開く",
      "zh": "长按可以打开字典中的字符",
      "it": "Una pressione prolungata apre i caratteri di un dizionario",
      "fr": "Un appui long ouvre les caractères d'un dictionnaire",
      "es": "Una pulsación larga abre los caracteres en un diccionario",
      "pl": "Przytrzymanie otwiera zawartość w słowniku"
    },
    "tutorial_multi_search_short_press": {
      "en": "A short press copies the characters to the clipboard",
      "de": "Kurz auf die Suchbox zu drücken kopiert die Zeichen in den Zwischenspeicher",
      "ru": "Короткое нажатие копирует символы в буфер обмена",
      "ja": "短押しで文字がクリップボードにコピーされる",
      "zh": "短暂的按下，将字符复制到剪贴板上",
      "it": "Premendo brevemente si copiano i caratteri negli appunti.",
      "fr": "Une pression courte permet de copier les caractères dans le presse-papiers.",
      "es": "Una pulsación breve copia los caracteres al porta papeles",
      "pl": "Kliknięcie kopiuje znak"
    },
    "tutorial_multi_search_swipe_left": {
      "en": "Swiping left on this field deletes the last character",
      "de": "Links auf der Suchbox zu swipen löscht das letzte Zeichen",
      "ru": "Свайп влево на этом поле удаляет последний символ",
      "ja": "このフィールドを左にスワイプすると、最後の文字が削除されます。",
      "zh": "在这个字段上向左滑动，会删除最后一个字符",
      "it": "Passando il dito a sinistra su questo campo si cancella l'ultimo carattere.",
      "fr": "En glissant vers la gauche sur ce champ, vous supprimez le dernier caractère.",
      "es": "Deslizar a la izquierda para borrar el último caracter",
      "pl": "Przesunięcie w lewo usuwa ostatni znak"
    },
    "tutorial_multi_search": {
      "en": "Here you can search multiple characters at once",
      "de": "Mit dieser Suchbox können mehrere Zeichen auf einmal gesucht werden",
      "ru": "Здесь вы можете искать сразу несколько символов",
      "ja": "ここでは、複数の文字を一度に検索することができます",
      "zh": "在这里，你可以一次搜索多个字符",
      "it": "Qui è possibile cercare più caratteri contemporaneamente",
      "fr": "Ici, vous pouvez rechercher plusieurs caractères à la fois",
      "es": "Aquí puedes buscar buscar mutiples caracteres a la vez",
      "pl": "Tutaj możesz wyszukiwać wiele znaków na raz"
    },
    "tutorial_predictions": {
      "en": "The predicted characters will be shown here",
      "de": "Die vorhergesagten Zeichen werden hier angezeigt",
      "ru": "Предсказанные символы будут показаны здесь",
      "ja": "予測される文字はここに表示されます。",
      "zh": "预测的字符将显示在这里",
      "it": "I caratteri previsti saranno mostrati qui",
      "fr": "Les caractères prédits seront affichés ici",
      "es": "Las predicciones se mostrarán aquí",
      "pl": "Przewidywane znaki dostępne będą tutaj"
    },
    "tutorial_short_press_prediction": {
      "en": "A short press copies the prediction",
      "de": "Einmal kurz drücken kopiert das vorhergesagte Zeichen",
      "ru": "Короткое нажатие копирует предсказание",
      "ja": "短押は予測をコピーする",
      "zh": "短暂的按语复制了预测的内容",
      "it": "Una breve pressione copia la previsione",
      "fr": "Une courte presse copie la prédiction",
      "es": "Una pulsación breve copia la predicción",
      "pl": "Kliknięcie kopiuje znak"
    },
    "tutorial_skip": {
      "en": "SKIP",
      "de": "ÜBERSPRINGEN",
      "ru": "ПРОПУСК",
      "ja": "スキップ",
      "zh": "撇开",
      "it": "SALTA",
      "fr": "SKIP",
      "es": "OMITIR",
      "pl": "POMIŃ"
    },
    "tutorial_undo": {
      "en": "Press to undo the last stroke",
      "de": "Macht den letzten Strich rückgängig",
      "ru": "Нажмите, чтобы отменить последний штрих",
      "ja": "を押して、最後のストロークを元に戻す",
      "zh": "按下撤消最后一笔",
      "it": "Premere per annullare l'ultima pennellata",
      "fr": "Appuyez pour annuler le dernier trait",
      "es": "Presiona para deshacer el último trazo",
      "pl": "Kliknij aby cofnąć ostatnie pociągnięcie"
    },
    "tutorial_dictionary_settings": {
      "en": "In the settings the translation service can be chosen",
      "de": "In den Einstellung kann die Methode zum übersetzen gewählt werden",
      "ru": "В настройках можно выбрать службу перевода",
      "ja": "設定で翻訳サービスを選択することができます",
      "zh": "在设置中，可以选择翻译服务",
      "it": "Nelle impostazioni è possibile scegliere il servizio di traduzione",
      "fr": "Dans les paramètres, le service de traduction peut être choisi",
      "es": "En los ajustes puedes seleccionar el servicio de traducción",
      "pl": "W ustawieniach możliwe jest wybranie usługi tłumaczenia"
    },
    "title": {
      "en": "Drawing",
      "de": "Zeichnen",
      "ru": "Рисование",
      "ja": "図面",
      "zh": "绘图",
      "it": "Disegno",
      "fr": "Dessin",
      "es": "Dibujo",
      "pl": "Obraz"
    },
    "not_installed": {
      "en": "{DICTIONARY} not installed",
      "de": "{DICTIONARY} nicht installiert",
      "ru": "{DICTIONARY} не установлен",
      "ja": "{DICTIONARY}はインストールされていません。",
      "zh": "未安装{DICTIONARY}。",
      "it": "{DICTIONARY} non installato",
      "fr": "{DICTIONARY} non installé",
      "es": "{DICTIONARY} no instalado",
      "pl": "{DICTIONARY} nie zainstalowany"
    }
  },
  "TextScreen": {
    "title": {
      "en": "Text",
      "de": "Text",
      "ru": "Текст",
      "ja": "テキスト",
      "zh": "文本",
      "it": "Testo",
      "fr": "Texte",
      "es": "Texto",
      "pl": "Tekst"
    }
  },
  "Dictionary": {
    "title": {
      "en": "Dictionary",
      "de": "Wörterbuch",
      "ru": "Словарь",
      "ja": "辞書",
      "zh": "词典",
      "it": "Dizionario",
      "fr": "Dictionnaire",
      "es": "Diccionario",
      "pl": "Słownik"
    }
  },
  "General": {
    "app": {
      "en": "app",
      "de": "App",
      "ru": "приложение",
      "ja": "アプリ",
      "zh": "应用程序",
      "it": "app",
      "fr": "application",
      "es": "aplicación",
      "pl": "aplikacja"
    },
    "close": {
      "en": "Close",
      "de": "Schließen",
      "ru": "Закрыть",
      "ja": "閉じる",
      "zh": "关闭",
      "it": "Chiudere",
      "fr": "Fermer",
      "es": "Cerrar",
      "pl": "Zamknij"
    },
    "custom_url": {
      "en": "custom URL",
      "de": "selbstdefinierte URL",
      "ru": "пользовательский URL",
      "ja": "カスタムURL",
      "zh": "自定义URL",
      "it": "URL personalizzato",
      "fr": "URL personnalisée",
      "es": "URL personalizada",
      "pl": "niestandardowy URL"
    },
    "dark": {
      "en": "dark",
      "de": "Dunkel",
      "ru": "темный",
      "ja": "暗い",
      "zh": "黑",
      "it": "scuro",
      "fr": "sombre",
      "es": "oscuro",
      "pl": "ciemny"
    },
    "light": {
      "en": "light",
      "de": "Hell",
      "ru": "свет",
      "ja": "ライト",
      "zh": "光",
      "it": "luce",
      "fr": "lumière",
      "es": "claro",
      "pl": "jasny"
    },
    "restarts_app": {
      "en": "restarts app",
      "de": "startet app neu",
      "ru": "перезапускает приложение",
      "ja": "アプリを再起動する",
      "zh": "重新启动应用程序",
      "it": "riavvia l'applicazione",
      "fr": "redémarre l'application",
      "es": "reinicia la app",
      "pl": "restart aplikacji"
    },
    "system": {
      "en": "system",
      "de": "System",
      "ru": "система",
      "ja": "システム",
      "zh": "系统",
      "it": "sistema",
      "fr": "système",
      "es": "sistema",
      "pl": "system"
    },
    "web": {
      "en": "web",
      "de": "Web",
      "ru": "веб-сайт",
      "ja": "ウェブ",
      "zh": "网络",
      "it": "web",
      "fr": "web",
      "es": "web",
      "pl": "web"
    },
    "language": {
      "en": "language",
      "de": "Sprache",
      "ru": "язык",
      "ja": "言語",
      "zh": "语言",
      "it": "lingua",
      "fr": "langue",
      "es": "idioma",
      "pl": "język"
    },
    "rate_this_app": {
      "en": "Rate",
      "de": "Bewerte",
      "ru": "Тариф",
      "ja": "レート",
      "zh": "速率",
      "it": "Tasso",
      "fr": "Taux",
      "es": "Calificar",
      "pl": "Oceń"
    },
    "next": {
      "en": "next",
      "de": "Weiter",
      "ru": "следующий",
      "ja": "次",
      "zh": "下一个",
      "it": "prossimo",
      "fr": "suivant",
      "es": "siguiente",
      "pl": "następny"
    },
    "skip": {
      "en": "skip",
      "de": "Überspingen",
      "ru": "пропустить",
      "ja": "跳躍",
      "zh": "跳过",
      "it": "saltare",
      "fr": "sauter",
      "es": "omitir",
      "pl": "pomiń"
    },
    "whats_new": {
      "en": "what's new",
      "de": "Was gibt's neues",
      "ru": "что нового",
      "ja": "更新情報",
      "zh": "最新信息",
      "it": "cosa c'è di nuovo",
      "fr": "Quoi de neuf ?",
      "es": "qué hay de nuevo",
      "pl": "co nowego"
    },
    "complete_log": {
      "en": "complete log",
      "de": "vollständiges Log",
      "ru": "полный журнал",
      "ja": "かんぜんログ",
      "zh": "完整日志",
      "it": "registro completo",
      "fr": "journal complet",
      "es": "registro completo",
      "pl": "pełny rejestr"
    },
    "download": {
      "en": "download",
      "de": "herunterladen",
      "ru": "скачать",
      "ja": "ダウンロード",
      "zh": "下载",
      "it": "scaricare",
      "fr": "télécharger",
      "es": "descargar",
      "pl": "pobierz"
    }
  },
  "OnBoarding": {
    "Onboarding_1_title": {
      "en": "You do not know a Kanji?",
      "de": "Du kennst ein Kanji nicht?",
      "ru": "Вы не знаете ни одного кандзи?",
      "ja": "漢字を知らないのですか？",
      "zh": "你不知道一个汉字吗？",
      "it": "Non conosci un kanji?",
      "fr": "Vous ne connaissez pas un Kanji ?",
      "es": "No sabes un Kanji?",
      "pl": "Nie znasz Kanji?"
    },
    "Onboarding_1_text": {
      "en": "Just draw it and \"DaKanji\" will show the character you need.",
      "de": "Male es mit deinem Finger und DaKanji zeigt dir das Zeichen",
      "ru": "Просто нарисуйте его, и \"DaKanji\" покажет нужный вам иероглиф.",
      "ja": "描くだけで、「DaKanji」が必要な文字を表示します。",
      "zh": "只要画出来，\"DaKanji \"就会显示出你需要的字符。",
      "it": "Basta disegnarlo e \"DaKanji\" mostrerà il carattere desiderato.",
      "fr": "Il suffit de le dessiner et \"DaKanji\" affichera le caractère dont vous avez besoin.",
      "es": "Solo dibújalo y DaKanji te mostrará el caracter que necesitas.",
      "pl": "Po prostu go narysuj i DaKanji pokaże Ci znak którego potrzebujesz"
    },
    "Onboarding_2_title": {
      "en": "Lookup characters and words",
      "de": "Schlage Zeichen und Wörter nach",
      "ru": "Поиск символов и слов",
      "ja": "文字や言葉を調べる",
      "zh": "查询字符和单词",
      "it": "Ricerca di caratteri e parole",
      "fr": "Recherche de caractères et de mots",
      "es": "Busca caracteres y palabras",
      "pl": "Podejrzyj znaki i wyrazy"
    },
    "Onboarding_2_text": {
      "en": "With \"DaKanji\" you can quickly lookup words using web and app dictionaries.",
      "de": "Mit DaKanji kannst du schnell Wörter in Web- und App-Wörterbüchern nachschlagen",
      "ru": "С помощью \"DaKanji\" вы можете быстро искать слова, используя веб-словари и словари приложений.",
      "ja": "「DaKanji」は、Webやアプリの辞書を使って素早く単語を調べることができます。",
      "zh": "通过 \"DaKanji\"，你可以使用网络和应用程序的字典快速查询单词。",
      "it": "Con \"DaKanji\" è possibile cercare rapidamente le parole utilizzando dizionari web e app.",
      "fr": "Avec \"DaKanji\", vous pouvez rechercher rapidement des mots en utilisant les dictionnaires du web et des applications.",
      "es": "Con DaKanji puedes buscar rápidamente palabras usando la web y diccionarios.",
      "pl": "Z DaKanji możesz szybko podglądnąć słówka używając internetu oraz słowników"
    }
  },
  "SettingsScreen": {
    "custom_url_hint": {
      "en": "URL of your dictionary",
      "de": "URL von dem Wörterbuch das benutzt werden soll",
      "ru": "URL вашего словаря",
      "ja": "お使いの辞書のURL",
      "zh": "你的字典的URL",
      "it": "URL del vostro dizionario",
      "fr": "URL de votre dictionnaire",
      "es": "URL de tu diccionario",
      "pl": "URL twojego słownika"
    },
    "dictionary_system_translator": {
      "en": "OS integrated translator",
      "de": "betriebssysteminternes Übersetzer",
      "ru": "Встроенный в ОС переводчик",
      "ja": "OS統合トランスレータ",
      "zh": "操作系统集成翻译器",
      "it": "Traduttore integrato nel sistema operativo",
      "fr": "Traducteur intégré au système d'exploitation",
      "es": "Traductor integrado de tu SO",
      "pl": "Tłumacz systemowy"
    },
    "drawing_title": {
      "en": "Drawing",
      "de": "Zeichnen",
      "ru": "Рисование",
      "ja": "図面",
      "zh": "绘图",
      "it": "Disegno",
      "fr": "Dessin",
      "es": "Dibujar",
      "pl": "Obraz"
    },
    "empty_canvas_after_double_tap": {
      "en": "Empty canvas after double tap",
      "de": "Lösche alle Striche nach doppeltem Tippen",
      "ru": "Пустой холст после двойного нажатия",
      "ja": "ダブルタップ後にキャンバスが空っぽになる",
      "zh": "双击后空出画布",
      "it": "Tela vuota dopo il doppio tocco",
      "fr": "Toile vide après un double tapotement",
      "es": "Vaciar lienzo después de una pulsación doble",
      "pl": "Wyczyść płótno podwójnym kliknięciem"
    },
    "invert_short_long_press": {
      "en": "Invert long/short press",
      "de": "Invertiere kurzes und langes drücken",
      "ru": "Инвертировать длинный/короткий пресс",
      "ja": "インバートロング/ショートプレス",
      "zh": "倒置长/短按",
      "it": "Invertire la pressione lunga/corta",
      "fr": "Inverser la presse long/short",
      "es": "Invertir pulsación larga/breve",
      "pl": "Odwróć długie/krótkie kliknięcie"
    },
    "long_press_opens": {
      "en": "Long press opens",
      "de": "Langes drücken öffnet",
      "ru": "Длительное нажатие открывает",
      "ja": "長押しで開く",
      "zh": "长按打开",
      "it": "La pressione prolungata apre",
      "fr": "Une pression longue ouvre",
      "es": "Pulsación larga abre",
      "pl": "Długie kliknięcie otwiera"
    },
    "miscellaneous_title": {
      "en": "Miscellaneous",
      "de": "Verschiedenes",
      "ru": "Разное",
      "ja": "その他",
      "zh": "杂项",
      "it": "Varie",
      "fr": "Divers",
      "es": "Misceláneo",
      "pl": "Inne"
    },
    "show_tutorial": {
      "en": "Reshow tutorials (@:General.restarts_app)",
      "de": "Zeige Tutorials erneut (@:General.restarts_app)",
      "ru": "Перезапустить учебники (@:General.restarts_app)",
      "ja": "チュートリアルの再表示 (@:General.restarts_app)",
      "zh": "重新展示教程（@:General.restarts_app）。",
      "it": "Ripresenta le esercitazioni (@:General.restarts_app)",
      "fr": "Relancer les didacticiels (@:General.restarts_app)",
      "es": "Volver a mostrar el tutorial (@:General.restarts_app)",
      "pl": "Powtórz tutorial (@:General.restarts_app)"
    },
    "theme": {
      "en": "theme (@:General.restarts_app)",
      "de": "Thema (@:General.restarts_app)",
      "ru": "тема (@:General.restarts_app)",
      "ja": "テーマ (@:General.restarts_app)",
      "zh": "主题 (@:General.restarts_app)",
      "it": "tema (@:General.restarts_app)",
      "fr": "thème (@:General.restarts_app)",
      "es": "tema (@:General.restarts_app)",
      "pl": "Motyw(@:General.restarts_app)"
    },
    "title": {
      "en": "Settings",
      "de": "Einstellungen",
      "ru": "Настройки",
      "ja": "設定",
      "zh": "设置",
      "it": "Impostazioni",
      "fr": "Paramètres",
      "es": "Ajustes",
      "pl": "Ustawienia"
    },
    "use_default_browser_for_online_dictionaries": {
      "en": "Use a webview for web dictionaries",
      "de": "Benutze einen webview für web Wörterbücher",
      "ru": "Использование веб-просмотра для веб-словарей",
      "ja": "ウェブ辞書にウェブビューを使用する",
      "zh": "为网络字典使用网络视图",
      "it": "Utilizzare una webview per i dizionari web",
      "fr": "Utiliser une vue web pour les dictionnaires web",
      "es": "Usar una webview para los diccionarios en la web",
      "pl": "Użyj webview dla słowników internetowych"
    },
    "custom_url_format": {
      "en": "Custom URL format",
      "de": "Benutzerdefiniertes URL format",
      "ru": "Пользовательский формат URL",
      "ja": "カスタムURLフォーマット",
      "zh": "自定义URL格式",
      "it": "Formato URL personalizzato",
      "fr": "Format d'URL personnalisé",
      "es": "Formato de la URL personalizada",
      "pl": "Niestandardowy format URL"
    },
    "custom_url_explanation": {
      "en": "The app will replace a placeholder in the URL with the predicted character. This placeholder is: {kanjiPlaceholder}\n\nExample:\nThe predicted character is: '口' and you want to open it on 'jisho.org'. First you have to get the URL of the website for searching. In this case: 'https://jisho.org/search/口'. Now only the character in the URL has to be replaced with the placeholder. This leads to 'https://jisho.org/search/{kanjiPlaceholder}'.",
      "de": "Die App ersetzt einen Platzhalter in der gegbenen URL mit dem vorhergesagten Zeichen. Dieser Plathalter ist: {kanjiPlaceholder}\n\nBeispiel:\nDas vorhergesagte Zeichen ist: '口' und man wil es auf 'jisho.org' nachschlagen. Dafür muss als erste die URL der website, welche für das Suchen benutzt wird, herausgefunden werden. Für 'jisho.org' ist das: 'https://jisho.org/search/口'. Nun muss nur noch das Zeichen aus der URL mit dem Platzhalter ersetzt werden. Das führt zu 'https://jisho.org/search/{kanjiPlaceholder}'.",
      "ru": "Приложение заменит местодержатель в URL на предсказанный символ. Это местозаполнитель: {kanjiPlaceholder}\n\nПример:\nПредсказанный иероглиф: '口', и вы хотите открыть его на сайте 'jisho.org'. Сначала необходимо получить URL сайта для поиска. В данном случае: 'https://jisho.org/search/口'. Теперь нужно заменить только символ в URL на заполнитель. В результате получится 'https://jisho.org/search/{kanjiPlaceholder}'.",
      "ja": "このアプリは、URL内のプレースホルダーを予測される文字に置き換えます。このプレースホルダーは、{kanjiPlaceholder}です。\n\n例\n予測される文字は'口'で、'jisho.org'で開きたいとします。まず、検索対象のウェブサイトのURLを取得する必要があります。この場合、'https://jisho.org/search/口'です。ここで、URLの中の文字だけをプレースホルダーに置き換える必要があります。これは、'https://jisho.org/search/{kanjiPlaceholder}'につながります。",
      "zh": "该应用程序将用预测的字符替换URL中的一个占位符。这个占位符是：{kanjiPlaceholder}。\n\n例子。\n预测的字符是：'口'，你想在'jisho.org'上打开它。首先，你必须得到搜索网站的URL。在这个例子中：'https://jisho.org/search/口'。现在，只有URL中的字符需要被替换成占位符。这就导致了'https://jisho.org/search/{kanjiPlaceholder}'。",
      "it": "L'applicazione sostituirà un segnaposto nell'URL con il carattere previsto. Questo segnaposto è: {kanjiPlaceholder}\n\nEsempio:\nIl carattere previsto è: \"口\" e si vuole aprire il sito \"jisho.org\". Per prima cosa è necessario ottenere l'URL del sito web per la ricerca. In questo caso: \"https://jisho.org/search/口\". Ora solo il carattere dell'URL deve essere sostituito con il segnaposto. Questo porta a 'https://jisho.org/search/{kanjiPlaceholder}'.",
      "fr": "L'application remplacera un caractère de remplacement dans l'URL par le caractère prédit. Ce caractère de remplacement est : {kanjiPlaceholder}\n\nExemple :\nLe caractère prédit est : '口' et vous voulez l'ouvrir sur 'jisho.org'. Tout d'abord, vous devez obtenir l'URL du site Web à rechercher. Dans ce cas : 'https://jisho.org/search/口'. Maintenant, seul le caractère dans l'URL doit être remplacé par le caractère de remplacement. Cela donne 'https://jisho.org/search/{kanjiPlaceholder}'.",
      "es": "La app va a reemplazar el comodín en la URL con la predicción. El comodín es: {kanjiPlaceholder}\n\nEjemplo:\nLa predicción es \"口\" y quieres abrirlo en \"jisho.org\". Primero tienes que buscar la URL de la página web que estás buscando. En este caso, \"https://jisho.org/口\". Ahora solo hay que reemplazar el caracter por el comodín. Esto es \"https://jisho.org/search/{kanjiPlaceholder}\".",
      "pl": "Aplikacja podmieni symbol zastępczy predykowanym znakiem. Symbolem zastępczym jest: {kanjiPlaceholder}\n\nPrzykład:\nPredykowany znak to '口'  i chcemy otworzyć go na 'jisho.org'. Najpierw musimy posiadać adres URL strony internetowej wykorzystywanej do wyszukiwania. W tym przypadku jest to 'https://jisho.org/search/口'. Następnie symbol zastępczy zostanie podmieniony na nasz znak. Tym samym otrzymujemy 'https://jisho.org/search/{kanjiPlaceholder}'."
    },
    "advanced_settings_drawing_inference_backend": {
      "en": "Inference backend (requires restart)",
      "de": "Inferenz Backend (Neustart notwendig)",
      "ru": "Бэкэнд для выводов (требуется перезапуск)",
      "ja": "推論バックエンド（再起動が必要）",
      "zh": "推理后端（需要重新启动）。",
      "it": "Backend di inferenza (richiede il riavvio)",
      "fr": "Backend d'inférence (nécessite un redémarrage)",
      "es": "Backend de inferencia (reinicio manual requerido)",
      "pl": "System wnioskowania (wymaga restartu)"
    },
    "advanced_settings_title": {
      "en": "Advanced settings",
      "de": "Erweiterte Einstellungen",
      "ru": "Дополнительные настройки",
      "ja": "詳細設定",
      "zh": "高级设置",
      "it": "Impostazioni avanzate",
      "fr": "Paramètres avancés",
      "es": "Ajustes avanzados",
      "pl": "Ustawienia zaawansowane"
    },
    "advanced_settings_snap": {
      "en": "I am inevitable...",
      "de": "Ich bin unvermeidbar...",
      "ru": "Я неизбежен...",
      "ja": "私は必然的に・・・。",
      "zh": "我是不可避免的...",
      "it": "Sono inevitabile...",
      "fr": "Je suis inévitable...",
      "es": "Soy inevitable...",
      "pl": "Jestem nieunikniony..."
    },
    "misc_settings_window_size": {
      "en": "Save current window size",
      "de": "Speicher die momentanige Fenster größe",
      "ru": "Сохранить текущий размер окна",
      "ja": "現在のウィンドウサイズを保存",
      "zh": "保存当前窗口尺寸",
      "it": "Salva la dimensione attuale della finestra",
      "fr": "Sauvegarder la taille actuelle de la fenêtre",
      "es": "Guardar el tamaño actual de la ventana",
      "pl": "Zapisz bieżący rozmiar okna"
    }
  },
  "WebviewScreen": {
    "loading": {
      "en": "Searching",
      "de": "Suche",
      "ru": "Поиск",
      "ja": "検索中",
      "zh": "搜索",
      "it": "Ricerca",
      "fr": "Recherche",
      "es": "Buscando",
      "pl": "Ładowanie"
    },
    "title": {
      "en": "Webview",
      "de": "Webview",
      "ru": "Webview",
      "ja": "ウェブビュー",
      "zh": "网页浏览",
      "it": "Vista sul web",
      "fr": "Webview",
      "es": "Webview",
      "pl": "Webview"
    }
  }
};
static const Map<String,dynamic> pl = {
  "AboutScreen": {
    "about_text": "DaKanji stworzone jest, aby pomagać osobom uczącym się języka japońskiego oraz jego użytkownikom. \nDaKanji dostępne jest dla [iOS](IOS), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}) i [Windows]({MICROSOFT_STORE_PAGE}). \nWszystkie wersje możesz zobaczyć na [GitHub.]({GITHUB_RELEASES_PAGE}).\n\nSprawdź również inne [moje aplikacje]({DAAPPLAB_STORE_PAGE}). \nJeżeli napotkasz problemy korzystając z tej aplikacji, albo posiadasz sugestie na to jak ją poprawić, wyślij je [tutaj]({GITHUB_ISSUES}), dołącz na [serwer discord]({DISCORD_SERVER}) albo wyślij [e-mail](daapplab@gmail.com). \nPolityka prywatności dostępna jest [tutaj]({PRIVACY_POLICE})",
    "credits": "Podziękowania",
    "show_changelog": "Pokaż pełną historię zmian",
    "software_informations_button": "Informacje o oprogramowaniu",
    "title": "O aplikacji"
  },
  "ChangelogScreen": {
    "title": "Historia zmian"
  },
  "Dictionary": {
    "title": "Słownik"
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
    "advanced_settings_drawing_inference_backend": "System wnioskowania (wymaga restartu)",
    "advanced_settings_snap": "Jestem nieunikniony...",
    "advanced_settings_title": "Ustawienia zaawansowane",
    "custom_url_explanation": "Aplikacja podmieni symbol zastępczy predykowanym znakiem. Symbolem zastępczym jest: {kanjiPlaceholder}\n\nPrzykład:\nPredykowany znak to '口'  i chcemy otworzyć go na 'jisho.org'. Najpierw musimy posiadać adres URL strony internetowej wykorzystywanej do wyszukiwania. W tym przypadku jest to 'https://jisho.org/search/口'. Następnie symbol zastępczy zostanie podmieniony na nasz znak. Tym samym otrzymujemy 'https://jisho.org/search/{kanjiPlaceholder}'.",
    "custom_url_format": "Niestandardowy format URL",
    "custom_url_hint": "URL twojego słownika",
    "dictionary_system_translator": "Tłumacz systemowy",
    "drawing_title": "Obraz",
    "empty_canvas_after_double_tap": "Wyczyść płótno podwójnym kliknięciem",
    "invert_short_long_press": "Odwróć długie/krótkie kliknięcie",
    "long_press_opens": "Długie kliknięcie otwiera",
    "misc_settings_window_size": "Zapisz bieżący rozmiar okna",
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
  "TextScreen": {
    "title": "Tekst"
  },
  "WebviewScreen": {
    "loading": "Ładowanie",
    "title": "Webview"
  }
};
static const Map<String,dynamic> ru = {
  "AboutScreen": {
    "about_text": "\"DaKanji\" помогает изучающим японский язык и людям, которые его используют.\n\"DaKanji\" доступен для [iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}).\nВы также можете найти все релизы на [GitHub.]({GITHUB_RELEASES_PAGE}).\n\nТакже посмотрите [другие мои приложения]({DAAPPLAB_STORE_PAGE}).\nЕсли у вас есть проблемы с использованием этого приложения или предложения по его улучшению, пожалуйста, сообщите о них [здесь]({GITHUB_ISSUES}), присоединяйтесь к [discord серверу]({DISCORD_SERVER}) или отправьте [e-mail](daapplab@gmail.com).\n\nПолицию конфиденциальности можно найти [здесь]({PRIVACY_POLICE})",
    "credits": "Кредиты",
    "show_changelog": "Покажите мне полный журнал изменений.",
    "software_informations_button": "Информация о программном обеспечении",
    "title": "О сайте"
  },
  "ChangelogScreen": {
    "title": "Changelog"
  },
  "Dictionary": {
    "title": "Словарь"
  },
  "DrawScreen": {
    "not_installed": "{DICTIONARY} не установлен",
    "title": "Рисование",
    "tutorial_begin_continue": "Нажмите, чтобы продолжить...",
    "tutorial_begin_text": "Мы покажем вам краткое руководство, чтобы вы могли начать.",
    "tutorial_begin_title": "Добро пожаловать на распознавание рисунка!",
    "tutorial_clear": "Стирает все штрихи",
    "tutorial_dictionary_settings": "В настройках можно выбрать службу перевода",
    "tutorial_double_tap_prediction": "Двойное нажатие добавляет символ в поле поиска",
    "tutorial_drawing": "Нарисуйте персонажа здесь",
    "tutorial_long_press_prediction": "Длительное нажатие открывает предсказание в словаре",
    "tutorial_multi_search": "Здесь вы можете искать сразу несколько символов",
    "tutorial_multi_search_double_tap": "Двойное нажатие опустошает поле",
    "tutorial_multi_search_long_press": "Длительное нажатие открывает символы в словаре",
    "tutorial_multi_search_short_press": "Короткое нажатие копирует символы в буфер обмена",
    "tutorial_multi_search_swipe_left": "Свайп влево на этом поле удаляет последний символ",
    "tutorial_predictions": "Предсказанные символы будут показаны здесь",
    "tutorial_short_press_prediction": "Короткое нажатие копирует предсказание",
    "tutorial_skip": "ПРОПУСК",
    "tutorial_undo": "Нажмите, чтобы отменить последний штрих"
  },
  "General": {
    "app": "приложение",
    "close": "Закрыть",
    "complete_log": "полный журнал",
    "custom_url": "пользовательский URL",
    "dark": "темный",
    "download": "скачать",
    "language": "язык",
    "light": "свет",
    "next": "следующий",
    "rate_this_app": "Тариф",
    "restarts_app": "перезапускает приложение",
    "skip": "пропустить",
    "system": "система",
    "web": "веб-сайт",
    "whats_new": "что нового"
  },
  "HomeScreen": {
    "RatePopup_dont_ask_again": "Только не это!",
    "RatePopup_text": "Вам нравится \"DaKanji\"?\nЕсли это так, то оценка была бы замечательной и очень помогла бы этому проекту!"
  },
  "OnBoarding": {
    "Onboarding_1_text": "Просто нарисуйте его, и \"DaKanji\" покажет нужный вам иероглиф.",
    "Onboarding_1_title": "Вы не знаете ни одного кандзи?",
    "Onboarding_2_text": "С помощью \"DaKanji\" вы можете быстро искать слова, используя веб-словари и словари приложений.",
    "Onboarding_2_title": "Поиск символов и слов"
  },
  "Overview": {
  },
  "SettingsScreen": {
    "advanced_settings_drawing_inference_backend": "Бэкэнд для выводов (требуется перезапуск)",
    "advanced_settings_snap": "Я неизбежен...",
    "advanced_settings_title": "Дополнительные настройки",
    "custom_url_explanation": "Приложение заменит местодержатель в URL на предсказанный символ. Это местозаполнитель: {kanjiPlaceholder}\n\nПример:\nПредсказанный иероглиф: '口', и вы хотите открыть его на сайте 'jisho.org'. Сначала необходимо получить URL сайта для поиска. В данном случае: 'https://jisho.org/search/口'. Теперь нужно заменить только символ в URL на заполнитель. В результате получится 'https://jisho.org/search/{kanjiPlaceholder}'.",
    "custom_url_format": "Пользовательский формат URL",
    "custom_url_hint": "URL вашего словаря",
    "dictionary_system_translator": "Встроенный в ОС переводчик",
    "drawing_title": "Рисование",
    "empty_canvas_after_double_tap": "Пустой холст после двойного нажатия",
    "invert_short_long_press": "Инвертировать длинный/короткий пресс",
    "long_press_opens": "Длительное нажатие открывает",
    "misc_settings_window_size": "Сохранить текущий размер окна",
    "miscellaneous_title": "Разное",
    "show_tutorial": "Перезапустить учебники (@:General.restarts_app)",
    "theme": "тема (@:General.restarts_app)",
    "title": "Настройки",
    "use_default_browser_for_online_dictionaries": "Использование веб-просмотра для веб-словарей"
  },
  "Stores": {
    "long_description": "Вы изучаете японский язык? Тогда вам нужно попробовать \"DaKanji\"!\n\nВы когда-нибудь пытались прочитать японский текст, но не знали, как прочитать некоторые кандзи? \"DaKanji\" поможет вам. Нарисуйте кандзи, и приложение преобразует его в цифровой символ. Вам даже не нужно знать порядок штрихов! Пишите иероглифы и стройте слова, чтобы затем перевести их, и все это совершенно автономно.\n\nОбзор функций:\n* Распознает 6500 кандзи и все кана в автономном режиме.\n* Использование веб-словарей и словарей приложений для перевода символов или слов",
    "mockup_1_1": "Не знаете кандзи? Просто нарисуйте его!",
    "mockup_1_2": "Даже порядок штрихов не имеет значения.",
    "mockup_2": "Поисковые слова",
    "mockup_3": "Переводите с помощью словарей",
    "short_description": "Вы изучаете японский язык? Тогда вам нужно попробовать \"DaKanji\"!\nНаходите иероглифы и переводите их, просто рисуя.",
    "shortest_description": "Вы изучаете японский язык? Тогда вам нужно попробовать \"DaKanji\"!"
  },
  "TextScreen": {
    "title": "Текст"
  },
  "WebviewScreen": {
    "loading": "Поиск",
    "title": "Webview"
  }
};
static const Map<String,dynamic> zh = {
  "AboutScreen": {
    "about_text": "\"大汉字 \"帮助日语学生和使用日语的人。\n\"大汉字 \"可用于，[iOS]({APPSTORE_PAGE}), [Android]({PLAYSTORE_PAGE}), [MacOS]({MACSTORE_PAGE}), [Linux (Snap)]({SNAPSTORE_PAGE}), [Windows]({MICROSOFT_STORE_PAGE}) 。\n你也可以在[GitHub.]({GITHUB_RELEASES_PAGE})上找到所有版本。\n\n还可以查看[我的其他应用程序。]({DAAPPLAB_STORE_PAGE})\n如果你在使用这个应用时有问题，或者对如何改进它有建议，请在[这里]({GITHUB_ISSUES})报告，加入[discord服务器]({DISCORD_SERVER})或发送[电子邮件](daapplab@gmail.com)。\n\n隐私警察可以在[这里]({PRIVACY_POLICE})找到。",
    "credits": "贷方",
    "show_changelog": "给我看完整的更新日志。",
    "software_informations_button": "软件信息",
    "title": "关于"
  },
  "ChangelogScreen": {
    "title": "更新日志"
  },
  "Dictionary": {
    "title": "词典"
  },
  "DrawScreen": {
    "not_installed": "未安装{DICTIONARY}。",
    "title": "绘图",
    "tutorial_begin_continue": "点击继续...",
    "tutorial_begin_text": "我们将向你展示一个快速教程，让你开始。",
    "tutorial_begin_title": "欢迎大家对绘画的认可!",
    "tutorial_clear": "擦除所有笔画",
    "tutorial_dictionary_settings": "在设置中，可以选择翻译服务",
    "tutorial_double_tap_prediction": "双击将该字符添加到搜索框中",
    "tutorial_drawing": "在这里画一个人物",
    "tutorial_long_press_prediction": "长按可打开字典中的预测信息",
    "tutorial_multi_search": "在这里，你可以一次搜索多个字符",
    "tutorial_multi_search_double_tap": "双击就会清空该区域",
    "tutorial_multi_search_long_press": "长按可以打开字典中的字符",
    "tutorial_multi_search_short_press": "短暂的按下，将字符复制到剪贴板上",
    "tutorial_multi_search_swipe_left": "在这个字段上向左滑动，会删除最后一个字符",
    "tutorial_predictions": "预测的字符将显示在这里",
    "tutorial_short_press_prediction": "短暂的按语复制了预测的内容",
    "tutorial_skip": "撇开",
    "tutorial_undo": "按下撤消最后一笔"
  },
  "General": {
    "app": "应用程序",
    "close": "关闭",
    "complete_log": "完整日志",
    "custom_url": "自定义URL",
    "dark": "黑",
    "download": "下载",
    "language": "语言",
    "light": "光",
    "next": "下一个",
    "rate_this_app": "速率",
    "restarts_app": "重新启动应用程序",
    "skip": "跳过",
    "system": "系统",
    "web": "网络",
    "whats_new": "最新信息"
  },
  "HomeScreen": {
    "RatePopup_dont_ask_again": "不要再来了!",
    "RatePopup_text": "你喜欢 \"DaKanji \"吗？\n如果是这样的话，评分将是非常棒的，它将对这个项目有很大的帮助!"
  },
  "OnBoarding": {
    "Onboarding_1_text": "只要画出来，\"DaKanji \"就会显示出你需要的字符。",
    "Onboarding_1_title": "你不知道一个汉字吗？",
    "Onboarding_2_text": "通过 \"DaKanji\"，你可以使用网络和应用程序的字典快速查询单词。",
    "Onboarding_2_title": "查询字符和单词"
  },
  "Overview": {
  },
  "SettingsScreen": {
    "advanced_settings_drawing_inference_backend": "推理后端（需要重新启动）。",
    "advanced_settings_snap": "我是不可避免的...",
    "advanced_settings_title": "高级设置",
    "custom_url_explanation": "该应用程序将用预测的字符替换URL中的一个占位符。这个占位符是：{kanjiPlaceholder}。\n\n例子。\n预测的字符是：'口'，你想在'jisho.org'上打开它。首先，你必须得到搜索网站的URL。在这个例子中：'https://jisho.org/search/口'。现在，只有URL中的字符需要被替换成占位符。这就导致了'https://jisho.org/search/{kanjiPlaceholder}'。",
    "custom_url_format": "自定义URL格式",
    "custom_url_hint": "你的字典的URL",
    "dictionary_system_translator": "操作系统集成翻译器",
    "drawing_title": "绘图",
    "empty_canvas_after_double_tap": "双击后空出画布",
    "invert_short_long_press": "倒置长/短按",
    "long_press_opens": "长按打开",
    "misc_settings_window_size": "保存当前窗口尺寸",
    "miscellaneous_title": "杂项",
    "show_tutorial": "重新展示教程（@:General.restarts_app）。",
    "theme": "主题 (@:General.restarts_app)",
    "title": "设置",
    "use_default_browser_for_online_dictionaries": "为网络字典使用网络视图"
  },
  "Stores": {
    "long_description": "你正在学习日语？那么你需要尝试一下 \"DaKanji\"!\n\n你是否曾经试图阅读一篇日语文章，但不知道如何阅读一些汉字？\"DaKanji \"在这里帮助你。画一个汉字，这个应用程序将把它转换成一个数字字符。你甚至不需要知道笔画的顺序!写字和造词，然后翻译它们，所有这些都是完全离线的。\n\n特点概述。\n* 识别6500个汉字和所有假名的脱机字符\n* 使用网络和应用程序的字典来翻译字符或单词",
    "mockup_1_1": "不知道一个汉字？就画出来吧!",
    "mockup_1_2": "甚至笔画顺序也不重要。",
    "mockup_2": "搜索词",
    "mockup_3": "使用字典进行翻译",
    "short_description": "你正在学习日语？那么你需要尝试一下 \"DaKanji\"!\n只需通过绘画就能找到字符并进行翻译。",
    "shortest_description": "你正在学习日语？那么你需要尝试一下 \"DaKanji\"!"
  },
  "TextScreen": {
    "title": "文本"
  },
  "WebviewScreen": {
    "loading": "搜索",
    "title": "网页浏览"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"de": de, "en": en, "es": es, "fr": fr, "it": it, "ja": ja, "localizations": localizations, "pl": pl, "ru": ru, "zh": zh};
}

// Package imports:
import 'package:flutter_ankidroid/flutter_ankidroid.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/anki/anki_note.dart';
import 'package:da_kanji_mobile/entities/settings/settings_anki.dart';
import 'package:da_kanji_mobile/repositories/anki/anki_data.dart';

/// Class to communicate with AnkiDroid (anki on android)
class AnkiAndroid {

  /// User settings for anki
  SettingsAnki settingsAnki;
  /// AnkiDroid communication isolate
  late final Ankidroid ankidroid;


  AnkiAndroid(
    this.settingsAnki
  );

  /// Initializes this instance
  Future init() async {

    ankidroid = await Ankidroid.createAnkiIsolate();
  
  }
    
  /// Platform specific (desktop via anki connect) implementation of `add_note`
  Future<int> addNoteAndroid(AnkiNote note) async {
    
    int modelId = (await (await ankidroid.getModelList(0)).asFuture)
      .entries
      .where((e) => e.value == ankiDataCardModelName)
      .first.key;

    int deckId = (await (await ankidroid.deckList()).asFuture)
      .entries
      .where((e) => e.value == note.deckName)
      .first.key;

    int result = await (await ankidroid.addNote(
      modelId,
      deckId,
      List<String>.from(note.fields.values),
      note.tags
    )).asFuture;

    return result;

  }

  /// Platform specific (android via ankidroid) implementation of `add_notes`
  Future<int> addNotesAndroid(List<AnkiNote> notes) async {
    
    int modelId = (await (await ankidroid.getModelList(0)).asFuture)
      .entries
      .where((e) => e.value == ankiDataCardModelName)
      .first.key;

    int deckId = (await (await ankidroid.deckList()).asFuture)
      .entries
      .where((e) => e.value == notes.first.deckName)
      .first.key;

    int result = await (await ankidroid.addNotes(
      modelId,
      deckId,
      List<List<String>>.from(notes.map((n) => List<String>.from(n.fields.values))),
      List<List<String>>.from(notes.map((n) => n.tags)),
    )).asFuture;

    return result;

  }

  /// platform specific (android via ankidroid) implementation of
  /// `daKanjiModelExists`
  Future<bool> daKanjiModelExistsAndroid() async {

    Map models = (await (await ankidroid.modelList()).asFuture);

    return models.values.contains("DaKanji");

  }

  /// Platform specific (android via ankidroid) implementation of
  /// `addDaKanjiCardType`
  Future<int> addDaKanjiModelAndroid() async {

    int result = await (await ankidroid.addNewCustomModel(
      ankiDataCardModelName,
      ankiDataFields,
      [ankiDataCardTypeName],
      [ankiDataFrontTemplate],
      [ankiDataBackTemplate],
      ankiDataStyling,
      null,
      null
    )).asFuture;

    return result;

  }

  /// Platform specific (android via ankidroid) implementation of `addDeck`
  Future<void> addDeckAndroid(String deckName) async {
    
    await ankidroid.addNewDeck(deckName);
    
  }

  /// Platform specific (android via ankidroid) implementation of `getDeckNames`
  Future<List<String>> getDeckNamesAndroid() async {
    
    Map t = await (await ankidroid.deckList()).asFuture;

    return List<String>.from(t.values);

  }


  /// Platform specific (android via ankidroid) implementation of
  /// `check_anki_available`
  Future<bool> checkAnkidroidAvailable() async {
    
    await Ankidroid.askForPermission();

    String t = "";
    try {
      t = await (await ankidroid.test()).asFuture;
    } catch (e) {
      // ankidroid not installed
    }

    return t.toString() == "Test Successful!";
  }

}

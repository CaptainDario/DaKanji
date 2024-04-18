/// Name of the DaKanji Anki model
const String ankiDataCardModelName = "DaKanji";
/// name of the DaKanji anki card 
const String ankiDataCardTypeName = "DaKanji Card";

/// Name of the anki field for the Translations
const String ankiDataFieldTranslation  = "Translations";
/// Name of the anki field for the Kanji
const String ankiDataFieldKanji        = "Kanji";
/// Name of the anki field for the Kana
const String ankiDataFieldKana         = "Kana";
/// Name of the anki field that shows a note on the fron of the card
const String ankiDataFieldFrontNote    = "Note Front";
/// Name of the anki field that shows a note on the back of the card
const String ankiDataFieldBackNote     = "Note Back";
/// Name of the anki Field to link to dakanji
const String ankiDataFieldDaKanjiLink  = "DaKanji Link";
/// Name of the anki field for the Audio
const String ankiDataFieldAudio        = "Audio";
/// Name of the anki field for the Example
const String ankiDataFieldExample      = "Example";
/// Name of the anki field for the audio example
const String ankiDataFieldExampleAudio = "Audio Example";
/// Name of the anki field for the Image
const String ankiDataFieldImage        = "Image";

/// List containgin all fields of the dakanji anki note type
const List<String> ankiDataFields = [
  ankiDataFieldTranslation,
  ankiDataFieldKanji,
  ankiDataFieldKana,
  ankiDataFieldFrontNote,
  ankiDataFieldBackNote,
  ankiDataFieldDaKanjiLink,
  ankiDataFieldAudio,
  ankiDataFieldExample,
  ankiDataFieldExampleAudio,
  ankiDataFieldImage
];

/// The styling of the DaKanji note template in anki
const String ankiDataStyling =
"""
.card {
    font-family: arial;
    font-size: 20px;
    text-align: center;
    color: black;
    background-color: white;
}
.language {
	color: #999999
}
.translations {
  text-align: left;
}
""";

/// The template for the front of DaKanji Anki notes
const String ankiDataFrontTemplate =
"""
{{FrontSide}}

<hr id=answer>

<div class="translations">
	{{$ankiDataFieldTranslation}}
</div>
<br>
<br>
{{#$ankiDataFieldImage}}
  <img src="{{$ankiDataFieldImage}}">
{{/$ankiDataFieldImage}}
<br>
{{#$ankiDataFieldFrontNote}}
	{{$ankiDataFieldFrontNote}}
{{/$ankiDataFieldFrontNote}}
""";

/// The template for the back of DaKanji Anki notes
const String ankiDataBackTemplate =
"""
<a href="{{$ankiDataFieldDaKanjiLink}}">
	{{#$ankiDataFieldKanji}}
		<ruby>{{$ankiDataFieldKanji}}<rp>(</rp><rt>{{$ankiDataFieldKana}}</rt><br>
	{{/$ankiDataFieldKanji}}

	{{^$ankiDataFieldKanji}}
		{{$ankiDataFieldKana}}
	{{/$ankiDataFieldKanji}}
</a>
{{#$ankiDataFieldAudio}}
	{{$ankiDataFieldAudio}}
{{/$ankiDataFieldAudio}}
<br>
{{#$ankiDataFieldExample}}
	{{$ankiDataFieldExample}}
{{/$ankiDataFieldExample}}
<br>
{{#$ankiDataFieldImage}}
	{{$ankiDataFieldImage}}
{{/$ankiDataFieldImage}}
<br>
{{#$ankiDataFieldBackNote}}
	{{$ankiDataFieldBackNote}}
{{/$ankiDataFieldBackNote}}
""";
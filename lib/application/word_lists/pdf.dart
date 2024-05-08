// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/settings/settings_word_lists.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_queries.dart';

// Project imports

/// Exports the given word list as a PDF file
Future<pw.Document> pdfPortraitFromWordListNode(List<int> wordIDs, String name) async {
  
  // load Japanese font
  final ttf = await fontFromAssetBundle("assets/fonts/Noto_Sans_JP/NotoSansJP-Medium.ttf");
  final notoStyle = pw.TextStyle(
    font: ttf,
    fontSize: 12
  );
  // load the dakanji logo
  final dakanjiLogo = await rootBundle.load("assets/images/dakanji/icon.png");

  // get settings
  SettingsWordLists wl = GetIt.I<Settings>().wordLists;
  List<String> langsToInclude = GetIt.I<Settings>().wordLists
    .langsToInclude(GetIt.I<Settings>().dictionary.selectedTranslationLanguages);
  int maxMeanings = wl.pdfMaxMeaningsPerVocabulary;
  int maxWordsPerMeaning = wl.pdfMaxWordsPerMeaning;
  int maxLines = wl.pdfMaxLinesPerMeaning;
  bool includeKana = wl.pdfIncludeKana;

  // find all elements from the word list in the database
  List<JMdict> entries = await wordListEntriesForExport(wordIDs, langsToInclude);

  // load the flag SVGs from disk
  Map<String, String> languageSVGs = {};
  for (MapEntry e in GetIt.I<Settings>().dictionary.translationLanguagesToSvgPath.entries) {
    languageSVGs[e.key] = await rootBundle.loadString(e.value);
  }

  return createPortraitPDF(
    entries,
    name, dakanjiLogo, languageSVGs,
    maxMeanings, maxWordsPerMeaning, maxLines, includeKana,
    notoStyle
  );

}

/// creates the actual PDF 'widget' and returns it
pw.Document createPortraitPDF(
  List<JMdict> entries,
  String name, ByteData dakanjiLogo, Map<String, String> languageSVGs,
  int maxMeanings, int maxWordsPerMeaning, int maxLines, bool includeKana,
  pw.TextStyle notoStyle
){

  // Create document
  final pw.Document pdf = pw.Document();

  return pdf..addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      orientation: pw.PageOrientation.portrait,
      margin: const pw.EdgeInsets.all(16),
      footer: (context) {
        return pdfFooter(name, context, dakanjiLogo);
      },
      build: (pw.Context context) {
        return [
          for (JMdict entry in entries)
            ...[
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // translations
                  pw.Expanded(
                    child: pw.Table(
                      children: [
                        for (LanguageMeanings language in entry.meanings)
                          ...[
                            pw.TableRow(
                              children: [
                                pw.Padding(
                                  padding: const pw.EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: pw.SvgImage(
                                    svg: languageSVGs[isoToiso639_1[language.language]!.name]!,
                                    height: 10,
                                    width: 10
                                  )
                                )
                              ]
                            ),
                            for(var (i, meaning) in language.meanings
                              .sublist(0, min(language.meanings.length, maxMeanings))
                              .indexed)

                              pw.TableRow(
                                children: [
                                  pw.Text(
                                    () {
                                      int noElems = min(meaning.attributes.length, maxWordsPerMeaning);
                                      List sub = meaning.attributes.sublist(0, noElems);
                                      return "${i+1} ${sub.join(", ")}";
                                    }(),
                                    style: notoStyle,
                                    maxLines: maxLines
                                  ),
                                ]
                              )
                          ]
                      ]
                    )
                  ),
                  // japanese
                  pw.Expanded(
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: pw.Text(
                        () {
                          List<String> jap = [];

                          if(includeKana){
                            jap = entry.kanjis + entry.readings;
                          } else if(!includeKana){
                            if(entry.kanjis.isEmpty){
                              jap = entry.readings;
                            } else {
                              jap = entry.kanjis;
                            }
                          }

                          return jap.join("、");
                        } (),
                        style: notoStyle
                      )
                    )
                  )
                ]
              ),
              pw.Divider(),
            ]
        ];
      }
    )
  );
  
}

/// create the footer for the portrait pdf document
pw.Widget pdfFooter(String wordListName, pw.Context context, ByteData dakanjiLogo) {

  return pw.Container(
    alignment: pw.Alignment.centerRight,
    margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          wordListName,
          style: const pw.TextStyle(
            color: PdfColors.grey,
            fontSize: 10,
          ),
        ),
        pw.Image(
          pw.MemoryImage(
            dakanjiLogo.buffer.asUint8List()
          ),
          height: 25,
          width: 25
        ),
        pw.Text(
          'Page: ${context.pageNumber} of ${context.pagesCount}',
          style: const pw.TextStyle(
            color: PdfColors.grey,
            fontSize: 10,
          ),
        ),
      ]
    )
  );

}

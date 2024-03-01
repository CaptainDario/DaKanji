// Flutter imports:
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/settings/settings_word_lists.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// Project imports
import 'package:da_kanji_mobile/entities/word_lists/word_lists_queries.dart';

/// Exports the given word list as a PDF file
Future<pw.Document> pdfPortrait(List<int> wordIDs, String name) async {
  
  // Create document
  final pw.Document pdf = pw.Document();
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
  List<String> langsToInclude = GetIt.I<Settings>().dictionary.selectedTranslationLanguages
    .whereIndexed((index, element) => wl.includedLanguages[index])
    .map((e) => isoToiso639_2B[e]!.name)
    .toList();
  int maxMeanings = wl.pdfMaxMeaningsPerVocabulary;
  int maxWordsPerMeaning = 1;//wl.pdfMaxWordsPerMeaning;
  int maxLines = 1;// wl.pdfMaxLinesPerMeaning;
  bool includeKana = wl.pdfIncludeKana;

  // find all elements from the word list in the database
  List<JMdict> entries = await wordListEntriesForPDF(wordIDs, langsToInclude);


  pdf.addPage(
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
                                    svg: 
  """
  <svg xmlns="http://www.w3.org/2000/svg" id="flag-icons-de" viewBox="0 0 512 512">
    <path fill="#ffce00" d="M0 341.3h512V512H0z"/>
    <path d="M0 0h512v170.7H0z"/>
    <path fill="#d00" d="M0 170.7h512v170.6H0z"/>
  </svg>
  """,
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
                                      "${i+1} ${meaning.attributes.join(",")}",
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

  return pdf;

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

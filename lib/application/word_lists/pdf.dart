// Flutter imports:
import 'package:collection/collection.dart';
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
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

  // find all elements from the word list in the database
  List<String> langsToInclude = ["rus", "eng", "ger"];
  int maxTranslations = 3;
  bool includeKana = true;
  bool maxOneLine = true;
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
          for (JMdict entry in List.generate(5, (index) => entries.first))
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
                                    height: 8,
                                    width: 8
                                  )
                                )
                              ]
                            ),
                            pw.TableRow(
                              children: [
                                pw.Text(
                                  language.meanings.mapIndexed(
                                    (i, e) => "$i: ${e.attributes.join(", ")}")
                                  .join("\n"),
                                  style: notoStyle,
                                  //maxLines: 1
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
                        (entry.kanjis + entry.readings).join("、"),
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

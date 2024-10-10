import 'package:another_flushbar/flushbar.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';



/// Flushbar that shows which terms have been searched and allows changing 
/// the current search to one of them
class DictionaryAltSearchFlushbar {

  /// the search term text
  final String text;
  /// the search term text converted to kana (if possible)
  final String? queryKana;
  /// the search term text converted to kana and deconjugated (if possible)
  final String? deconjugated;
  /// Callback that is executed when the user taps on a search text as
  /// alternative search
  final Function(String text) onTapped;

  DictionaryAltSearchFlushbar(
    this.text,
    this.queryKana,
    this.deconjugated,
    this.onTapped,
  );

  Flushbar build(BuildContext context) {
    return Flushbar(
      backgroundColor: Colors.white,
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "${LocaleKeys.DictionaryScreen_search_searched.tr()} ",
                style: const TextStyle(
                  color: Colors.black
                ),
                children: [
                  TextSpan(
                    text: text,
                    style: TextStyle(
                      color: Theme.of(context).highlightColor
                    ),
                    recognizer: TapGestureRecognizer()..onTap =
                      () => onTapped(text),
                    children: const[
                      TextSpan(
                        text: "; ",
                        style: TextStyle(
                          color: Colors.black
                        ),
                      )
                    ]
                  ),
                  if(queryKana != null && queryKana != "")
                    TextSpan(
                      text: queryKana,
                      style: TextStyle(
                        color: Theme.of(context).highlightColor
                      ),
                      recognizer: TapGestureRecognizer()..onTap =
                        () => onTapped(queryKana!),
                      children: const[
                        TextSpan(
                          text: "; ",
                          style: TextStyle(
                            color: Colors.black
                          ),
                        )
                      ]
                    ),
                  if(deconjugated != null && deconjugated != "")
                    TextSpan(
                      text: deconjugated,
                      style: TextStyle(
                        color: Theme.of(context).highlightColor
                      ),
                      recognizer: TapGestureRecognizer()..onTap =
                        () => onTapped(deconjugated!),
                    ),
                ]
              )
            )
          ),
        ],
      ),
      flushbarPosition: FlushbarPosition.TOP,
      isDismissible: true,
      duration: const Duration(milliseconds: 10000),
    );
  }
}
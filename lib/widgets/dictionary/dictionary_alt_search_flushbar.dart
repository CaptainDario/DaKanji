// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/locales_keys.dart';

/// Flushbar that shows which terms have been searched and allows changing 
/// the current search to one of them
class DictionaryAltSearchFlushbar {

  /// the search term text
  final List<String> queries;
  /// Callback that is executed when the user taps on a search text as
  /// alternative search
  final Function(String text) onTapped;

  DictionaryAltSearchFlushbar(
    this.queries,
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
                  for (int i=0; i<queries.length; i++)
                    ...[
                      TextSpan(
                        text: "${i+1}. ${queries[i]}",
                        style: TextStyle(
                          color: Theme.of(context).highlightColor
                        ),
                        recognizer: TapGestureRecognizer()..onTap =
                          () => onTapped(queries[i]),
                      ),
                      if(i < queries.length-1)
                        const TextSpan(
                          text: "; ",
                          style: TextStyle(
                            color: Colors.black
                          ),
                        ),
                    ],
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

import 'package:da_kanji_mobile/widgets/kanji_table/kanji_details_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';



/// A widget that shows the given `kanji` separated by comma.
/// The `kanji` are clickable and open the kanji details page.
class LinkedKanjiText extends StatelessWidget {

  /// A list of kanji that should be linked
  final List<String> kanji;

  const LinkedKanjiText(
    this.kanji,
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        children: [
          for (String s in kanji)
            TextSpan(
              text: s,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => 
                      KanjiDetailsPage(s)
                    )
                  );
                }
            )
        ]
      )
    );
  }
}
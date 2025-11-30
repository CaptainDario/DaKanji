// Flutter imports:
import 'package:da_kanji_mobile/core/widgets/dakanji/dakanji_logo_text.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/core/widgets/dakanji/dakanji_loading_indicator.dart';

class DaKanjiSplash extends StatelessWidget {

  /// The text to show under the loading spinner
  final String? text;

  const DaKanjiSplash(
    {
      this.text,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DaKanjiLogoText(),
            const SizedBox(height: 20, width: 1,),
            const DaKanjiLoadingIndicator(),
            if(text != null)
              ...[
                const SizedBox(height: 8,),
                Text(
                  text!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey
                  ),
                ),
              ]
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';



class KanaInfoCard extends StatefulWidget {

  /// current kana
  final String kana;

  const KanaInfoCard(
    this.kana,
    {
      super.key
    }
  );

  @override
  State<KanaInfoCard> createState() => _KanaInfoCardState();
}

class _KanaInfoCardState extends State<KanaInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // kana
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.kana
                      ),
                    )
                  ),
                  // mnemonic
                  Expanded(
                    child: Center(
                      child: Text(
                        "ksdglkashflkajshflkjashlkfjh"
                      )
                    )
                  )
                ],
              ),
            ),
            Expanded(
              child: Wrap(
                clipBehavior: Clip.hardEdge,
                children: [
                  Text(
                    overflow: TextOverflow.fade,
                    "skdb;kjasbd;"
                  ),
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}
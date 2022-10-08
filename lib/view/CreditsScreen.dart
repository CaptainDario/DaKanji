import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



/// The "credits"-screen.
/// 
/// Shows the complete CREDITS.md 
class CreditsScreen extends StatefulWidget {

  
  @override
  State<CreditsScreen> createState() => _CreditsScreenState();
}

class _CreditsScreenState extends State<CreditsScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("$APP_TITLE - ${LocaleKeys.AboutScreen_credits.tr()}"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Center(
          child: 
            Container(
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<String>(
                      future: rootBundle.loadString("CREDITS.md"),
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          return Markdown(
                            data: snapshot.data!,
                            selectable: false,
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  ),
                ]
              )
            )
        ),
      ),
    );
  }
}

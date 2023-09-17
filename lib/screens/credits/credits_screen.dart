// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

/// The "credits"-screen.
/// 
/// Shows the complete CREDITS.md 
class CreditsScreen extends StatefulWidget {

  const CreditsScreen({Key? key}) : super(key: key);

  @override
  State<CreditsScreen> createState() => _CreditsScreenState();
}

class _CreditsScreenState extends State<CreditsScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("$g_AppTitle - ${LocaleKeys.AboutScreen_credits.tr()}"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Center(
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
                        onTapLink: (text, href, title) {
                          launchUrlString(href!);
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ),
            ]
          )
        ),
      ),
    );
  }
}

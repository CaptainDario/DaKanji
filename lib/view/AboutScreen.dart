import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/model/Screens.dart';
import 'package:da_kanji_mobile/helper/reviews.dart';
import 'package:da_kanji_mobile/view/drawer/Drawer.dart';
import 'package:da_kanji_mobile/view/ChangelogScreen.dart';
import 'package:da_kanji_mobile/view/CreditsScreen.dart';
import 'package:da_kanji_mobile/model/PlatformDependentVariables.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/globals.dart';



/// The "about"-screen
/// 
/// Shows the *about.md* and a link to the "changelog"-screen 
class AboutScreen extends StatelessWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;

  final String about = LocaleKeys.AboutScreen_about_text.tr(namedArgs : {
    "GITHUB_ISSUES" : GITHUB_ISSUES,
    "PRIVACY_POLICE" : PRIVACY_POLICE,
    "RATE_ON_MOBILE_STORE" : GetIt.I<PlatformDependentVariables>().appStoreLink,
    "DAAPPLAB_STORE_PAGE" : GetIt.I<PlatformDependentVariables>().daapplabStorePage,
    "DISCORD_SERVER" : DISCORD_INVITE,
    "PLAYSTORE_PAGE" : PLAYSTORE_PAGE,
    "APPSTORE_PAGE" : APPSTORE_PAGE,
    "MACSTORE_PAGE" : APPSTORE_PAGE,
    "SNAPSTORE_PAGE" : SNAPSTORE_PAGE,
    "MICROSOFT_STORE_PAGE" : MICROSOFT_STORE_PAGE,
    "GITHUB_RELEASES_PAGE" : GITHUB_RELEASES_PAGE,
  });
  AboutScreen(this.openedByDrawer);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DaKanjiDrawer(
        currentScreen: Screens.about,
        animationAtStart: !this.openedByDrawer,
        child: SingleChildScrollView(
          primary: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: AssetImage("assets/images/icons/banner.png"), width: 200,),
              // show the about.md
              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 2),
                child: MarkdownBody(
                  data: about,
                  styleSheet: MarkdownStyleSheet(
                    a: TextStyle( 
                      color: Theme.of(context).highlightColor,
                      //fontSize: 20,
                    ),
                    p: TextStyle( 
                      //fontSize: 20,
                    )
                  ),
                  onTapLink: (text, url, title) {
                    
                    if(url == "daapplab@gmail.com"){
                      String mail = Uri(
                        scheme: 'mailto',  
                        path: url, 
                        query: 'subject=DaKanji${VERSION}: &body=I am using DaKanji v.${VERSION} on ${Theme.of(context).platform.name}',
                      ).toString();
                      launch(mail);
                    }
                    else
                      launch(Uri.encodeFull(url ?? ""));
                    
                  },
                ),
              ),
              // text with link to open the "complete changelog"-screen
              Container(
                padding: EdgeInsets.fromLTRB(16, 2, 16, 0),
                child: GestureDetector(
                  child: Text(
                    LocaleKeys.AboutScreen_show_changelog.tr(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).highlightColor
                    ),
                  ),
                  onTap: () => Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => ChangelogScreen()),
                  )
                )
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 2),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          openReview();
                        }, 
                        child: Text(LocaleKeys.General_rate_this_app.tr())
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 2),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          showAboutDialog(
                            context: context,
                            applicationName: APP_TITLE,
                            applicationVersion: VERSION,
                            applicationIcon: Image(
                              image: AssetImage("assets/images/icons/icon.png",),
                              width: 50,
                            ) 
                          );
                        }, 
                        child: Text(LocaleKeys.AboutScreen_software_informations_button.tr())
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 2),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => CreditsScreen()),
                          );
                        }, 
                        child: Text("Credits"),//LocaleKeys.AboutScreen_credits.tr())
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}

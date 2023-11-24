

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:da_kanji_mobile/application/helper/reviews.dart';
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/domain/platform_dependent_variables.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/screens/changelog/changelog_screen.dart';
import 'package:da_kanji_mobile/screens/credits/credits_screen.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';

/// The "about"-screen
/// 
/// Shows the *about.md* and a link to the "changelog"-screen 
class AboutScreen extends StatelessWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;

  final String about = LocaleKeys.AboutScreen_about_text.tr(namedArgs : {
    "GITHUB_ISSUES" : g_GithubIssues,
    "PRIVACY_POLICE" : g_PrivacyPoliceUrl,
    "RATE_ON_MOBILE_STORE" : GetIt.I<PlatformDependentVariables>().appStoreLink,
    "DAAPPLAB_STORE_PAGE" : GetIt.I<PlatformDependentVariables>().daapplabStorePage,
    "DISCORD_SERVER" : g_DiscordInvite,
    "PLAYSTORE_PAGE" : g_PlaystorePage,
    "APPSTORE_PAGE" : g_AppStorePage,
    "MACSTORE_PAGE" : g_AppStorePage,
    "SNAPSTORE_PAGE" : g_SnapStorePage,
    "MICROSOFT_STORE_PAGE" : g_MicrosoftStorePage,
    "GITHUB_RELEASES_PAGE" : g_GithubReleasesPage,
  });

  AboutScreen(this.openedByDrawer, {Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DaKanjiDrawer(
        currentScreen: Screens.about,
        drawerClosed: !openedByDrawer,
        child: SingleChildScrollView(
          primary: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(image: AssetImage("assets/images/dakanji/banner.png"), width: 200,),
              // show the about.md
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 2),
                child: MarkdownBody(
                  data: about,
                  styleSheet: MarkdownStyleSheet(
                    a: TextStyle( 
                      color: Theme.of(context).highlightColor,
                      //fontSize: 20,
                    ),
                    p: const TextStyle( 
                      //fontSize: 20,
                    )
                  ),
                  onTapLink: (text, url, title) {
                    if(url != null) {
                      launchUrlString(
                        Uri.encodeFull(url),
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                ),
              ),
              // text with link to open the "complete changelog"-screen
              Container(
                padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
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
                    MaterialPageRoute(builder: (context) => const ChangelogScreen()),
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 2),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          openReview();
                        }, 
                        child: Text(LocaleKeys.HomeScreen_rate_this_app.tr())
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 2),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          showAboutDialog(
                            context: context,
                            applicationName: g_AppTitle,
                            applicationVersion: g_Version.fullVersionString,
                            applicationIcon: const Image(
                              image: AssetImage("assets/images/dakanji/icon.png",),
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
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 2),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => const CreditsScreen()),
                          );
                        }, 
                        child: Text(LocaleKeys.AboutScreen_credits.tr())
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

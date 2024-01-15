// Flutter imports:
import 'package:da_kanji_mobile/repositories/analytics/post.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/application/helper/stores.dart';
import 'package:da_kanji_mobile/application/routing/deep_links.dart';
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/init.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/repositories/releases/releases.dart';
import 'package:da_kanji_mobile/widgets/home/downgrade_dialog.dart';
import 'package:da_kanji_mobile/widgets/home/rate_dialog.dart' as rate_popup;
import 'package:da_kanji_mobile/widgets/home/whats_new_dialog.dart';
import 'package:da_kanji_mobile/widgets/widgets/dakanji_splash.dart';

/// The "home"-screen
/// 
/// If this is the first app start or a new feature was added shows the
/// onBoarding
/// If a new version was installed shows a popup with the CHANGELOG of this 
/// version.
/// If the app was opened enough times shows a popup asking the user to rate the
/// app.
/// If different version was installed that usese a different dictionary, etc.
/// asks the user to download the new data.
/// Otherwise navigates to the "dictionary"-screen.
class HomeScreen extends StatefulWidget {

  const HomeScreen(
    {
      Key? key
    }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    setupApp();
  }

  /// Setup the app by showing the changelog, onboarding, rate popup or 
  /// dwonloading the data necessary for this release
  Future<void> setupApp() async {

    await initDocumentsServices(context);

    // track first installs
    if(GetIt.I<UserData>().appOpenedTimes <= 1){
      logDefaultEvent("New/Re install");
      GetIt.I<UserData>().save();
    }
    // check if an update is available
    if(GetIt.I<UserData>().userRefusedUpdate == null ||
      DateTime.now().difference(GetIt.I<UserData>().userRefusedUpdate!).inDays > g_daysToWaitBeforeAskingForUpdate){
      List<String> updates = await updateAvailable();
      if(updates.isNotEmpty) {
        await showUpdatePopup(updates);
      }
    }

    if(GetIt.I<UserData>().showChangelog){
      await showChangelog();
    }
    if(GetIt.I<UserData>().olderVersionUsed){
      await showDowngradeWarning();
    }
    if(GetIt.I<UserData>().showRateDialog){
      await showRatePopup();
    }
    if(GetIt.I<UserData>().showOnboarding){
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context, "/${Screens.onboarding.name}", (route) => false
      );
    }
    else {
      // if there is a deep link at app start handle it
      String? deepLink = await g_AppLinks.getInitialAppLinkString();
      if(deepLink != null && !g_initialDeepLinkHandled){
        g_initialDeepLinkHandled = true;
        handleDeepLink(deepLink);
      }
      // otherwise load the default screen
      else{
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(context, 
          "/${GetIt.I<Settings>().misc.startupScreens[GetIt.I<Settings>().misc.selectedStartupScreen].name}", 
          (route) => false
        );
      }
    }
  }

  /// Opens a popup that informs the user that an update is available
  Future<void> showUpdatePopup(List<String> changelog) async {
    // show a popup with the changelog of the new version
    await AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      btnOkColor: g_Dakanji_green,
      btnOkText: LocaleKeys.General_download.tr(),
      btnOkOnPress: () {
        openStoreListing();
      },
      btnCancelColor: g_Dakanji_red,
      btnCancelOnPress: () async {},
      onDismissCallback: (dismisstype) async {
        GetIt.I<UserData>().userRefusedUpdate = DateTime.now();
        await GetIt.I<UserData>().save();
      },
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  "🔥 ${LocaleKeys.HomeScreen_new_version_available_heading.tr()} 🔥",
                  style: const TextStyle(
                    fontSize: 24
                  ),
                )
              ),
              const SizedBox(height: 8,),
              Text(changelog.first.replaceAll("\n", "")),
              const SizedBox(height: 16,),
              MarkdownBody(
                data: changelog.sublist(1).join(),
              ),
            ],
          ),
        ),
      ),
    ).show();
  }

  /// Shows a popup with the changelog of the current version
  Future<void> showChangelog() async {
    // opem the changelog popup
    await AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      body: const WhatsNewDialogue(),
    ).show();

    GetIt.I<UserData>().showChangelog = false;
    GetIt.I<UserData>().save();
  }

  /// Shows a warning popup advices when downgrading versions
  Future<void> showDowngradeWarning() async {
    // opem the changelog popup
    await AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      body: const DowngradeDialog(),
    ).show();
  }

  /// Shows a rate popup which lets the user rate the app
  Future<void> showRatePopup() async {
    // show a rating dialogue WITHOUT "do not show again"-option
    if(GetIt.I<UserData>().appOpenedTimes < g_MinTimesOpenedToAsknotShowRate) {
      await rate_popup.showRateDialog(context, false);
    }
    else {
      await rate_popup.showRateDialog(context, true);
    }

    GetIt.I<UserData>().showRateDialog = false;
    GetIt.I<UserData>().save();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<String>(
        stream: g_initAppInfoStream.stream,
        builder: (context, snapshot) {
          return DaKanjiSplash(
            text: snapshot.data,
          );
        }
      ),
    );
  }
}

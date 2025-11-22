// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:da_kanji_mobile/features/feedback/controller/stores.dart';
import 'package:da_kanji_mobile/core/migration/migration.dart';
import 'package:da_kanji_mobile/core/routing/deep_links.dart';
import 'package:da_kanji_mobile/core/releases/version.dart';
import 'package:da_kanji_mobile/core/routing/screens.dart';
import 'package:da_kanji_mobile/features/settings/model/settings.dart';
import 'package:da_kanji_mobile/core/user/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/features/init/controller/init.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/core/analytics/event_logging.dart';
import 'package:da_kanji_mobile/core/releases/releases.dart';
import 'package:da_kanji_mobile/features/init/widgets/downgrade_dialog.dart';
import 'package:da_kanji_mobile/features/init/widgets/rate_dialog.dart' as rate_popup;
import 'package:da_kanji_mobile/features/init/widgets/whats_new_dialog.dart';
import 'package:da_kanji_mobile/core/widgets/dakanji_splash.dart';

/// The "init"-screen
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
class InitScreen extends StatefulWidget {

  const InitScreen(
    {
      super.key
    });

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {

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
      cacheDefaultEvent(installEventName);
      GetIt.I<UserData>().save();
    }
    // check if an update is available
    if(GetIt.I<UserData>().userRefusedUpdate == null ||
      DateTime.now().difference(GetIt.I<UserData>().userRefusedUpdate!).inDays > g_daysToWaitBeforeAskingForUpdate){
      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> updates = prefs.getStringList("updateAvailable") ?? [];
      Version updateVersion = Version.fromStringFull(prefs.getString("updateVersion") ?? "0.0.0+0");
      
      if(updates.isNotEmpty && updateVersion > g_Version) {
        await showUpdatePopup(updates);
        prefs.setStringList("updateAvailable", []);
        prefs.setString("updateVersion", "");
      }
      else{
        updateAvailable();
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
      Navigator.pushNamedAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        "/${Screens.onboarding.name}", (route) => false);
    }
    else {
      // if there is a deep link at app start handle it
      Uri? deepLink = await g_AppLinks.getInitialLink();
      bool handled = false;
      if(deepLink != null && !g_initialDeepLinkHandled){
        g_initialDeepLinkHandled = true;
        handled = handleDeepLink(deepLink);
      }
      // otherwise load the default screen
      if(!handled && mounted){
        Navigator.pushNamedAndRemoveUntil(context, 
          "/${GetIt.I<Settings>().misc.startupScreens[GetIt.I<Settings>().misc.selectedStartupScreen].name}", 
          (route) => false
        );
      }
    }

    // migrate data if necessary
    migrate(GetIt.I<UserData>().versionUsed, g_Version);

    // setup is done move the desktop window
    await desktopWindowSetup();
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
        GetIt.I<UserData>().userRefusedUpdate = DateTime.now().toUtc();
        await GetIt.I<UserData>().save();
      },
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  "🔥 ${LocaleKeys.InitScreen_new_version_available_heading.tr()} 🔥",
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

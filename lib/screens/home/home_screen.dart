// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/application/releases/releases.dart';
import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/init.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/home/rate_dialog.dart' as ratePopup;
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
  _HomeScreenState createState() => _HomeScreenState();
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

    if(GetIt.I<UserData>().userRefusedUpdate == null ||
      DateTime.now().difference(GetIt.I<UserData>().userRefusedUpdate!).inDays > g_daysToWaitBeforeAskingForUpdate){
      List<String> updates = await updateAvailable();
      if(updates.isNotEmpty)
        await showUpdatePopup(updates);
    }

    if(GetIt.I<UserData>().showChangelog){
      await showChangelog();
    }
    if(GetIt.I<UserData>().showRateDialog){
      await showRatePopup();
    }
    if(GetIt.I<UserData>().showOnboarding){
      Navigator.pushNamedAndRemoveUntil(
        context, "/${Screens.onboarding.name}", (route) => false
      );
    }
    else {
      Navigator.pushNamedAndRemoveUntil(context, 
        "/${GetIt.I<Settings>().misc.startupScreens[GetIt.I<Settings>().misc.selectedStartupScreen].name}", 
        (route) => false
      );
    }
  }

  Future<void> showUpdatePopup(List<String> changelog) async {
    // show a popup with the changelog of the new version
    await AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      btnOkColor: g_Dakanji_green,
      btnOkText: "Download",
      btnOkOnPress: () {
        openStoreListing();
      },
      btnCancelColor: g_Dakanji_red,
      btnCancelOnPress: () async {},
      onDismissCallback: (dismisstype) async {
        GetIt.I<UserData>().userRefusedUpdate = DateTime.now();
        await GetIt.I<UserData>().save();
      },
      body: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  "🔥 ${LocaleKeys.HomeScreen_new_version_available_heading.tr()} 🔥",
                  style: TextStyle(
                    fontSize: 24
                  ),
                )
              ),
              SizedBox(height: 8,),
              Text(changelog.first.replaceAll("\n", "")),
              SizedBox(height: 16,),
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
      body: WhatsNewDialogue(),
    ).show();

    GetIt.I<UserData>().showChangelog = false;
    GetIt.I<UserData>().save();
  }

  /// Shows a rate popup which lets the user rate the app
  Future<void> showRatePopup() async {
    // show a rating dialogue WITHOUT "do not show again"-option
    if(GetIt.I<UserData>().appOpenedTimes < g_MinTimesOpenedToAsknotShowRate) {
      await ratePopup.showRateDialog(context, false);
    }
    else {
      await ratePopup.showRateDialog(context, true);
    }

    GetIt.I<UserData>().showRateDialog = false;
    GetIt.I<UserData>().save();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<String>(
        stream: g_downloadFromGHStream.stream,
        builder: (context, snapshot) {
          return DaKanjiSplash(
            text: snapshot.data,
          );
        }
      ),
    );
  }
}

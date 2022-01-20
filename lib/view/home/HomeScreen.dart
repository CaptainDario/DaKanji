import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/provider/Changelog.dart';
import 'package:da_kanji_mobile/provider/UserData.dart';
import 'package:da_kanji_mobile/view/ChangelogScreen.dart';
import 'package:da_kanji_mobile/view/home/RatePopup.dart';



/// The "home"-screen
/// 
/// If a new version was installed shows a popup with the CHANGELOG of this 
/// version. Otherwise navigates to the "draw"-screen.
class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late ScrollController _scrollController;

  @override
  void initState() { 
    super.initState();

    _scrollController = ScrollController();

    // after the page was build 
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {

      final appOpenedTimes = GetIt.I<UserData>().appOpenedTimes;
      // show a rating dialogue WITHOUT "do not show again"-option
      if(!GetIt.I<UserData>().doNotShowRateAgain && 
        !GetIt.I<UserData>().rateDialogueWasShown && 
        appOpenedTimes < 31 && appOpenedTimes % 10 == 0)
          showRatePopup(context, false);
        
        // show a rating dialogue WITH "do not show again"-option
        else if(!GetIt.I<UserData>().doNotShowRateAgain && 
          !GetIt.I<UserData>().rateDialogueWasShown && 
          appOpenedTimes > 31 && appOpenedTimes % 10 == 0)
          showRatePopup(context, true);
      

      // if a newer version was installed open the what's new pop up 
      else if(GetIt.I<Changelog>().showChangelog){

        GetIt.I<Changelog>().showChangelog = false;

        // what's new dialogue
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.INFO,
          headerAnimationLoop: false,
          body: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                // Header
                Center(
                  child: Text(
                    "🎉 What's new 🎉",
                    textScaleFactor: 2,
                  )
                ),
                // content
                SizedBox(
                  child: Scrollbar(
                    isAlwaysShown: true,
                    controller: _scrollController,
                    child: Markdown(
                      selectable: false,
                      controller: _scrollController,
                      data: GetIt.I<Changelog>().newestChangelog,
                      onTapLink:
                      (String text, String? url, String title) async {
                        if(url != null){
                          if(await canLaunch(url)) launch(url);
                        }
                      },
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 3/4,
                  height: MediaQuery.of(context).size.height * 2/4,
                ),
                // buttons
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  runAlignment: WrapAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: 
                          MaterialStateProperty.all(
                            Color.fromARGB(100, 150, 150, 150)
                          )
                      ),
                      onPressed: () => Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => ChangelogScreen()),
                      ),
                      child: Text("Complete log")
                    ),
                    SizedBox(width: 5,),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: 
                          MaterialStateProperty.all(
                            Color.fromARGB(100, 150, 150, 150)
                          )
                      ),
                      onPressed: () async {
                        GetIt.I<Settings>().save();
                        Navigator.pushNamedAndRemoveUntil(
                          context, "/home", (Route<dynamic> route) => false);
                      },
                      child: Text("close")
                    ),
                  ],
                )
              ]
            )
          ),
          onDissmissCallback: (_) {
            // save that the dialogue was shown and open the default screen
            GetIt.I<Settings>().save();
            Navigator.pushNamedAndRemoveUntil(
              context, "/home", (Route<dynamic> route) => false);
          }
        )..show();
      }
      // otherwise open the default screen
      else{
        Navigator.pushNamedAndRemoveUntil(context, "/drawing", (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold();
  }
}

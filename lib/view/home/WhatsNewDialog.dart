import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

import 'package:da_kanji_mobile/view/ChangelogScreen.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/provider/Changelog.dart';



AwesomeDialog WhatsNewDialogue(BuildContext context) {

  ScrollController _scrollController = ScrollController();

  return AwesomeDialog(
    context: context,
    animType: AnimType.BOTTOMSLIDE,
    dialogType: DialogType.NO_HEADER,
    aligment: Alignment.center,
    
    body: Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Center(
            child: Text(
              "What's new",
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
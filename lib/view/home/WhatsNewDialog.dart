import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:da_kanji_mobile/view/ControllableLottieAnimation.dart';

import 'package:da_kanji_mobile/view/ChangelogScreen.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/provider/Changelog.dart';



Widget WhatsNewDialogue(BuildContext context, 
  ControllableLottieAnimation confettiAnimation_1,
  ControllableLottieAnimation confettiAnimation_2,) {

  ScrollController _scrollController = ScrollController();

  return Center(
    child: Container(
      height: MediaQuery.of(context).size.height * 4/5,
      width:  MediaQuery.of(context).size.width * 4/5,
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            spreadRadius: 7.5,
            blurRadius: 10,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(5),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //header
                Center(
                  child: Text(
                    "What's new",
                    textScaleFactor: 2,
                  )
                ),
                // content
                Container(
                  //color: Colors.green,
                  width: MediaQuery.of(context).size.width * 4/5,
                  height: MediaQuery.of(context).size.height * 4/5 * 0.85,
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
                ),
                // buttons
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  runAlignment: WrapAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
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
            ),
            Positioned(
              top: 0,
              left: 0,
              height: MediaQuery.of(context).size.height * 4/5,
              child: IgnorePointer(
                child: confettiAnimation_1
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 4/5,
              child: IgnorePointer(
                child: confettiAnimation_2
              ),
            ),
          ],
        )
      ),
    ),
  );

}
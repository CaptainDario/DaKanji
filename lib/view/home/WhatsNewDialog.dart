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
  ControllableLottieAnimation confettiAnimation_2,
  ControllableLottieAnimation confettiAnimation_3,) {

  ScrollController _scrollController = ScrollController();

  double innerDialogueHeight = (MediaQuery.of(context).size.height * 4/5) - 10;
  double innerDialogueWidth = (MediaQuery.of(context).size.width * 4/5) - 10;

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
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //header
                Container(
                  height: innerDialogueHeight * 0.1,
                  width:  innerDialogueWidth,
                  child: Center(
                    child: Text(
                      "What's new",
                      textScaleFactor: 2,
                    ),
                  ),
                ),
                // content
                Container(
                  height: innerDialogueHeight * 0.8,
                  width: innerDialogueWidth,
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
                Container(
                  height: innerDialogueHeight * 0.1,
                  width: innerDialogueWidth,
                  child: Wrap(
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
                  ),
                )
              ]
            ),
            
            Positioned(
              top: -innerDialogueWidth,
              right: -innerDialogueWidth,
              height: innerDialogueWidth*2,
              width: innerDialogueWidth*2,
              child: Container(
                //color: Colors.black,
                child: IgnorePointer(
                  child: confettiAnimation_1
                ),
              ),
            ),
            Positioned(
              bottom: -innerDialogueWidth/2,
              left: -innerDialogueWidth,
              height: innerDialogueWidth*2,
              width: innerDialogueWidth*2,
              child: IgnorePointer(
                child: confettiAnimation_2
              ),
            ),
            Positioned(
              bottom: -innerDialogueWidth/2,
              right: -innerDialogueWidth,
              height: innerDialogueWidth*2,
              width: innerDialogueWidth*2,
              child: IgnorePointer(
                child: confettiAnimation_3
              ),
            ),
          ],
        )
      ),
    ),
  );

}
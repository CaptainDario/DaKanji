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

    return Container(
      padding: EdgeInsets.all(5),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            children: [
              Center(
                child: Text(
                  "What's new",
                  textScaleFactor: 2,
                )
              ),
              // content
              Container(
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
                width: MediaQuery.of(context).size.width * 4/5,
                height: MediaQuery.of(context).size.height * 4/5 - 75,
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
          ),
          Positioned(
            top: 0,
            left: 0,
            child: IgnorePointer(
              child: confettiAnimation_1
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IgnorePointer(
              child: confettiAnimation_2
            ),
          ),
        ],
      )
    );

}
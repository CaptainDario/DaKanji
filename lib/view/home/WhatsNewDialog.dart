import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/view/ControllableLottieAnimation.dart';
import 'package:da_kanji_mobile/view/ChangelogScreen.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/model/Changelog.dart';


class WhatsNewDialogue extends StatelessWidget {
  WhatsNewDialogue(
    this.confettiAnimation_1,
    this.confettiAnimation_2,
    this.confettiAnimation_3,
    {Key? key}
  ) : super(key: key);

  final ControllableLottieAnimation confettiAnimation_1;
  final ControllableLottieAnimation confettiAnimation_2;
  final ControllableLottieAnimation confettiAnimation_3;

  @override
  Widget build(BuildContext context) {

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
                    height: (innerDialogueHeight * 0.1).clamp(0.0, 40) ,
                    width:  innerDialogueWidth,
                    child: FittedBox(
                      child: Center(
                        child: Text(
                          LocaleKeys.General_whats_new.tr(),
                          textScaleFactor: 2,
                        ),
                      ),
                    ),
                  ),
                  // content
                  Container(
                    height: innerDialogueHeight * 0.8,
                    width: innerDialogueWidth,
                    child: Scrollbar(
                      thumbVisibility: true,
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
                        Container(
                          width: innerDialogueWidth*0.45,
                          child: ElevatedButton(
                            onPressed: () => Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => ChangelogScreen()),
                            ),
                            child: Text(
                              LocaleKeys.General_complete_log.tr(),
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis
                              ),
                            )
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                          width: innerDialogueWidth*0.45,
                          child: ElevatedButton(
                            style: ButtonStyle(
                            ),
                            onPressed: () async {
                              GetIt.I<Settings>().save();
                              Navigator.pushNamedAndRemoveUntil(
                                context, "/home", (Route<dynamic> route) => false);
                            },
                            child: Text(
                              LocaleKeys.General_close.tr(),
                            )
                          ),
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
}
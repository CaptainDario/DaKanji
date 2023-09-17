// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:da_kanji_mobile/domain/changelog.dart';
import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/screens/changelog/changelog_screen.dart';

class WhatsNewDialogue extends StatefulWidget {
  const WhatsNewDialogue(
    {Key? key}
  ) : super(key: key);

  @override
  State<WhatsNewDialogue> createState() => _WhatsNewDialogueState();
}

class _WhatsNewDialogueState extends State<WhatsNewDialogue>
  with TickerProviderStateMixin {

  /// controller for the confetti animation 1
  late AnimationController animControl_1;
  /// controller for the confetti animation 2
  late AnimationController animControl_2;
  /// controller for the confetti animation 3
  late AnimationController animControl_3;

  @override
  void initState() {
    super.initState();

    animControl_1 = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000),
    )..addListener(() {
      if(animControl_1.value == 0.5) animControl_2.forward();
    });
    animControl_2 = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000),
    )..addListener(() {
      if(animControl_2.value == 0.5) animControl_3.forward();
    });
    animControl_3 = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(milliseconds: 50), () {})
        .then((value) => animControl_1.forward());
    });
  }

  @override
  Widget build(BuildContext context) {

    ScrollController _scrollController = ScrollController();

    double innerDialogueHeight = (MediaQuery.of(context).size.height * 4/5) - 10;
    double innerDialogueWidth = (MediaQuery.of(context).size.width * 4/5) - 10;

    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 4/5,
        width:  MediaQuery.of(context).size.width * 4/5,
        
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //header
                  SizedBox(
                    height: (innerDialogueHeight * 0.1).clamp(0.0, 40) ,
                    width:  innerDialogueWidth,
                    child: FittedBox(
                      child: Center(
                        child: Text(
                          "🎉 ${LocaleKeys.HomeScreen_whats_new.tr()} 🎉",
                          textScaleFactor: 2,
                        ),
                      ),
                    ),
                  ),
                  // content
                  SizedBox(
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
                            if(await canLaunchUrlString(url)) {
                              launchUrlString(url);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  // buttons
                  SizedBox(
                    height: innerDialogueHeight * 0.1,
                    width: innerDialogueWidth,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // complete log button
                          ElevatedButton(
                            onPressed: () => Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => const ChangelogScreen()),
                            ),
                            child: Text(
                              LocaleKeys.HomeScreen_complete_log.tr(),
                              maxLines: 1,
                              style: const TextStyle(
                                //overflow: TextOverflow
                              ),
                            )
                          ),
                          const SizedBox(width: 5,),
                          // close button
                          ElevatedButton(
                            style: const ButtonStyle(
                            ),
                            onPressed: () async {
                              GetIt.I<Settings>().save();
                              Navigator.pop(context);
                            },
                            child: Text(
                              LocaleKeys.General_close.tr(),
                            )
                          ),
                        ],
                      ),
                    ),
                  )
                ]
              ),
              
              Positioned(
                top: -innerDialogueWidth,
                right: -innerDialogueWidth,
                height: innerDialogueWidth*2,
                width: innerDialogueWidth*2,
                child: IgnorePointer(
                  child: Lottie.asset(
                    "assets/animations/confetti.json",
                    controller: animControl_1,
                  ),
                ),
              ),
              Positioned(
                bottom: -innerDialogueWidth/2,
                left: -innerDialogueWidth,
                height: innerDialogueWidth*2,
                width: innerDialogueWidth*2,
                child: IgnorePointer(
                  child: Lottie.asset(
                    "assets/animations/confetti.json",
                    controller: animControl_2,
                  )
                ),
              ),
              Positioned(
                bottom: -innerDialogueWidth/2,
                right: -innerDialogueWidth,
                height: innerDialogueWidth*2,
                width: innerDialogueWidth*2,
                child: IgnorePointer(
                  child: Lottie.asset(
                    "assets/animations/confetti.json",
                    controller: animControl_3,
                  )
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}

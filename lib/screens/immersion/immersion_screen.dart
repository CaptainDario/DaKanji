import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/immersion/youtube_browser.dart';
import 'package:flutter/material.dart';



class ImmersionScreen extends StatefulWidget {
  
    /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;


  const ImmersionScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<ImmersionScreen> createState() => _ImmersionScreenState();
}

class _ImmersionScreenState extends State<ImmersionScreen> {

  List<IconData> navigationIcons = const [
    Icons.youtube_searched_for,
    Icons.video_library,
    Icons.public,
    Icons.auto_stories,
    Icons.computer
  ];

  List<String> navigationLabels = const [
    "YT",
    "Video",
    "Web",
    "Read",
    "Screen"
  ];

  int _selectedIndex = 0;

  Widget currentNavigationTarget = YoutubeBrowser();


  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      drawerClosed: !widget.openedByDrawer,
      currentScreen: Screens.immersion,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxHeight > constraints.maxWidth
            ? Column(
              children: [
                Expanded(
                  child: currentNavigationTarget
                ),
                NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onDestinationSelected,
                  destinations: [
                    for (int i = 0; i < navigationIcons.length; i++)
                      NavigationDestination(
                        icon: Icon(navigationIcons[i]),
                        label: navigationLabels[i]
                      )
                  ],
                ),
              ],
            )
            : Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onDestinationSelected,
                  destinations: [
                    for (int i = 0; i < navigationIcons.length; i++)
                      NavigationRailDestination(
                        icon: Icon(navigationIcons[i]),
                        label: Text(navigationLabels[i])
                      )
                  ],
                ),
                Expanded(
                  child: currentNavigationTarget,
                )
              ],
            );
        },
      )
    );
  }

  void _onDestinationSelected (value) {
    if(value == currentNavigationTarget) return;

    if(value == 0){
      currentNavigationTarget = const YoutubeBrowser();
    }
    else{
      currentNavigationTarget = Container();
    }
    setState(() {
      _selectedIndex = value;
    });
  }
}
// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/application/helper/feedback.dart';
import 'package:da_kanji_mobile/entities/da_kanji_icons_icons.dart';
import 'package:da_kanji_mobile/entities/drawer/drawer_entries.dart';
import 'package:da_kanji_mobile/entities/drawer/drawer_listener.dart';
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer_app_bar.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer_element.dart';

/// Da Kanji's drawer.
/// 
/// It connects the main screens of the app with each other.
/// Currently: *Drawing*, *Settings*, *About*
class DaKanjiDrawer extends StatefulWidget{

  /// The actual page to show when the drawer is not visible.
  final Widget child;
  /// If set to true, the app will include a back-arrow instead of the hamburger
  /// menu (useful if a sceen should just be shown shortly and the user likely
  /// want to go back to the previous screen)
  final bool useBackArrowAppBar;
  /// The currently selected screen
  final Screens currentScreen;
  /// is the drawer closed when initializing it
  final bool drawerClosed;


  const DaKanjiDrawer(
    {
      required this.currentScreen,
      required this.child,
      this.useBackArrowAppBar = false,
      this.drawerClosed = true,
      Key? key, 
    }
  ) : super(key: key);

  @override
  DaKanjiDrawerState createState() => DaKanjiDrawerState();
}

class DaKanjiDrawerState extends State<DaKanjiDrawer> 
  with SingleTickerProviderStateMixin{

  /// The controller for the drawer animation
  late AnimationController _drawerController;
  /// The drawer animation
  late Animation _moveDrawer;
  /// the width of the drawer
  late double _drawerWidth;
  /// the width of the screen
  late double _screenWidth;
  /// the height of the screen
  late double _screenHeight;
  /// function to open/close the drawer (invoked when DrawerListener changed)
  late void Function() _handleDrawer; 


  List<DrawerEntry> drawerEntries = [
    DrawerEntry(
      Icons.brush, LocaleKeys.DrawScreen_title.tr(),
      "/${Screens.drawing.name}", Screens.drawing,
      null, null,
      true, null),
    DrawerEntry(
      Icons.book, LocaleKeys.DictionaryScreen_title.tr(),
      "/${Screens.dictionary.name}", Screens.dictionary,
      null, null,
      true, null),
    DrawerEntry(
      Icons.text_snippet, LocaleKeys.TextScreen_title.tr(),
      "/${Screens.text.name}", Screens.text,
      null, null,
      true, null),
    DrawerEntry(
      DaKanjiIcons.dojg, LocaleKeys.DojgScreen_title.tr(),
      "/${Screens.dojg.name}", Screens.dojg,
      null, null,
      true, null),
    DrawerEntry(
      DaKanjiIcons.kanji_table, LocaleKeys.KanjiTableScreen_title.tr(),
      "/${Screens.kanjiTable.name}", Screens.kanjiTable,
      null, null,
      true, null),
    if(kDebugMode)
      DrawerEntry(
        DaKanjiIcons.kanji_trainer, LocaleKeys.KanjiTrainerScreen_title.tr(),
        "/${Screens.kanjiTrainer.name}", Screens.kanjiTrainer,
        null, null,
        kDebugMode, null),
    DrawerEntry(
      DaKanjiIcons.kana_table, LocaleKeys.KanaTableScreen_title.tr(),
      "/${Screens.kanaTable.name}", Screens.kanaTable,
      null, null,
      true, null),
    if(kDebugMode)
      DrawerEntry(
        DaKanjiIcons.kana_trainer, LocaleKeys.KanaTrainerScreen_title.tr(),
        "/${Screens.kanaTrainer.name}", Screens.kanaTrainer,
        null, null,
        kDebugMode, null),
    if(kDebugMode)
      DrawerEntry(
        Icons.list_outlined, LocaleKeys.WordListsScreen_title.tr(),
        "/${Screens.wordLists.name}", Screens.wordLists,
        null, const Alignment(0, -0.1),
      kDebugMode, null),
    DrawerEntry(
      Icons.copy_rounded, LocaleKeys.ClipboardScreen_title.tr(),
      "/${Screens.clipboard.name}", Screens.clipboard,
      null, null,
      true, null),
    DrawerEntry(
      Icons.settings_applications, LocaleKeys.SettingsScreen_title.tr(),
      "/${Screens.settings.name}", Screens.settings,
      null, null,
      true, null),
    DrawerEntry(
      Icons.info, LocaleKeys.AboutScreen_title.tr(),
      "/${Screens.about.name}", Screens.about,
      null, null,
      true, null),
    DrawerEntry(
      Icons.help, LocaleKeys.ManualScreen_title.tr(),
      "/${Screens.manual.name}", Screens.manual,
      null, null,
      true, null),
    DrawerEntry(Icons.feedback, LocaleKeys.FeedbackScreen_title.tr(), null, null,
      null, null,
      true, sendFeedback),
    if(kDebugMode)
      DrawerEntry(
        Icons.visibility_sharp, LocaleKeys.ImmersionScreen_title.tr(),
        "/${Screens.immersion.name}", Screens.immersion,
        null, null,
        kDebugMode, null),
    if(kDebugMode)
      DrawerEntry(
        const IconData(0x5d29, fontFamily: "kouzan"), LocaleKeys.KuzushijiScreen_title.tr(),
        "/${Screens.kuzushiji.name}", Screens.kuzushiji,
        0.7, const Alignment(-1000, 0),
        kDebugMode, null),
  ];

  late List<int> drawerElementsIndexOrder;
  
  @override
  void initState() {
    // remove debug only items
    //drawerEntries.removeWhere((e) => !e.include);

    super.initState();
    _drawerController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _moveDrawer = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate( CurvedAnimation(
      parent: _drawerController,
      curve: const Interval(0.0, 1.0, curve: Curves.linear)
    ));

    if(!widget.drawerClosed) {
      _drawerController.value = 1.0;
    }

    // add a listener to animate the drawer when it should be opened/closed 
    _handleDrawer = ()  {
      setState(() {
        if(GetIt.I<DrawerListener>().playForward) {
          _drawerController.forward();
        } else {
          _drawerController.reverse();
        }
      });
    };
    GetIt.I<DrawerListener>().addListener(_handleDrawer);

    // order of drawer elements
    drawerElementsIndexOrder = GetIt.I<Settings>().misc.drawerItemOrder;
    // no order was ever defined
    if(drawerElementsIndexOrder.isEmpty) {
      drawerElementsIndexOrder = List.generate(drawerEntries.length, (index) => index);
    }
    // there are new elements in the drawer (migrate old safed values)
    if(drawerElementsIndexOrder.length < drawerEntries.length) {
      drawerElementsIndexOrder.addAll(
        List.generate(drawerEntries.length-drawerElementsIndexOrder.length, 
          (index) => index+drawerElementsIndexOrder.length)
      );
    }
    // elements have been removed from the drawer -> reset all values
    if(drawerElementsIndexOrder.length > drawerEntries.length) {
      drawerElementsIndexOrder = List.generate(drawerEntries.length, (i) => i);
    }

    GetIt.I<Settings>().misc.drawerItemOrder = drawerElementsIndexOrder;
    GetIt.I<Settings>().save();
  }

  @override
  void dispose() { 
    _drawerController.dispose();
    super.dispose();
    if(GetIt.I.isRegistered<DrawerListener>()) {
      GetIt.I<DrawerListener>().removeListener(_handleDrawer);
    }
  }

  @override
  Widget build(BuildContext context) {

    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    // drawer should not use 50% of screen if screen is very wide
    if(_screenWidth < 500) {
      _drawerWidth = _screenWidth * 0.5;
    } else {
      _drawerWidth = 500 * 0.5;
    }
    

    DragStartDetails? start;
    
    // add a listener to when the Navigator animation finished
    var route = ModalRoute.of(context);
    void handler(status) {
      if (status == AnimationStatus.completed) {
        route?.animation?.removeStatusListener(handler);
        
        if(!widget.drawerClosed){
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            _drawerController.reverse();
          });
        }
      }
    }
    route?.animation?.addStatusListener(handler);

    // create an drawer style application
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: AnimatedBuilder(
        animation: _drawerController,
        child: widget.child,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              // the screen (child) and the top app bar
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(_moveDrawer.value * _screenWidth/2)
                  ..rotateY(pi/4 * _moveDrawer.value),
                child: Scaffold(
                  // the top app bar
                  appBar: widget.useBackArrowAppBar
                    ? AppBar()
                    : AppBar(
                      automaticallyImplyLeading: false,
                      toolbarHeight: (MediaQuery.of(context).size.height*0.1).clamp(0, 60),
                      leadingWidth: 0,
                      titleSpacing: 0,
                      title: DrawerAppBar(
                        drawerController: _drawerController, 
                        currentScreen: widget.currentScreen,
                        height: (MediaQuery.of(context).size.height*0.1).clamp(0, 60),
                      ),
                    ),
                  //the screen (child)
                  body: SafeArea(child: child!)
                ),
              ),
              // overlay over the actual page content which should close the 
              //drawer when tapped
              if(_drawerController.status != AnimationStatus.dismissed)
                Positioned(
                  left: (_drawerWidth) * (_moveDrawer.value),
                  top: 0,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      _drawerController.reverse();
                    },
                    onHorizontalDragStart: (DragStartDetails details){
                      start ??= details;
                    },
                    onHorizontalDragUpdate: (DragUpdateDetails details){
                      var newState = start!.localPosition.dx - 
                        details.localPosition.dx;
                      _drawerController.value = 
                        1 - (newState / _drawerWidth).clamp(0.0, 1.0);
                    },
                    onHorizontalDragEnd: (DragEndDetails details){
                      start = null;
                      if(_moveDrawer.value < 0.5) {
                        _drawerController.reverse();
                      } else {
                        _drawerController.forward();
                      }
                    },
                    child: Opacity(
                      opacity: _moveDrawer.value,
                      child: Container(
                        color: Colors.grey[900]!.withAlpha(150),
                        width: _screenWidth,
                        height: _screenHeight,
                      ),
                    ),
                  ),
                ), 
              // the drawer 
              if(_drawerController.status != AnimationStatus.dismissed)
                Transform.translate(
                  offset: Offset(
                    (-_drawerWidth) * (1-_moveDrawer.value), 
                    0
                  ),
                  // enable closing the drawer when dragging on it
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onHorizontalDragStart: (DragStartDetails details){
                      start ??= details;
                    },
                    onHorizontalDragUpdate: (DragUpdateDetails details){
                      var newState = start!.localPosition.dx - 
                        details.localPosition.dx;
                      _drawerController.value = 
                        1 - (newState / _drawerWidth).clamp(0.0, 1.0);
                    },
                    onHorizontalDragEnd: (DragEndDetails details){
                      start = null;
                      if(_moveDrawer.value < 0.5) {
                        _drawerController.reverse();
                      } else {
                        _drawerController.forward();
                      }
                    },
                    // the actual drawer
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(10, 0),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      height: _screenHeight,
                      width: _drawerWidth,
                      child: ListTileTheme(
                        style: ListTileStyle.drawer,
                        selectedColor: Theme.of(context).colorScheme.secondary,
                        child: Column(
                          children: [
                            GestureDetector(
                              onLongPress: () {},
                              child: SafeArea(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(_drawerWidth*0.1, _drawerWidth*0.05, 0, _drawerWidth*0.1),
                                    child: Image(
                                      width: _drawerWidth * 0.6,
                                      //height: (MediaQuery.of(context).size.height * 0.15).clamp(0, 60),
                                      image: const AssetImage("assets/images/dakanji/banner.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ReorderableListView(
                                buildDefaultDragHandles: false,
                                padding: EdgeInsets.zero,
                                onReorder: (oldIndex, newIndex) async {
                                  if(newIndex > oldIndex) {
                                    newIndex -= 1;
                                  }
                                  int old = drawerElementsIndexOrder.removeAt(oldIndex);
                                  drawerElementsIndexOrder.insert(newIndex, old);
                                  GetIt.I<Settings>().misc.drawerItemOrder = drawerElementsIndexOrder;
                                  await GetIt.I<Settings>().save();
                                  setState(() {});
                                },
                                children: <Widget>[
                                  // DaKanji Logo at the top
                                  for (final (j, i) in drawerElementsIndexOrder.indexed)
                                    if(drawerEntries[i].include)
                                      DrawerElement(
                                        leading: drawerEntries[i].icon,
                                        title: drawerEntries[i].title,
                                        route: drawerEntries[i].route,
                                        selected: widget.currentScreen == drawerEntries[i].screen,
                                        leadingSize: drawerEntries[i].iconSize ?? 0.5,
                                        leadingAlignment: drawerEntries[i].iconAlignment ?? Alignment.center,
                                        drawerWidth: _drawerWidth,
                                        index: j,
                                        drawerController: _drawerController,
                                        onTap: drawerEntries[i].onTap,
                                      )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                ),
            ],
          );
        }
      ),
    );
  }
}


import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:get_it/get_it.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feedback/feedback.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer_element.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer_app_bar.dart';
import 'package:da_kanji_mobile/domain/drawer/drawer_listener.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/globals.dart';



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
  /// should the animation begin at the start or end
  final bool animationAtStart;


  const DaKanjiDrawer(
    {
      required this.child,
      this.useBackArrowAppBar = false,
      required this.currentScreen,
      this.animationAtStart = true,
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
  
  
  @override
  void initState() { 
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

    if(!widget.animationAtStart) {
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
  }

  @override
  void dispose() { 
    _drawerController.dispose();
    super.dispose();
    GetIt.I<DrawerListener>().removeListener(_handleDrawer);
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
    

    DragStartDetails? _start;
    
    // add a listener to when the Navigator animation finished
    var route = ModalRoute.of(context);
    void handler(status) {
      if (status == AnimationStatus.completed) {
        route?.animation?.removeStatusListener(handler);
        
        if(!widget.animationAtStart){
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
                      _start ??= details;
                    },
                    onHorizontalDragUpdate: (DragUpdateDetails details){
                      var newState = _start!.localPosition.dx - 
                        details.localPosition.dx;
                      _drawerController.value = 
                        1 - (newState / _drawerWidth).clamp(0.0, 1.0);
                    },
                    onHorizontalDragEnd: (DragEndDetails details){
                      _start = null;
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
                      _start ??= details;
                    },
                    onHorizontalDragUpdate: (DragUpdateDetails details){
                      var newState = _start!.localPosition.dx - 
                        details.localPosition.dx;
                      _drawerController.value = 
                        1 - (newState / _drawerWidth).clamp(0.0, 1.0);
                    },
                    onHorizontalDragEnd: (DragEndDetails details){
                      _start = null;
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
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          children: <Widget>[
                            // DaKanji Logo at the top
                            SafeArea(
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
                            // Drawer entry to go to the Kanji drawing screen
                            DrawerElement(
                              leading: Icons.brush,
                              title: LocaleKeys.DrawScreen_title.tr(),
                              route: "/drawing",
                              selected: widget.currentScreen == Screens.drawing,
                              drawerWidth: _drawerWidth,
                              drawerController: _drawerController,
                            ),
                            // Drawer entry to go to the text dictionary screen
                            DrawerElement(
                              leading: Icons.book,
                              title: LocaleKeys.DictionaryScreen_title.tr(),
                              route: "/dictionary",
                              selected: widget.currentScreen == Screens.dictionary,
                              drawerWidth: _drawerWidth,
                              drawerController: _drawerController,
                            ),
                            // Drawer entry to go to the text processing screen
                            DrawerElement(
                              leading: Icons.text_snippet,
                              title: LocaleKeys.TextScreen_title.tr(),
                              route: "/text",
                              selected: widget.currentScreen == Screens.text,
                              drawerWidth: _drawerWidth,
                              drawerController: _drawerController,
                            ),
                            // Drawer entry to go to the kanji screen
                            if(kDebugMode)
                              DrawerElement(
                                leading: IconData(
                                  0x6f22, fontFamily: "NotoSansJP"
                                ),
                                leadingAlignment: Alignment(-0.1, -0.65),
                                title: LocaleKeys.KanjiScreen_title.tr(),
                                route: "/kanji",
                                selected: widget.currentScreen == Screens.kanji,
                                drawerWidth: _drawerWidth,
                                drawerController: _drawerController,
                              ),
                            // Drawer entry to go to the kana screen
                            if(kDebugMode)
                              DrawerElement(
                                // TODO change to kana icon
                                leading: const IconData(
                                  0x304B,
                                  fontFamily: "kouzan"
                                ),
                                leadingSize: 0.7,
                                leadingAlignment: Alignment(-1000, 0),
                                title: LocaleKeys.KanaChartScreen_title.tr(),
                                route: "/kana_chart",
                                selected: widget.currentScreen == Screens.kana_chart,
                                drawerWidth: _drawerWidth,
                                drawerController: _drawerController,
                              ),
                            // Drawer entry to go to the kuzushiji screen
                            if(kDebugMode)
                              DrawerElement(
                                leading: IconData(
                                  0x5d29,
                                  fontFamily: "kouzan"
                                ),
                                leadingSize: 0.7,
                                leadingAlignment: Alignment(-1000, 0),
                                title: LocaleKeys.KuzushijiScreen_title.tr(),
                                route: "/kuzushiji",
                                selected: widget.currentScreen == Screens.kuzushiji,
                                drawerWidth: _drawerWidth,
                                drawerController: _drawerController,
                              ),
                            // Drawer entry to go to the word lists screen
                            if(kDebugMode)
                              DrawerElement(
                                leading: Icons.list_alt_rounded,
                                leadingAlignment: Alignment(0, -0.1),
                                title: LocaleKeys.WordListsScreen_title.tr(),
                                route: "/word_lists",
                                selected: widget.currentScreen == Screens.word_lists,
                                drawerWidth: _drawerWidth,
                                drawerController: _drawerController,
                              ),
                            // Drawer entry to go to the settings screen
                            DrawerElement(
                              leading: Icons.settings_applications,
                              title: LocaleKeys.SettingsScreen_title.tr(),
                              route: "/settings",
                              selected: widget.currentScreen == Screens.settings,
                              drawerWidth: _drawerWidth,
                              drawerController: _drawerController,
                            ),
                            // Drawer entry to go to the about screen
                            DrawerElement(
                              leading: Icons.info_outline,
                              title: LocaleKeys.AboutScreen_title.tr(),
                              route: "/about",
                              selected: widget.currentScreen == Screens.about,
                              drawerWidth: _drawerWidth,
                              drawerController: _drawerController,
                            ),
                            // Drawer entry to go to the manual screen
                            DrawerElement(
                              leading: Icons.help,
                              title: LocaleKeys.ManualScreen_title.tr(),
                              route: "/manual",
                              selected: widget.currentScreen == Screens.manual,
                              drawerWidth: _drawerWidth,
                              drawerController: _drawerController,
                            ),
                            // Drawer entry to send feedback
                            DrawerElement(
                              leading: Icons.feedback,
                              title: LocaleKeys.FeedbackScreen_title.tr(),
                              route: "",
                              selected: false,
                              drawerWidth: _drawerWidth,
                              drawerController: _drawerController,
                              onTap: () {
                                BetterFeedback.of(context).show((UserFeedback feedback) async {
                                  
                                  final screenshotFilePath = await writeImageToTmpStorage(feedback.screenshot);
                                  final textFilePath = await writeTextToTmpStorage(await getDeviceInfoText(context), "deviceInfo");
                                  final logsFilePath = await writeTextToTmpStorage(g_appLogs, "logs");

                                  String feedbackText = "Send to: daapplab\n" + feedback.text;
                                  String feedbackSubject = "DaKanji $g_Version - feedback";

                                  await Share.shareXFiles(
                                    [XFile(screenshotFilePath), XFile(textFilePath), XFile(logsFilePath)],
                                    text: Platform.isWindows ? feedbackSubject : feedbackText,
                                    subject: Platform.isWindows ? feedbackText : feedbackSubject,
                                    sharePositionOrigin: () {
                                      RenderBox? box = context.findRenderObject() as RenderBox?;
                                      return Rect.fromLTRB(0, 0, box!.size.height/2, box.size.width/2);
                                    } (),
                                  );
                                });
                              },
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

/// Saves the given Uint8List to the temporary directory of the device and 
/// returns the path to the file
Future<String> writeImageToTmpStorage(Uint8List image) async {
  final Directory output = await getTemporaryDirectory();
  final String screenshotFilePath = '${output.path}/feedback.png';
  final File screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(image);
  return screenshotFilePath;
}

/// Saves the given String to the temporary directory of the device and 
/// returns the path to the file
Future<String> writeTextToTmpStorage(String text, String fileName) async {
  final Directory output = await getTemporaryDirectory();
  final String textFilePath = '${output.path}/${fileName}.txt';
  final File screenshotFile = File(textFilePath);
  await screenshotFile.writeAsString(text);
  return textFilePath;
}

/// Returns a String containing details about the system the app is running on
Future<String> getDeviceInfoText(BuildContext context) async {
  Map<String, dynamic> t = (await DeviceInfoPlugin().deviceInfo).toMap();

  String deviceInfo = """System / App info:
    I am using DaKanji v.$g_Version on ${Theme.of(context).platform.name}.

    ${t.toString().replaceAll(",", "\n").replaceAll("}", "").replaceAll("{", "")}
    """;

  return deviceInfo;
}
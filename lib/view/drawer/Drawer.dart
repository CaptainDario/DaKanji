import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:get_it/get_it.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/model/Screens.dart';
import 'package:da_kanji_mobile/view/drawer/DrawerElement.dart';
import 'package:da_kanji_mobile/view/drawer/DrawerAppBar.dart';
import 'package:da_kanji_mobile/provider/DrawerListener.dart';
import 'package:da_kanji_mobile/locales_keys.dart';


/// Da Kanji's drawer.
/// 
/// It connects the main screens of the app with each other.
/// Currently: *Drawing*, *Settings*, *About*
class DaKanjiDrawer extends StatefulWidget{

  /// The actual page to show when the drawer is not visible.
  final Widget child;
  /// The currently selected 
  final Screens currentScreen;
  /// should the animation begin at the start or end
  final bool animationAtStart;


  DaKanjiDrawer(
    {
      required this.child,
      required this.currentScreen,
      this.animationAtStart = true 
    }
  );

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
      curve: Interval(0.0, 1.0, curve: Curves.linear)
    ));

    if(!widget.animationAtStart)
      _drawerController.value = 1.0;

    // add a listener to animate the drawer when it should be opened/closed 
    _handleDrawer = ()  {
      setState(() {
        if(GetIt.I<DrawerListener>().playForward)
          _drawerController.forward();
        else
          _drawerController.reverse();
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
    if(_screenWidth < 500)
      _drawerWidth = _screenWidth * 0.5;
    else
      _drawerWidth = 500 * 0.5;
    

    DragStartDetails? _start;
    
    // add a listener to when the Navigator animation finished
    var route = ModalRoute.of(context);
    void handler(status) {
      if (status == AnimationStatus.completed) {
        route?.animation?.removeStatusListener(handler);
        
        if(!widget.animationAtStart){
          SchedulerBinding.instance?.addPostFrameCallback((_) async {
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
                  appBar: AppBar(
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
                      if(_start == null)
                        _start = details;
                    },
                    onHorizontalDragUpdate: (DragUpdateDetails details){
                      var newState = _start!.localPosition.dx - 
                        details.localPosition.dx;
                      _drawerController.value = 
                        1 - (newState / _drawerWidth).clamp(0.0, 1.0);
                    },
                    onHorizontalDragEnd: (DragEndDetails details){
                      _start = null;
                      if(_moveDrawer.value < 0.5)
                        _drawerController.reverse();
                      else
                        _drawerController.forward();
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
                      if(_start == null)
                        _start = details;
                    },
                    onHorizontalDragUpdate: (DragUpdateDetails details){
                      var newState = _start!.localPosition.dx - 
                        details.localPosition.dx;
                      _drawerController.value = 
                        1 - (newState / _drawerWidth).clamp(0.0, 1.0);
                    },
                    onHorizontalDragEnd: (DragEndDetails details){
                      _start = null;
                      if(_moveDrawer.value < 0.5)
                        _drawerController.reverse();
                      else
                        _drawerController.forward();
                    },
                    // the actual drawer
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        boxShadow: [
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
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          children: <Widget>[
                            // DaKanji Logo at the top
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(_drawerWidth*0.1, _drawerWidth*0.05, 0, _drawerWidth*0.1),
                                child: Image(
                                  width: _drawerWidth * 0.6,
                                  //height: (MediaQuery.of(context).size.height * 0.15).clamp(0, 60),
                                  image: AssetImage("assets/images/icons/banner.png"),
                                ),
                              ),
                            ),
                            // Drawer entry to go to the Kanji drawing screen
                            DrawerElement(
                              leading: Icons.brush,
                              title: LocaleKeys.DrawScreen_title.tr(),
                              route: "/drawing",
                              selected: widget.currentScreen == Screens.drawing,
                              drawerWidth: this._drawerWidth,
                              drawerController: _drawerController,
                            ),
                            // Drawer entry to go to the settings screen
                            DrawerElement(
                              leading: Icons.settings_applications,
                              title: LocaleKeys.SettingsScreen_title.tr(),
                              route: "/settings",
                              selected: widget.currentScreen == Screens.settings,
                              drawerWidth: this._drawerWidth,
                              drawerController: _drawerController,
                            ),
                            // Drawer entry to go to the about screen
                            DrawerElement(
                              leading: Icons.info_outline,
                              title: LocaleKeys.AboutScreen_title.tr(),
                              route: "/about",
                              selected: widget.currentScreen == Screens.about,
                              drawerWidth: this._drawerWidth,
                              drawerController: _drawerController,
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


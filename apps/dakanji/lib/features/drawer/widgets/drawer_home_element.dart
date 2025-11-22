import 'package:da_kanji_mobile/core/routing/navigation_arguments.dart';
import 'package:da_kanji_mobile/core/routing/screens.dart';
import 'package:da_kanji_mobile/features/drawer/widgets/drawer.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';



class DrawerHomeElement extends StatelessWidget {
  const DrawerHomeElement({
    super.key,
    required AnimationController drawerController,
    required double drawerWidth,
    required this.widget,
  }) : _drawerController = drawerController, _drawerWidth = drawerWidth;

  final AnimationController _drawerController;
  final double _drawerWidth;
  final DaKanjiDrawer widget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: InkWell(
          onTap: () {
    
            String route = "/${Screens.home.name}";
    
            if(ModalRoute.of(context)!.settings.name != route){
              Navigator.pushNamedAndRemoveUntil(
                context, route,
                (Route<dynamic> route) => false,
                arguments: NavigationArguments(true)
              );
            }
            else{
              _drawerController.reverse();
            }
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                _drawerWidth*0.05, _drawerWidth*0.05,
                0, _drawerWidth*0.05),
              child: Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10000),
                      border: Border.all(
                        color: Colors.white, // Outline color
                        width: 2.0, // Outline width
                      ),
                    ),
                    // TODO Use user favorite kanji as profile picture
                    child: Center(
                      child: Text(
                        "字",
                        style: TextStyle(
                          fontFamily: "kouzan",
                          fontSize: 30
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  // TODO user name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        style: TextStyle(
                          fontSize: 20,
                          color: widget.currentScreen == Screens.home
                            ? g_Dakanji_red
                            : null
                        ),
                        "User.name"
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            size: 16,
                            color: g_Dakanji_red,
                          ),
                          const SizedBox(width: 4,),
                          // TODO actual user streak
                          Text(
                            "1200",
                            style: TextStyle(
                              fontSize: 14,
                              color: widget.currentScreen == Screens.home
                                ? g_Dakanji_red
                                : null
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:da_kanji_mobile/core/routing/navigation_arguments.dart';
import 'package:da_kanji_mobile/core/routing/screens.dart';
import 'package:da_kanji_mobile/core/supabase/model/supabase_cache_manager.dart';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:da_kanji_mobile/features/drawer/widgets/drawer.dart';
import 'package:da_kanji_mobile/features/home/widgets/account/user_icon.dart';
import 'package:da_kanji_mobile/features/home/widgets/study_calendar/streak_reward_badge.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';



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
                  UserIcon(
                    width: 48,
                    height: 48,
                    avatarColor: context.read<SupabaseCacheManager>().userProfile.avatarColor,
                    avatarCharacter: context.read<SupabaseCacheManager>().userProfile.avatarCharacter,
                    avatarCharacterColor: context.read<SupabaseCacheManager>().userProfile.avatarCharacterColor,
                  ),
                  const SizedBox(width: 12,),
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
                        GetIt.I<SupabaseCacheManager>().userProfile.username,
                      ),
                      FutureBuilder(
                        future: GetIt.I<UserDataDB>().timeTrackingDao.calculateTimeStreak(),
                        builder: (context, asyncSnapshot) {
                          return StreakRewardBadge(
                            streak: asyncSnapshot.data ?? 0,
                            scale: 0.8,
                          );
                        }
                      ),
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





// Dart imports:
import 'dart:async';

// Package imports:

// Project imports:
import 'package:da_kanji_mobile/entities/user_data/user_data.dart'; 
import 'package:da_kanji_mobile/repositories/analytics/post.dart';

/// Tracking of statistics and communication with the local SQL Stas DB
/// Also tracks daily and monthly usage
class Stats{

  /// [UserData] instance where the daily and monthly usage is tracked
  UserData userData;
  /// has this instance been initialized
  bool initialized = false;
  /// The seconds a user needs to use the app a day to count as daily active
  int dailyActiveSecondsThreshold = 10;
  /// The days a user needs to be a daily active user to count as monthly active
  int monthlyActiveDaysThreshold = 7;
  /// Is the app currently active?
  bool appActive = true;
  /// Periodic timer that save the current usage stats to disk
  late Timer updateStatsTimer;
  /// After how many seconds should the stats be updated (does NOT save)
  final int updateStatsTimerInterval = 1;
  /// Timer that periodially saves the stats to disk
  late Timer saveStatsTimer;
  /// After how many seconds should the stats be updated (does NOT save)
  final int saveStatsTimerInterval = 60;

  /// Before using this `init()` needs to be called
  Stats(
    this.userData
  );

  /// Initializes an instance
  void init(){
    // update the stats every second
    updateStatsTimer = Timer.periodic(
      Duration(seconds: updateStatsTimerInterval), (timer) async {
        if(appActive){
          await updateStats();
        }
      }
    );
    // save the stats peridocially
    saveStatsTimer = Timer.periodic(
      Duration(seconds: saveStatsTimerInterval), (timer) async {
        await saveStats();
      }
    );
  }

  /// Saves the current stats and checks if a new day started and some stats 
  /// need to be reset
  Future saveStats() async {

    await userData.save();

  }

  /// Updates all usage statistics in the `this.UserData`
  Future updateStats() async {

    userData.resetUsageIfNewDay();
    
    if(!userData.dailyActiveUserTracked) await updateDailyUsage();
    if(!userData.monthlyActiveUserTracked) await updateMonthlyUsage();

    print("${userData.dailyActiveUserTracked} ${userData.todayUsageSeconds}");
    
  }

  /// Updates the monhtly usage
  /// Saves to disk and sends an event if user is now a monthly active one
  Future updateMonthlyUsage() async {
    
    // user was active today -> count one day to monthly active
    if(userData.todayUsageSeconds >= dailyActiveSecondsThreshold &&
      !userData.dailyForMonthlyTracked){
      userData.monthsUsageDays += 1;
      userData.dailyForMonthlyTracked = true;
      await userData.save();
    }
    // user has been active this month
    if(userData.monthsUsageDays >= monthlyActiveDaysThreshold &&
      !userData.monthlyActiveUserTracked){

      await logDefaultEvent("Monthly active user");
      userData.monthlyActiveUserTracked = true;
      userData.save();
    }
  }

  /// Updates the daily usage
  /// Saves to disk and sends an event if user is now a daily active one
  Future updateDailyUsage() async {
    userData.todayUsageSeconds += updateStatsTimerInterval;

    // user has been active today
    if(userData.todayUsageSeconds >= dailyActiveSecondsThreshold &&
      !userData.dailyActiveUserTracked){

      await logDefaultEvent("Daily active user");
      userData.dailyActiveUserTracked = true;
      userData.save();
    }
  }

}

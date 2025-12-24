import 'package:da_kanji_mobile/core/icons/da_kanji_icons.dart';
import 'package:da_kanji_mobile/core/supabase/model/supabase_cache_manager.dart';
import 'package:da_kanji_mobile/core/user/activity_chart_mock_data.dart';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:da_kanji_mobile/features/home/widgets/greeting_widget.dart';
import 'package:da_kanji_mobile/features/home/widgets/study_calendar/study_calendar.dart';
import 'package:da_kanji_mobile/features/home/widgets/study_card.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';



class HomeOverviewPage extends StatefulWidget {
  const HomeOverviewPage({super.key});

  @override
  State<HomeOverviewPage> createState() => _HomeOverviewPageState();
}

class _HomeOverviewPageState extends State<HomeOverviewPage> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const SizedBox(height: 8,),
          GreetingWidget(context.read<SupabaseCacheManager>().userProfile.username),
          SizedBox(height: 8,),
          StudyCalendar(
            onFetchTime: (start, end) => 
              GetIt.I<UserDataDB>().timeTrackingDao.getStudyHistoryRange(
                start: start,
                end: end
              ),
            // TODO vocab data fetching
            /*onFetchVocab: (start, end) => 
              GetIt.I<UserDataDB>().vocabStudyDao.getVocabStudyHistoryRange(
                start: start,
                end: end
              ),*/
            vocabColor: g_Dakanji_green,
            charactersColor: g_Dakanji_red,
            timeColor: g_Dakanji_blue,
            streakColor: g_Dakanji_green.withAlpha(50),
            streakGlowColor: g_Dakanji_green,
          ),
          FutureBuilder<({int currentProgress, int todaysGoal})>(
            future: () async {
              return (
                currentProgress: await GetIt.I<UserDataDB>().timeTrackingDao.getTodayStudyMinutes(),
                todaysGoal: await GetIt.I<UserDataDB>().timeTrackingDao.getTodayGoal()
              );
            } (),
            builder: (context, asyncSnapshot) {
              return StudyCard(
                title: '勉強',
                subtitle: LocaleKeys.HomeScreen_study_card_subtitle_time.tr(),
                currentProgress: asyncSnapshot.hasData
                  ? asyncSnapshot.data!.currentProgress
                  : 0,
                dailyGoal: asyncSnapshot.hasData
                  ? asyncSnapshot.data!.todaysGoal
                  : 0,
                color: g_Dakanji_blue,
                action: LocaleKeys.HomeScreen_study_card_action_time.tr(),
                icon: DaKanjiIcons.timeTracking,
              );
            }
          ),
          StudyCard(
            title: '単語',
            subtitle: LocaleKeys.HomeScreen_study_card_subtitle_vocab.tr(),
            currentProgress: 20,
            dailyGoal: 20,
            color: g_Dakanji_green,
            action: LocaleKeys.HomeScreen_study_card_action_vocab.tr(),
            icon: DaKanjiIcons.wordLists,
          ),
          /* TODO KANJI TRAINER
          StudyCard(
            title: '文字',
            subtitle: LocaleKeys.HomeScreen_study_card_subtitle_chars.tr(),
            currentProgress: 21,
            dailyGoal: 40,
            color: g_Dakanji_red,
            action: LocaleKeys.HomeScreen_study_card_action_chars.tr(),
            icon: DaKanjiIcons.kanjiTrainer,
          ),*/
        ]),
    );
  
  }
}
import 'package:da_kanji_mobile/core/icons/da_kanji_icons.dart';
import 'package:da_kanji_mobile/features/home/model/activity_chart_mock_data.dart';
import 'package:da_kanji_mobile/features/home/widgets/activity_chart.dart';
import 'package:da_kanji_mobile/features/home/widgets/study_card.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';



class HomeOverviewPage extends StatefulWidget {
  const HomeOverviewPage({super.key});

  @override
  State<HomeOverviewPage> createState() => _HomeOverviewPageState();
}

class _HomeOverviewPageState extends State<HomeOverviewPage> {
  @override
  Widget build(BuildContext context) {

    final mockData = generateMockStudyData(streakLength: 360, length: 900);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          SizedBox(height: 9,),
          StudyCalendar(
            vocabStudied: mockData.vocab,
            charactersStudied: mockData.characters,
            timeStudied: mockData.time,
            vocabColor: g_Dakanji_green,
            charactersColor: g_Dakanji_red,
            timeColor: g_Dakanji_blue,
            streakColor: g_Dakanji_green.withAlpha(50),
            streakGlowColor: g_Dakanji_green,
          ),
          StudyCard(
            title: '単語',
            subtitle: 'Expand your vocabulary',
            currentProgress: 20,
            dailyGoal: 20,
            color: g_Dakanji_green,
            action: 'Study',
            icon: DaKanjiIcons.wordLists,
          ),
          StudyCard(
            title: '文字',
            subtitle: 'Master the writing system',
            currentProgress: 21,
            dailyGoal: 40,
            color: g_Dakanji_red,
            action: 'Study',
            icon: DaKanjiIcons.kanjiTrainer,
          ),
          StudyCard(
            title: '勉強',
            subtitle: 'Put in the time to succeed',
            currentProgress: 5,
            dailyGoal: 67,
            color: g_Dakanji_blue,
            action: 'Track',
            icon: DaKanjiIcons.timer,
          ),
        ]),
    );
  
  }
}
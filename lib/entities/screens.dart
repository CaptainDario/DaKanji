// HOW TO ADD A NEW SCREEN
// 
// 1. Create new screen in
//     lib/screens/<<SCREEN_NAME>>/<<SCREEN_NAME>>.dart
//   1.1 add a screen following lib/screens/dojg/dojg_screen.dart
// 2. Create screen's implementation in
//     lib/widgets/<<SCREEN_NAME>>/
//   2.1 add a tutorial (look at lib/widgets/dojg/dojg.dart)
//   2.2 add the if the tutorial should be shown to 
//       lib/entities/user_data/user_data.dart
//   2.3 add tutorial implementation in
//       lib/entities/show_cases/<<SCREEN_NAME>>_screen_tutorial.dart
//   2.4 add tutorial to
//       lib/entities/show_cases/tutorials.dart
//   2.5 save tutorial finished in
//       lib/application/tutorial/tutorial_on_step.dart
//   2.6 regenerate serialization code
//       `flutter pub run build_runner build --delete-conflicting-outputs`
// 3. Add the new name screen to the `Screens` enum below
// 4. Add the new screen as a navigation in the drawer
//     lib/widgets/drawer/drawer.dart
// 5. Add new navigation target in 
//     lib/widgets/drawer/drawer_app_bar.dart
// 6. Add the new screen to the routing in
//     lib/application/routing/routing.dart
// 7. Add the new screen in with the option to reset the tutorial
//     lib/screens/settings/settings_screen.dart
// 7. Add deep links in 
//     lib/application/manual/routing/deep_links.dart
// 8. Add deep links to https://dakanji.app/deep-links/


enum Screens{
  about,
  changelog,
  drawing,
  dictionary,
  webbrowser,
  youtube,
  immersion,
  ocr,
  dojg,
  text,
  clipboard,
  kanjiTrainer,
  kanjiTable,
  kanaTable,
  kanaTrainer,
  kuzushiji,
  wordLists,
  home,
  settings,
  onboarding,
  webviewDict,
  manual,
  test
}


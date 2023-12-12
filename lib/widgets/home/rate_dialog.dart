// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/application/helper/reviews.dart';
import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

/// Shows a rate popup which lets the user rate the app on the platform specific
/// app store.
/// 
/// The `context` should be the apps current context and `hasDoNotShowOption`
/// enables the option for the user to not show the rate popup again.
Future<void> showRateDialog(BuildContext context, bool hasDoNotShowOption) async {

  return AwesomeDialog(
    context: context,
    headerAnimationLoop: false,
    customHeader: Image.asset(
      "assets/images/dakanji/icon.png"
    ),
    onDismissCallback: (type) async {
      Navigator.pop(context);
    },
    body: Center(
      child: Column(
        children: [
          // ask for a rating text
          Text(
            LocaleKeys.HomeScreen_RatePopup_text.tr(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row( 
              children: [
                // close button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamedAndRemoveUntil(
                      context, "/${Screens.home.name}", (Route<dynamic> route) => false
                    );
                  },
                  child: Text(LocaleKeys.General_close.tr())
                ),
                const SizedBox(width: 5,),
                // rate button
                ElevatedButton(
                  onPressed: () async {
                    openReview(); 
                  },
                  child: Text(LocaleKeys.HomeScreen_rate_this_app.tr())
                ),
                const SizedBox(width: 5,),
                // do not ask again button
                if(hasDoNotShowOption)
                  ElevatedButton(
                    style: const ButtonStyle(
                    ),
                    onPressed: () {
                      GetIt.I<UserData>().doNotShowRateAgain = true;
                      GetIt.I<UserData>().save();
                      Navigator.pushNamedAndRemoveUntil(
                        context, "/${Screens.home.name}", (Route<dynamic> route) => false
                      );
                    },
                    child: Text(LocaleKeys.HomeScreen_RatePopup_dont_ask_again.tr())
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10,)
        ],
      )
    )
  ).show();

}

import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/model/UserData.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/helper/reviews.dart';


/// Shows a rate popup which lets the user rate the app on the platform specific
/// app store.
/// 
/// The `context` should be the apps current context and `hasDoNotShowOption`
/// enables the option for the user to not show the rate popup again.
void showRatePopup(BuildContext context, bool hasDoNotShowOption){



  AwesomeDialog(
    context: context,
    headerAnimationLoop: false,
    customHeader: Image.asset(
      "assets/images/icons/icon.png"
    ),
    body: Center(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ask for a rating text
          Text(
            LocaleKeys.HomeScreen_RatePopup_text.tr(),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50,),
          Wrap(
            alignment: WrapAlignment.spaceAround,    
            children: [
              // close button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context, "/home", (Route<dynamic> route) => false);
                },
                child: Text(LocaleKeys.General_close.tr())
              ),
              SizedBox(width: 5,),
              // rate button
              ElevatedButton(
                onPressed: () async {
                  openReview(); 
                },
                child: Text(LocaleKeys.General_rate_this_app.tr())
              ),
              SizedBox(width: 5,),
              // do not ask again button
              if(hasDoNotShowOption)
                ElevatedButton(
                  style: ButtonStyle(
                  ),
                  onPressed: () {
                    GetIt.I<UserData>().doNotShowRateAgain = true;
                    GetIt.I<UserData>().save();
                    Navigator.pushNamedAndRemoveUntil(
                      context, "/home", (Route<dynamic> route) => false);
                  },
                  child: Text(LocaleKeys.HomeScreen_RatePopup_dont_ask_again.tr())
                ),
            ],
          ),
          SizedBox(height: 10,)
        ],
      )
    )
  )..show();

}
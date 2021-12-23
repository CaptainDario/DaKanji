import 'package:in_app_review/in_app_review.dart';

import 'package:da_kanji_mobile/globals.dart';



/// Opens a in app review dialogue if available or otherwise
/// opens the app in the platforms app store
void openReview() async {
  final InAppReview inAppReview = InAppReview.instance;
  if(await inAppReview.isAvailable())
    inAppReview.requestReview();
  else
    inAppReview.openStoreListing(
      appStoreId: APPSTORE_ID, 
      //microsoftStoreId: '...'
    );
}
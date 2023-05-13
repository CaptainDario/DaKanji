import 'package:universal_io/io.dart';
import 'package:in_app_review/in_app_review.dart';

import 'package:da_kanji_mobile/globals.dart';



/// Opens a in app review dialogue if available or otherwise
/// opens the app in the platforms app store
void openReview() async {
  final InAppReview inAppReview = InAppReview.instance;

  if((Platform.isAndroid || Platform.isIOS || Platform.isMacOS) &&
    await inAppReview.isAvailable()) {
    inAppReview.requestReview();
  } else {
    inAppReview.openStoreListing(
      appStoreId: g_AppStoreId, 
      microsoftStoreId: g_MicrosoftStoreId
    );
  }

}
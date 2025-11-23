// Package imports:
import 'package:in_app_review/in_app_review.dart';
import 'package:universal_io/io.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';

/// Opens a in app review dialogue if available or otherwise
/// opens the app in the platforms app store
void openReview() async {
  final InAppReview inAppReview = InAppReview.instance;

  if((Platform.isAndroid || Platform.isIOS || Platform.isMacOS) &&
    await inAppReview.isAvailable()) {
    inAppReview.requestReview();
  } else if(Platform.isWindows) {
    inAppReview.openStoreListing(
      appStoreId: g_AppStoreId, 
      microsoftStoreId: g_MicrosoftStoreId
    );
  } else if(Platform.isLinux) {
    launchUrlString(g_SnapStorePage);
  }

}

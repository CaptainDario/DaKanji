import 'package:da_db/database/search_profiles/search_profiles_entry.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';



class InfoPopupButton extends StatelessWidget {
  
  /// The title next to the info button.
  final String title;
  /// The info text to show in the info dialog (shown when pressing the i-btn).
  final String infoText;

  const InfoPopupButton(
    {
      required this.title,
      required this.infoText,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () async {
          await showSettingsInfoPopup(infoText, context);
        },
        icon: Icon(Icons.info_outline)
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

/// Shows an info snackbar
void showInfoSnackbar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ),
  );
}

Future<void> showSettingsInfoPopup(String infoText, BuildContext context) async {
  await showGeneralDialog<SearchProfilesEntry>(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Close",
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) {
      return ScaleTransition(
        scale: animation,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    Flexible(
                      child: Markdown(
                        data: infoText,
                        shrinkWrap: true, 
                        padding: const EdgeInsets.all(8.0), 
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(LocaleKeys.SettingsScreenSearchProfiles_info_popup_ok.tr())
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
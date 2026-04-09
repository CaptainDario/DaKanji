import 'package:da_db/database/search_profiles/search_profiles_entry.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings/search_profile_settings_dialog.dart';
import 'package:flutter/material.dart';


class SearchProfilesButton extends StatelessWidget {
  const SearchProfilesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () async {
        // This works now because Provider is above MaterialApp
        await showGeneralDialog<SearchProfilesEntry>(
          context: context,
          barrierDismissible: true,
          barrierLabel: "Settings",
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (context, animation, secondaryAnimation) {
            return ScaleTransition(
              scale: animation,
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: SearchProfileSettingsDialog(),
                ),
              ),
            );
          },
        );
      }
    );
  }
}
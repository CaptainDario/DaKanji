import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/search_profiles/search_profiles_entry.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SearchProfileSelector extends StatelessWidget {
  const SearchProfileSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final dao = GetIt.I<DaDb>().searchProfilesDao;

    return StreamBuilder<List<SearchProfilesEntry>>(
      stream: dao.watchAllProfiles(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        final profiles = snapshot.data!;

        return FutureBuilder<SearchProfilesEntry?>(
          future: dao.getActiveProfile(),
          builder: (context, activeSnapshot) {
            final activeId = activeSnapshot.data?.id;

            return PopupMenuButton<int>(
              icon: const Icon(Icons.person_search_outlined),
              tooltip: LocaleKeys.SettingsScreenSearchProfiles_search_profiles_switch.tr(),
              onSelected: (int newProfileId) {
                if (newProfileId != activeId) {
                  dao.switchActiveProfile(newProfileId);
                }
              },
              itemBuilder: (BuildContext context) {
                return profiles.map((profile) {
                  final isSelected = profile.id == activeId;
                  
                  return PopupMenuItem<int>(
                    value: profile.id,
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: isSelected ? Colors.blue : Colors.transparent,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          profile.name,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
            );
          },
        );
      },
    );
  }
}
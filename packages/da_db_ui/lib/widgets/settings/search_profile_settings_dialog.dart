import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/search_profiles/search_profiles_entry.dart';
import 'package:da_db_ui/widgets/settings/search_profile_settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


class SearchProfileSettingsDialog extends StatefulWidget {


  const SearchProfileSettingsDialog({super.key,});

  @override
  State<SearchProfileSettingsDialog> createState() => _SearchProfileSettingsDialogState();
}

class _SearchProfileSettingsDialogState extends State<SearchProfileSettingsDialog> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black26)],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        child: StreamBuilder<SearchProfilesEntry>(
          stream: GetIt.I<DaDb>().searchProfilesDao.watchActiveProfile(),
          builder: (context, builder) {
            return SearchProfileSettingsWidget();
          }
        ),
      )
    );
  }
}
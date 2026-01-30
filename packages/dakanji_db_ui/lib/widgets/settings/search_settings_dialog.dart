import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/search_profiles/search_profiles_entry.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


class DaKanjiDbSettingsDialog extends StatefulWidget {


  const DaKanjiDbSettingsDialog({super.key,});

  @override
  State<DaKanjiDbSettingsDialog> createState() => _DaKanjiDbSettingsDialogState();
}

class _DaKanjiDbSettingsDialogState extends State<DaKanjiDbSettingsDialog> {

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
          stream: GetIt.I<DaKanjiDB>().searchProfilesDao.watchActiveProfile(),
          builder: (context, builder) {
            return DakanjiDbSettingsWidget();
          }
        ),
      )
    );
  }
}
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_ui/model/dakanji_db_settings.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_widget.dart';
import 'package:dakanji_db_ui_search_example/locales.dart';
import 'package:flutter/material.dart';


class SearchSettingsDialog extends StatefulWidget {

  final DaKanjiDB db;

  final DaKanjiDbSettings settings;

  const SearchSettingsDialog(
    {
      super.key,
      required this.settings,
      required this.db
    }
  );

  @override
  State<SearchSettingsDialog> createState() => _SearchSettingsDialogState();
}

class _SearchSettingsDialogState extends State<SearchSettingsDialog> {

  late DaKanjiDbSettings settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 900),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black26)],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        child: DakanjiDbSettingsWidget(
          widget.db,
          settings,
          dakanjiDbSettingsLocalization,
        ),
      )
    );
  }
}
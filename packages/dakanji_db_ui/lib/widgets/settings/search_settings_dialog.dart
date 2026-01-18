import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_ui/model/dakanji_db_settings.dart';
import 'package:dakanji_db_ui/widgets/model/dakanji_db_localization.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_widget.dart';
import 'package:flutter/material.dart';


class DaKanjiDbSettingsDialog extends StatefulWidget {

  final DaKanjiDB db;

  final DaKanjiDbSettings settings;

  final DakanjiDbLocalization localization;

  const DaKanjiDbSettingsDialog(
    {
      super.key,
      required this.settings,
      required this.db,
      required this.localization
    }
  );

  @override
  State<DaKanjiDbSettingsDialog> createState() => _DaKanjiDbSettingsDialogState();
}

class _DaKanjiDbSettingsDialogState extends State<DaKanjiDbSettingsDialog> {

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
        child: DakanjiDbSettingsWidget(
          widget.db,
          settings,
          widget.localization,
        ),
      )
    );
  }
}
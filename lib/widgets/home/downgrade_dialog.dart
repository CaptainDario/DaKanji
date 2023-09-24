// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/locales_keys.dart';

class DowngradeDialog extends StatefulWidget {
  const DowngradeDialog(
    {Key? key}
  ) : super(key: key);

  @override
  State<DowngradeDialog> createState() => _DowngradeDialogState();
}

class _DowngradeDialogState extends State<DowngradeDialog>{

  @override
  Widget build(BuildContext context) {

    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 4/5,
        width:  MediaQuery.of(context).size.width * 4/5,
        
        child: Text(
          LocaleKeys.HomeScreen_downgrade_warning.tr()
        )
      ),
    );
  }
}

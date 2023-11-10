// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/data/manual/manual_data.dart';
import 'package:da_kanji_mobile/domain/manual/manual_types.dart';

void pushManual(BuildContext context, ManualTypes manualType){
  
  /// Data of all manual pages
  ManualData manualData = ManualData();
  /// The index of the given manual page in the manual types array
  int index = manualData.manualTypes.indexOf(manualType);
  /// The text that should be shown in the appbar
  String appBarText = manualData.manualTitles[index];
  /// The manual page
  Widget manualPage = manualData.manualPages[index];

  Navigator.of(context).push(MaterialPageRoute<void>(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(appBarText)
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              manualPage
            ],
          ),
        ),
      );
    }
  ));
}

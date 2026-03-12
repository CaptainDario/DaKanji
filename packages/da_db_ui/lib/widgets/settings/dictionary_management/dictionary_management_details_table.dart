import 'package:da_db/database/index/index_table_entry.dart';
import 'package:flutter/material.dart';


class DictionaryManagementDetailsTable extends StatelessWidget {

  final IndexEntry dict;

  const DictionaryManagementDetailsTable(
    this.dict,
    {
      super.key,
    }
  );

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Table(
        children: [
          for (var (String name, String value) in dictionaryInfo(dict))
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(name),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(value),
                ),
              ]
            )
        ],
      ),
    );
  }

  Iterable<(String name, String value)> dictionaryInfo(IndexEntry dict) {
    // TODO add localization
    return [
      ("Id", dict.id.toString()),
      ("User dictionary", dict.isDefaultDictionary ? "Yes" : "No"),
      ("Enabled", dict.enabled ? "Yes" : "No"),
      ("Dictionary Type", dict.dictionaryType.name.toString()),
      ("Current Sort Order", "${dict.currentSortingOrder}"),
      ("Is global frequency dictionary", dict.currentFrequencyDictionary ? "Yes" : "No"),
      ("Title", dict.title),
      ("Revision", dict.revision.toString()),
      if (dict.sequenced != null) ("Sequenced", dict.sequenced! ? "Yes" : "No"),
      if (dict.format != null) ("Format", dict.format!.toString()),
      ("Version", dict.version.toString()),
      if (dict.author != null) ("Author", dict.author!),
      if (dict.isUpdatable != null) ("Updatable", dict.isUpdatable! ? "Yes" : "No"),
      if(dict.indexUrl != null) ("Index URL", dict.indexUrl!),
      if(dict.downloadUrl != null) ("Download URL", dict.downloadUrl!),
      if(dict.url != null) ("URL", dict.url!),
      if(dict.description != null) ("Description", dict.description!),
      if(dict.attribution != null) ("Attribution", dict.attribution!),
      if(dict.sourceLanguage != null) ("Source Language", dict.sourceLanguage!.name),
      if(dict.targetLanguage != null) ("Target Language", dict.targetLanguage!.name),
    ];
  }
}
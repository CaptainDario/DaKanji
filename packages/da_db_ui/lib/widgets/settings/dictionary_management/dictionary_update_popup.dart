import 'package:da_db/database/index/index_table_entry.dart';
import 'package:da_db/util/check_dict_updates.dart';
import 'package:flutter/material.dart';


class DictionaryUpdatePopup extends StatefulWidget {

  /// The dictionary to check for updates
  final IndexEntry entry;

  const DictionaryUpdatePopup(
    this.entry,
    {
      super.key,
    }
  );

  @override
  State<DictionaryUpdatePopup> createState() => _DictionaryUpdatePopupState();
}

class _DictionaryUpdatePopupState extends State<DictionaryUpdatePopup> {

  late final Future<bool> checkForUpdatesFuture;

  @override
  void initState() {
    checkForUpdatesFuture = checkIfDictionaryHasUpdates(widget.entry);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black26)],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: FutureBuilder(
        future: checkForUpdatesFuture,
        builder: (context, snapshot) {
          print(snapshot.data);
          // TODO localization
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Error checking for updates: ${snapshot.error}"),
            );
          }
          if (!snapshot.hasData) return SizedBox();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: snapshot.data == true
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "An update is available for this dictionary.",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: .end,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel"),
                        ),
                        SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () {
                            // TODO implement update logic
                            Navigator.of(context).pop();
                          },
                          child: const Text("Update Now"),
                        ),
                      ],
                    ),
                  ],
                )
              : const Text(
                  "This dictionary is up to date.",
                  style: TextStyle(fontSize: 18),
                ),
          );
        },
      )
    );
  }
}
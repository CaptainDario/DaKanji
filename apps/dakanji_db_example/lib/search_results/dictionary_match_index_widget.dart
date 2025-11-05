import 'package:dakanji_db_core/database/index/index_table_entry.dart';
import 'package:flutter/material.dart';


class DictionaryMatchIndexWidget extends StatefulWidget {

  final List<IndexTableEntry> indexes;

  const DictionaryMatchIndexWidget(this.indexes, {super.key});

  @override
  State<DictionaryMatchIndexWidget> createState() => _DictionaryMatchIndexWidgetState();
}

class _DictionaryMatchIndexWidgetState extends State<DictionaryMatchIndexWidget> {

  List<IndexTableEntry> uniqueIndexes = [];

  @override
  void initState() {
    // get the unique tags
    final map = <String, IndexTableEntry>{};
    for (final index in widget.indexes) {
      map.putIfAbsent(index.title, () => index);
    }
    uniqueIndexes = map.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: [
        for (final uniqueIndex in uniqueIndexes)
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              
              // show snackbar with dictionary details
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(
                  uniqueIndex.description ?? "No description available.}"
                )),
              ),
              child: Chip(
              labelPadding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 0.0),
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                backgroundColor: Colors.green,
                label: Text(
                  '${uniqueIndex.currentSortingOrder}: ${uniqueIndex.title}',
                  style: const TextStyle(fontSize: 11),
                ),
              ),
            ),
          ),
      ]
    );
  }
}
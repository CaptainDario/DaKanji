import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';
import 'package:flutter/material.dart';


class DictionaryMatchTermBankStructuredContentDefinitionsWidget extends StatefulWidget {

  /// The term bank entries to display 
  final List<TermBankV3Entry> entries;


  const DictionaryMatchTermBankStructuredContentDefinitionsWidget(
    this.entries,
    {
      super.key
    }
  );

  @override
  State<DictionaryMatchTermBankStructuredContentDefinitionsWidget> createState() => _DictionaryMatchTermBankStructuredContentDefinitionsWidgetState();
}

class _DictionaryMatchTermBankStructuredContentDefinitionsWidgetState extends State<DictionaryMatchTermBankStructuredContentDefinitionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Moin"));
  }
}
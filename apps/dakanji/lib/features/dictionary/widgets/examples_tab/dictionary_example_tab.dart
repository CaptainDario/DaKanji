// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';



class DictionaryExampleTab extends StatefulWidget {

  /// The entry for which examples should be shown
  final JMdict? entry;

  const DictionaryExampleTab(
    this.entry,
    {
      super.key
    }
  );

  @override
  State<DictionaryExampleTab> createState() => _DictionaryExampleTabState();
}

class _DictionaryExampleTabState extends State<DictionaryExampleTab> {

  /// A list of all example sentences that contain the given entry
  List<ExampleSentence> examples = [];
  /// The future that searches for examples in an isolate
  Future<List<ExampleSentence>>? examplesSearch;
  /// A spans (start, end) that matched the current dict entry
  List<List<Tuple2<int, int>>> matchSpans = [];


  @override
  void initState() {
    initExamples();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DictionaryExampleTab oldWidget) {
    initExamples();
    super.didUpdateWidget(oldWidget);
  }

  /// Initializes the list of example sentences.
  /// Limit is the maximum number of examples to be loaded. -1 means no limit.
  Future initExamples({int limit = 10}) async {


      
  }
  

  @override
  Widget build(BuildContext context) {

    return Text("Todo: implement example sentences tab");

    
  }

}

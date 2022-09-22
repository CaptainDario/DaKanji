import 'package:flutter/material.dart';

import 'package:database_builder/src/jm_enam_and_dict_to_hive/dataClasses_objectbox.dart';



class DictionaryScreenWordTab extends StatefulWidget {
  DictionaryScreenWordTab(
    this.entry,
    {Key? key}
  ) : super(key: key);

  /// the dict entry that should be shown 
  final Jm_enam_and_dict_Entry? entry;


  @override
  State<DictionaryScreenWordTab> createState() => _DictionaryScreenWordTabState();
}

class _DictionaryScreenWordTabState extends State<DictionaryScreenWordTab> {

  @override
  Widget build(BuildContext context) {
    if(widget.entry == null)
      return Container();
    else
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // word
              Text(
                widget.entry!.kanjis.length != 0 ?
                  widget.entry!.kanjis[0] : "",
                style: TextStyle(
                  fontSize: 24
                ),
              ),
              // word reading
              Row(
                children: [
                  ...List.generate(
                    widget.entry!.readings.length,
                    (index) => Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        )
                      ),
                      child: Text(
                        widget.entry!.readings[index],
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    ),
                  )
                ],
              ),
              // part of speech
              ...List.generate(widget.entry!.partOfSpeech.length, (index) =>
                Text(widget.entry!.partOfSpeech[index])
              ),
              // meaning 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    widget.entry!.meanings[0].meanings.length,
                    (int index) => Text(
                      "${(index+1).toString()}. ${widget.entry!.meanings[0].meanings[index]}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20
                      ),
                    )
                  )
                ],
              ),
              ExpansionTile(
                title: Text("Images")
              ),
              ExpansionTile(
                title: Text("Proverbs")
              ),
              ExpansionTile(
                title: Text("Synonyms")
              )
            ],
          ),
        )
      );
  }
}
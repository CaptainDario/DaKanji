import 'package:flutter/material.dart';



class DictionaryScreenSearchTab extends StatefulWidget {
  DictionaryScreenSearchTab(
    this.height,
    this.width,
    {Key? key}
  ) : super(key: key);

  double height;
  double width;

  @override
  State<DictionaryScreenSearchTab> createState() => _DictionaryScreenSearchTabState();
}

class _DictionaryScreenSearchTabState extends State<DictionaryScreenSearchTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.height * 0.1,
          child: Card(
            child: TextField(
              
            ),
          ),
        ),
        SizedBox(height: widget.height*0.05,),
        Container(
          height: widget.height * 0.85,
          width: widget.width,
          child: AnimatedList(
            initialItemCount: 100,
            itemBuilder: ((context, index, animation) {
              return Card(
                child: Text(
                  index.toString()
                )
              );
            })
          ),
        ),
      ],
    );
  }
}
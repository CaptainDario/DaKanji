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

  final GlobalKey<AnimatedListState> animatedListKey =
    GlobalKey<AnimatedListState>();

  int currentItems = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.height * 0.1,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (text) {
                  for (var i = 0; i < 10; i++) {
                    Future.delayed(Duration(milliseconds: i*50), () {
                        animatedListKey.currentState!.removeItem(i, 
                          (context, animation) => FadeTransition(opacity: animation),
                        );
                        animatedListKey.currentState!.insertItem(i);
                      }
                    );
                  }
                },
              ),
            ),
          ),
        ),
        SizedBox(height: widget.height*0.05,),
        Container(
          height: widget.height * 0.85,
          width: widget.width,
          child: AnimatedList(
            key: animatedListKey,
            initialItemCount: 10,
            itemBuilder: ((context, index, animation) {
              return FadeTransition(
                opacity: animation,
                child: Card(
                  child: Text(
                    index.toString()
                  )
                ),
              );
            })
          ),
        ),
      ],
    );
  }
}
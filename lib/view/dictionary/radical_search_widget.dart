import 'package:flutter/material.dart';



class RadicalSearchWidget extends StatefulWidget {

  const RadicalSearchWidget(
    {
      required this.height,
      required this.width,
      super.key
    }
  );

  /// The height of this widget
  final double height;
  /// The width of this widget
  final double width;

  @override
  State<RadicalSearchWidget> createState() => _RadicalSearchWidgetState();
}

class _RadicalSearchWidgetState extends State<RadicalSearchWidget> {

  List<String> selectedRadicals = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: widget.width/2-16,
          height: widget.height,
          color: Colors.green,
          child: ListView(
            shrinkWrap: true,
            children: List.generate(10, (i) => 
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      i.toString(),
                      style: TextStyle(
                        color: MediaQuery.of(context).platformBrightness == Brightness.dark
                          ? Colors.white
                          : Colors.black
                      ),
                      textScaleFactor: 1.25,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: List.generate(10, (j) => 
                      InkWell(
                        onTap: (){},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Text(
                            "部",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24
                            ),
                          ),
                        ),
                      )
                    )
                  ),
                ),
                SizedBox(height: 10,)
              ]
            ).expand((i) => i).toList()
          ),
        ),
        Container(
          width: widget.width/2-16,
          height: widget.height,
          color: Colors.orange,
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Wrap(
                children: List.generate(500, (i) =>
                    Card(
                      child: InkWell(
                        onTap: (){},
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Container(
                          height: 30,
                          width: 30,
                          child: FittedBox(
                            child: Text(
                              "口"
                            ),
                          )
                        ),
                      )
                    )
                  )
              ),
            ),
          ),
        )
        
      ],
    );
  }
}
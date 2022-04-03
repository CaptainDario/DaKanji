import 'package:flutter/material.dart';



/// Simple helper widget which allows to wrap many focus-widgets
/// around the given widget and set the focusNode attribute to the elements
/// of the list focusNodes
class MultiFocus extends StatelessWidget {
  const MultiFocus({
    required this.focusNodes,
    required this.child,
    Key? key
    }) : super(key: key);

  /// all focusNodes which should be wrapped around the child
  final List<FocusNode> focusNodes;
  /// the child around which the focus nodes should be wrapped
  final Widget child;



  @override
  Widget build(BuildContext context) {

    Widget wrapped = child;

    for (int i = 0; i < focusNodes.length; i++){
      wrapped = Focus(
        focusNode: focusNodes[i],
        child: wrapped,
      );
    }

    return wrapped;
  }
}
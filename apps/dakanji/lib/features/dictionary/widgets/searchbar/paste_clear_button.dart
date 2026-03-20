import 'package:da_kanji_mobile/features/tutorial/model/tutorials.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// import your tutorials here

class PasteClearButton extends StatelessWidget {
  final SearchController controller;
  final VoidCallback onPressed;

  const PasteClearButton({
    super.key,
    required this.controller,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.searchInputClearStep,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onPressed,
        onLongPress: onPressed,
        child: SizedBox(
          width: 30,
          height: 30,
          // ListenableBuilder listens to the controller.
          // Now, ONLY this tiny widget rebuilds when the user types!
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, child) {
              return Icon(
                controller.text.isEmpty ? Icons.paste : Icons.clear,
                size: 20,
              );
            },
          ),
        ),
      ),
    );
  }
}
import 'package:da_kanji_mobile/features/tutorial/model/tutorials.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RadicalButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RadicalButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.searchRadicalStep,
      child: InkWell(
        // Note: 100 is enough to make a 30x30 container perfectly circular
        borderRadius: BorderRadius.circular(100), 
        onTap: onPressed,
        child: Container(
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Transform.translate(
              offset: const Offset(0, -2),
              child: const Text(
                "部",
                style: TextStyle(
                  fontSize: 20,
                ),
                textScaler: TextScaler.noScaling,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
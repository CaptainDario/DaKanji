import 'package:da_kanji_mobile/core/routing/navigation_arguments.dart';
import 'package:da_kanji_mobile/core/routing/screens.dart';
import 'package:da_kanji_mobile/features/settings/model/settings.dart';
import 'package:da_kanji_mobile/features/tutorial/model/tutorials.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
// Add your other imports (Settings, Screens, NavigationArguments, Tutorials)

class DrawButton extends StatelessWidget {
  final SearchController controller;

  const DrawButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.searchInputDrawStep,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          // Calculate Prefix and Postfix cleanly
          final text = controller.text;
          final offset = controller.selection.baseOffset;
          final safeOffset = offset == -1 ? text.length : offset;

          final prefix = text.isNotEmpty ? text.substring(0, safeOffset) : "";
          final postfix = text.isNotEmpty ? text.substring(safeOffset) : "";

          // 3. Navigate
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/${Screens.drawing.name}",
            (route) => true,
            arguments: NavigationArguments(
              false,
              drawSearchPrefix: prefix,
              drawSearchPostfix: postfix,
            ),
          );
        },
        child: const SizedBox(
          width: 30,
          height: 30,
          child: Icon(Icons.brush),
        ),
      ),
    );
  }
}
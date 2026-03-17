import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings//search_profile_settings_info_widgets.dart';
import 'package:flutter/material.dart';



class SearchProfileSearchProfileCardAddButton extends StatelessWidget {

  final String text;

  final String? disabledReason;

  final VoidCallback? onPressed;

  const SearchProfileSearchProfileCardAddButton(
    this.text,
    {
      this.disabledReason,
      this.onPressed,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias, 
      child: GestureDetector(
        onTap: onPressed == null && disabledReason != null
          ? () => showInfoSnackbar(disabledReason!, context)
          : null, // Ignore tap if button is enabled or no reason given
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.add),
          label: Text(text),
          style: OutlinedButton.styleFrom(
            side: BorderSide.none, 
            minimumSize: const Size.fromHeight(52),
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';



class DictionaryMatchTag extends StatelessWidget {

  /// The tag's leading text to display.
  final String? leadingText;

  /// The tag's leading text color.
  final Color? leadingTextColor;

  /// The tag's text to display.
  final String text;

  /// The tag's text color.
  final Color? textColor;

  /// The tag's notes to show in a snackbar.
  final String? details;

  /// The tag's color.
  final Color color;

  /// The tag's lading color
  final Color leadingColor;

  /// The tag's border color.
  final Color borderColor;

  const DictionaryMatchTag(
    {
      required this.text,
      this.leadingTextColor,
      this.details,
      this.leadingText,
      this.textColor,
      this.color = Colors.transparent,
      this.leadingColor = Colors.transparent,
      this.borderColor = Colors.grey,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      mouseCursor: details == null || details!.isEmpty
        ? null
        : SystemMouseCursors.click,
      /// show snackbar
      onTap: details == null || details!.isEmpty
        ? null
        : () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(details!)),
        ),
      child: Container(        
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(leadingText != null)
              ...[
                Text(
                  leadingText!,
                  style: TextStyle(
                    fontSize: 11,
                    color: leadingTextColor,
                    fontWeight: FontWeight.w300
                  ),
                ),
                SizedBox(
                  height: 14,
                  child: VerticalDivider(
                    width: 8,
                    thickness: 1,
                    color: borderColor,
                  ),
                ),
              ],
            Text(
              text,
              style: TextStyle(fontSize: 11, color: textColor),
            )
          ],
        ),
      ),
    );
  }
}
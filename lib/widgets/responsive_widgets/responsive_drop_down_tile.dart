// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';

/// A widget that shows a responsive drop down menu
class ResponsiveDropDownTile extends StatefulWidget {

  /// the description of this settings
  final String text;
  /// the selected value
  final String? value;
  /// the text which should be shown in the dropdown
  final List<String> items;
  /// should the items be translate using easzlocalization
  final bool translateItemTexts;
  /// Icon of the leading button
  final IconData? leadingButtonIcon;
  /// Callback that is executed when the user taps on the leading button
  final Function()? leadingButtonPressed;
  /// callback which will be executed eveytime when the selection changed
  final Function ()? onTap;
  /// callback which will be executed eveytime when the selection changed
  final Function (String? value)? onChanged;
  /// The autoSizeGroup for this Tile
  final AutoSizeGroup? autoSizeGroup;
  /// max lines of the dropdown
  final int dropDownMaxLines;


  const ResponsiveDropDownTile(
    {
      required this.text,
      required this.value,
      required this.items,
      this.translateItemTexts  = false,
      this.leadingButtonIcon,
      this.leadingButtonPressed,
      this.onTap,
      this.onChanged,
      this.autoSizeGroup,
      this.dropDownMaxLines=0,
      super.key
    }
  );

  @override
  State<ResponsiveDropDownTile> createState() => _ResponsiveDropDownTileState();
}

class _ResponsiveDropDownTileState extends State<ResponsiveDropDownTile> {

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double tileHeight = (height * 0.1).clamp(0, 45);
    double width = MediaQuery.of(context).size.width;

    return Material(
      child: InkWell(
        onTap: () {},
        child: Container(
          width: width,
          constraints: BoxConstraints(minHeight: tileHeight),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(widget.leadingButtonIcon != null)
                IconButton(
                  onPressed: () {
                    widget.leadingButtonPressed?.call();
                  },
                  icon: Icon(widget.leadingButtonIcon!)
                ),
              Expanded(
                child: Text(
                  widget.text,
                ),
              ),
              SizedBox(width: (width*0.05).clamp(0, 10),),
              DropdownButton<String>(
                value: widget.value,
                items: widget.items.map((text) {
                  
                  return DropdownMenuItem<String>(
                    value: text,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: width*0.4
                      ),
                      child: Text(
                        widget.translateItemTexts ? text.tr() : text, 
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    ),
                  );
                }).toList(),
                onTap: () {
                  widget.onTap?.call();
                },
                onChanged: (String? newValue) {
                  widget.onChanged?.call(newValue);
                },
              ),
            ]
          ),
        ),
      ),
    );
  }
}

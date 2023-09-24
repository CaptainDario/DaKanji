// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';

class ResponsiveDropDownTile extends StatefulWidget {
  const ResponsiveDropDownTile(
    {
      required this.text,
      required this.value,
      required this.items,
      this.translateItemTexts  = false,
      this.onTap,
      this.autoSizeGroup,
      Key? key
    }
  ) : super(key: key);

  /// the description of this settings
  final String text;
  /// the selected value
  final String value;
  /// the text which should be shown in the dropdown
  final List<String> items;
  /// should the items be translate using easzlocalization
  final bool translateItemTexts;
  /// callback which will be executed by every button press
  final Function (String? value)? onTap;
  /// The autoSizeGroup for this Tile
  final AutoSizeGroup? autoSizeGroup;



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
        onTap: () {
          
        },
        child: SizedBox(
          height: tileHeight,
          width: width,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: (tileHeight*0.75).clamp(0, 30),
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    widget.text,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    group: g_SettingsAutoSizeGroup,
                    minFontSize: g_MinFontSize,
                  )
                ),
              ),
              SizedBox(width: (width*0.05).clamp(0, 10),),
              DropdownButton<String>(
                value: widget.value,
                items: widget.items.map((text) {
                  
                  return DropdownMenuItem<String>(
                    value: text,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.35,
                      child: AutoSizeText(
                        widget.translateItemTexts ? text.tr() : text, 
                        maxLines: 2,
                        minFontSize: g_MinFontSize,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        group: g_SettingsAutoSizeGroup,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if(widget.onTap != null) widget.onTap!(newValue);
                },
              ),
            ]
          ),
        ),
      ),
    );
  }
}

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

class ResponsiveSliderTile extends StatefulWidget {
  
  /// the text to display
  final String text;
  /// the value of the slider
  final double value;
  /// the minimum value of the slider
  final double min;
  /// the maximum value of the slider
  final double max;
  /// The number of discrete divisions. If null, the slider is continuous.
  final int? divisions;
  /// the icon for the button to press
  final IconData? leadingIcon;
  /// when set to a value shows a leading info icon and when the user presses
  /// this icon a info dialog will open
  final String? infoText;
  /// Should the label that indicates the current value be rounded to an int value
  final bool showLabelAsInt;
  /// The autoSizeGroup to use for the text
  final AutoSizeGroup? autoSizeGroup;
  /// callback which is executed when the user moves the slider
  final Function (double value)? onChanged;
  /// callback which is executed when the user stops moving the slider
  final Function (double value)? onChangeEnd;
  /// callback which will be execute when the icon button on the side is pressed
  final Function? onLeadingIconPressed;

  const ResponsiveSliderTile(
    {
      required this.text,
      required this.value,
      this.min = 0.0,
      this.max = 1.0,
      this.divisions,
      this.leadingIcon,
      this.infoText,
      this.showLabelAsInt = false,
      this.autoSizeGroup,
      this.onChanged,
      this.onChangeEnd,
      this.onLeadingIconPressed,
      super.key
    }
  );

  @override
  State<ResponsiveSliderTile> createState() => _ResponsiveSliderTileState();
}

class _ResponsiveSliderTileState extends State<ResponsiveSliderTile> {
  

  
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double tileHeight = (height * 0.1).clamp(0, 45);
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {},
      child: Container(
        width: width,
        constraints: BoxConstraints(minHeight: tileHeight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(widget.onLeadingIconPressed != null)
              IconButton(
                onPressed: () => widget.onLeadingIconPressed?.call(),
                icon: Icon(widget.leadingIcon)
              ),
            Flexible(
              child: Text(
                widget.text,
              ),
            ),
            SliderTheme(
              data: const SliderThemeData(showValueIndicator: ShowValueIndicator.always),
              child: Slider(
                value: widget.value,
                min: widget.min,
                max: widget.max,
                label: widget.showLabelAsInt
                  ? widget.value.round().toString()
                  : widget.value.toStringAsFixed(2),
                divisions: widget.divisions,
                
                onChanged: (double value) {
                  widget.onChanged?.call(value);
                },
                onChangeEnd: (value) {
                  widget.onChangeEnd?.call(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

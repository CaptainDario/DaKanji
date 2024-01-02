// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

/// A analysis option button. Either `svgAssetPattern` or `icon` needs to be 
/// not null.
class AnalysisOptionButton extends StatefulWidget {

  /// is this analysis option on or off
  final bool on;
  /// A path pattern to an svg asset, a `*` indicates which part of the path
  /// should be replaced with `on` or `off` matching the current state
  final String? svgAssetPattern;
  /// The on-icon of this button, ignored if `svgAssetPattern` is not null
  final IconData? onIcon;
  /// The off-icon of this button, ignored if `svgAssetPattern` is not null
  final IconData? offIcon;
  /// method that is invoked when pressing this button
  final void Function()? onPressed;
  /// method that is invoked when long pressing this button
  final void Function()? onLongPressed;

  const AnalysisOptionButton(
    this.on,
    {
      this.svgAssetPattern,
      this.onIcon,
      this.offIcon,
      this.onPressed,
      this.onLongPressed,
      super.key
    }
  );

  @override
  State<AnalysisOptionButton> createState() => _AnalysisOptionButtonState();
}

class _AnalysisOptionButtonState extends State<AnalysisOptionButton> {

  @override
  void initState() {
    
    super.initState();

    assert ((widget.onIcon != null && widget.offIcon != null) ||
      (widget.svgAssetPattern != null));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        radius: 8,
        customBorder: const CircleBorder(),
        onTap: widget.onPressed,
        onLongPress: widget.onLongPressed,
        child: IgnorePointer(
          child: IconButton(
            icon: widget.svgAssetPattern != null
              ? SvgPicture.asset(
                !widget.on ?
                  widget.svgAssetPattern!.replaceAll("*", "off") :
                  widget.svgAssetPattern!.replaceAll("*", "on"),
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              )
              : Icon(
                !widget.on ? widget.onIcon! : widget.offIcon!
              ),
            onPressed: () { },
          ),
        ),
      ),
    );
  }
}

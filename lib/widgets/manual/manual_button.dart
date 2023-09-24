// Flutter imports:
import 'package:flutter/material.dart';

/// A button that is used to open a manual page
class ManualButton extends StatelessWidget {
  /// The size of this button (always square)
  final double size;
  /// The icon of this button
  final IconData icon;
  /// The text the is shown below the icon of this button
  final String text;
  /// Function that is invoked when this button is pressed
  final void Function()? onPressed;

  const ManualButton(
    {
      required this.size,
      required this.icon,
      required this.text,
      this.onPressed,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: onPressed,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 100,
                ),
                const SizedBox(height: 2,),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}

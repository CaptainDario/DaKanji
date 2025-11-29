import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';


class ResponsiveSpinboxTile extends StatelessWidget {

  final String text;
  
  final double min;

  final double value;

  final String? suffix;

  final Function(double value)? onChanged;


  const ResponsiveSpinboxTile(
    {
      required this.text,
      required this.min,
      required this.value,
      this.suffix,
      this.onChanged,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Text(text),
            SizedBox(width: 8),
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: SpinBox(
                min: min,
                decoration:  suffix != null
                  ? InputDecoration(
                    suffix: Text(suffix!),
                  )
                  : null,
                onChanged: onChanged
              ),
            ),
          ],
        ),
      ),
    );
  }
}
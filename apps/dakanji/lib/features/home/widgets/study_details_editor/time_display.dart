import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TimeDisplay extends StatelessWidget {
  final String label;
  final DateTime time;
  final VoidCallback onTap;
  final bool isError;
  final bool isNextDay;

  const TimeDisplay({
    super.key,
    required this.label,
    required this.time,
    required this.onTap,
    this.isError = false,
    this.isNextDay = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Label
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 6),
        
        // Time Box Input
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: isError ? Colors.red.withValues(alpha: 0.1) : Colors.white10,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isError ? Colors.redAccent : Colors.transparent, 
              ),
            ),
            // Time content and flags
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('HH:mm').format(time),
                  style: const TextStyle(
                    color: Colors.white, 
                    fontSize: 18, 
                    fontWeight: FontWeight.w500
                  ),
                ),
                // Next day indicator badge
                if (isNextDay)
                  const Padding(
                    padding: EdgeInsets.only(left: 2.0, top: 0),
                    child: Text(
                      "+1",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
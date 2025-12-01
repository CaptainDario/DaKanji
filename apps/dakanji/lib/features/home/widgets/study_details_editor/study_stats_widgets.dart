import 'package:flutter/material.dart';

class StatRow extends StatelessWidget {
  final String label;
  final (int, int) data;
  final Color color;

  const StatRow({
    super.key,
    required this.label,
    required this.data,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Text(
            "$label: ",
            style: TextStyle(color: Colors.grey[300], fontSize: 16),
          ),
          Text(
            "${data.$1} / ${data.$2}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
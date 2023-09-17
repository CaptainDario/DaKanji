// Flutter imports:
import 'package:flutter/material.dart';

class KanaTrainer extends StatefulWidget {
  const KanaTrainer({super.key});

  @override
  State<KanaTrainer> createState() => _KanaTrainerState();
}

class _KanaTrainerState extends State<KanaTrainer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Kana trainer widget"
      )
    );
  }
}

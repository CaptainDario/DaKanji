import 'dart:ui';
import 'package:flutter/material.dart';

void showTimeTrackingPopup({
  required BuildContext context,
  required GlobalKey iconKey,
  required Widget child,
}) {
  final RenderBox? renderBox = iconKey.currentContext?.findRenderObject() as RenderBox?;
  final Size screenSize = MediaQuery.of(context).size;

  Alignment scaleOrigin = Alignment.topRight;

  if (renderBox != null) {
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final double iconCenterX = position.dx + size.width / 2;
    final double iconCenterY = position.dy + size.height / 2;

    final double alignX = (iconCenterX / (screenSize.width / 2)) - 1;
    final double alignY = (iconCenterY / (screenSize.height / 2)) - 1;

    scaleOrigin = Alignment(alignX, alignY);
  }

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.transparent, 
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (ctx, anim1, anim2) {
      return Align(
        alignment: Alignment.center,
        child: child,
      );
    },
    transitionBuilder: (ctx, anim1, anim2, child) {
      final scaleCurve = CurvedAnimation(
        parent: anim1,
        curve: Curves.easeInOutQuart,
      );

      final fadeCurve = CurvedAnimation(
        parent: anim1,
        curve: Curves.easeInOut,
      );

      return Stack(
        children: [
          FadeTransition(
            opacity: fadeCurve,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.4),
                ),
              ),
            ),
          ),
          ScaleTransition(
            scale: scaleCurve,
            alignment: scaleOrigin,
            child: child,
          ),
        ],
      );
    },
  );
}
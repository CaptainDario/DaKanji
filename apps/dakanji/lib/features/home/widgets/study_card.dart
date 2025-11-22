import 'package:flutter/material.dart';
import 'dart:ui'; // Required for ImageFilter

class StudyCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final int currentProgress;
  final int dailyGoal;
  final Color color;
  final String action;
  final IconData icon;

  const StudyCard({
    required this.title,
    required this.subtitle,
    required this.currentProgress,
    required this.dailyGoal,
    required this.color,
    required this.action,
    required this.icon,
    super.key,
  });

  @override
  State<StudyCard> createState() => _StudyCardState();
}

class _StudyCardState extends State<StudyCard> with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    // Opacity Animation: Breaths between 0.4 and 0.8
    _glowAnimation = Tween<double>(begin: 0.4, end: 0.8).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progressValue = widget.dailyGoal == 0 
        ? 0.0 
        : (widget.currentProgress / widget.dailyGoal);
    
    double visualProgress = progressValue.clamp(0.0, 1.0);
    bool isComplete = progressValue >= 1.0;
    bool isHalfway = progressValue >= 0.5;

    // Icon Colors
    Color activeIconColor = Color.lerp(widget.color, Colors.white, 0.2)!;
    Color currentIconColor = isHalfway ? activeIconColor : Colors.grey.shade700;

    return Card(
      color: const Color(0xFF1E2329),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Left: Animated Progress Area
            SizedBox(
              height: 75,
              width: 75,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // 1. The Ring (Glows + Main Stroke)
                  // We wrap the Stack in the builder so the Glow fills in sync with the Main ring.
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: visualProgress),
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.easeOutExpo,
                      builder: (context, value, _) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            // --- RING GLOW LAYERS (Only if complete) ---
                            if (isComplete)
                            AnimatedBuilder(
                              animation: _glowAnimation,
                              builder: (context, child) {
                                double opacity = _glowAnimation.value.clamp(0.0, 1.0);
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    // Layer A: Wide Atmospheric Glow
                                    Opacity(
                                      opacity: (opacity * 0.5).clamp(0.0, 1.0),
                                      child: ImageFiltered(
                                        imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                        child: CircularProgressIndicator(
                                          value: value,
                                          strokeWidth: 5,
                                          color: widget.color, 
                                          strokeCap: StrokeCap.round, // Rounded ends look better for neon
                                          backgroundColor: Colors.transparent, // No track for glow
                                        ),
                                      ),
                                    ),
                                    // Layer B: Tight Intense Glow
                                    Opacity(
                                      opacity: opacity,
                                      child: ImageFiltered(
                                        imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                        child: CircularProgressIndicator(
                                          value: value,
                                          strokeWidth: 5,
                                          color: widget.color,
                                          strokeCap: StrokeCap.round,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),

                            // --- MAIN SHARP RING ---
                            CircularProgressIndicator(
                              value: value,
                              strokeWidth: 5,
                              color: widget.color,
                              strokeCap: StrokeCap.round,
                              backgroundColor: widget.color.withValues(alpha: 0.1),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  // 2. The Icon (Glows + Main Icon)
                  if (isComplete) ...[
                    AnimatedBuilder(
                      animation: _glowAnimation,
                      builder: (context, child) {
                        double opacity = _glowAnimation.value.clamp(0.0, 1.0);
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                             // Icon Layer A: Wide Glow
                            Opacity(
                              opacity: (opacity * 0.5).clamp(0.0, 1.0),
                              child: ImageFiltered(
                                imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                child: Icon(widget.icon, size: 36, color: widget.color),
                              ),
                            ),
                             // Icon Layer B: Tight Glow
                            Opacity(
                              opacity: opacity,
                              child: ImageFiltered(
                                imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                child: Icon(widget.icon, size: 36, color: widget.color),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],

                  // 3. The Sharp Icon (Top Layer)
                  Icon(
                    widget.icon,
                    size: 36,
                    color: currentIconColor,
                  ),

                ],
              ),
            ),
            const SizedBox(width: 16),
            
            // Middle: Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    style: TextStyle(color: Colors.grey[400], fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.currentProgress} / ${widget.dailyGoal}',
                    style: TextStyle(color: widget.color, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            
            // Right: Button
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.color,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: Text(
                  widget.action,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
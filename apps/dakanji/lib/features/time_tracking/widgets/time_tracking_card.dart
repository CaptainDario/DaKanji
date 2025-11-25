import 'package:flutter/material.dart';

class TimeTrackingCard extends StatelessWidget {
  final Color accentColor;

  const TimeTrackingCard({
    super.key, 
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    const Color cardBackground = Color(0xFF1E1E1E); 

    return Material(
      color: Colors.transparent,
      child: Container(
        width: 320,
        height: 360,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.3),
              blurRadius: 60,
              spreadRadius: 5,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Timer & Progress Section
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Glow
                  Container(
                    width: 230,
                    height: 230,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withValues(alpha: 0.2),
                          blurRadius: 30,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  // Progress Arc
                  SizedBox(
                    width: 230,
                    height: 230,
                    child: CircularProgressIndicator(
                      value: 0.75, 
                      strokeWidth: 12,
                      // 'backgroundColor' creates the faint track behind the progress
                      backgroundColor: accentColor.withValues(alpha: 0.1), 
                      valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  // Text Content
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.remove_red_eye_outlined, color: Colors.grey, size: 18),
                      const SizedBox(height: 8),
                      const Text(
                        "25:00",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == 0 ? accentColor : Colors.grey.withValues(alpha: 0.3),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "FOCUS",
                        style: TextStyle(
                          color: accentColor.withValues(alpha: 0.8),
                          fontSize: 12,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Controls Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.category_outlined),
                    color: Colors.grey,
                    tooltip: "Categories",
                  ),
                ),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: const StadiumBorder(),
                    elevation: 8,
                    shadowColor: accentColor.withValues(alpha: 0.5),
                  ),
                  child: const Text("Track"),
                ),

                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.tag_outlined),
                    color: Colors.grey,
                    tooltip: "Tags",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
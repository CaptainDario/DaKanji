import 'package:flutter/material.dart';
import 'package:flutter_util/widgets/custom_border_container.dart';

/// A renderer for pitch accent patterns.
/// 
/// Supports Yomitan's N+1 pitch strings, where the final character 
/// defines the pitch of a trailing particle/suffix.
class TermMetaPitchAccentWidget extends StatelessWidget {
  final String reading;
  final String pitchPattern;
  
  final Set<int> _nasalPositions;
  final Set<int> _devoicePositions;

  TermMetaPitchAccentWidget({
    required this.reading,
    required this.pitchPattern,
    dynamic nasalPosition,   // Accept dynamic to handle int, List<int>, or null
    dynamic devoicePosition,
    super.key,
  })  : _nasalPositions = _convertToSet(nasalPosition),
        _devoicePositions = _convertToSet(devoicePosition),
        assert(reading.isNotEmpty && pitchPattern.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    final List<String> chars = reading.characters.toList();
    // Use the pitchPattern length to drive the loop to handle suffixes (N+1)
    final int totalSegments = pitchPattern.length;

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (int i = 0; i < totalSegments; i++)
          _buildSegment(context, i, i < chars.length ? chars[i] : null),
      ],
    );
  }

  Widget _buildSegment(BuildContext context, int index, String? char) {
    final int position = index + 1;
    final String current = pitchPattern[index].toUpperCase();
    final String? next = (index + 1 < pitchPattern.length) 
        ? pitchPattern[index + 1].toUpperCase() 
        : null;

    final bool isDashed = _devoicePositions.contains(position);
    final bool isNasal = _nasalPositions.contains(position);

    return CustomBorderContainer(
      dashLength: 1.5,
      dashSpace: 1.5,
      border: _calculateBorder(current, next, isDashed),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.5),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // If char is null, render the N+1 (suffix) pitch line
            Text(
              char ?? '\u200B', // Use zero-width space for the suffix "phantom" segment
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isNasal) _renderNasalDot(),
          ],
        ),
      ),
    );
  }

  CustomBorderStyle _calculateBorder(String current, String? next, bool isDashed) {
    final bool isHigh = current == 'H';
    final CustomBorderStyleTypes lineType = isDashed
        ? CustomBorderStyleTypes.dashed
        : CustomBorderStyleTypes.solid;
    
    final bool hasStep = next != null && current != next;

    return CustomBorderStyle(
      top: isHigh ? lineType : CustomBorderStyleTypes.none,
      bottom: !isHigh ? lineType : CustomBorderStyleTypes.none,
      right: hasStep ? CustomBorderStyleTypes.solid : CustomBorderStyleTypes.none,
    );
  }

  Widget _renderNasalDot() {
    return Positioned(
      right: -2,
      top: 0,
      child: Container(
        height: 5,
        width: 5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey.withValues(alpha: 0.8), 
            width: 1.0,
          ),
        ),
      ),
    );
  }

  /// Helper to handle Yomitan's varied data types
  static Set<int> _convertToSet(dynamic input) {
    if (input == null) return {};
    if (input is int) return {input};
    if (input is List) return input.cast<int>().toSet();
    return {};
  }
}
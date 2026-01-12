import 'package:dakanji_db_example/widgets/custom_border_container.dart';
import 'package:flutter/material.dart';


class PitchAccentWidget extends StatelessWidget {
  
  final String reading;

  final int pitchPosition;

  final int? nasalPosition;

  final int? devoicePosition;
  
  const PitchAccentWidget(
    this.reading,
    this.pitchPosition,
    {
      this.nasalPosition,
      this.devoicePosition,
      super.key
    }
  );

  static const Set<String> smallCombiningKana = {
    'ゃ', 'ゅ', 'ょ', 'ぁ', 'ぃ', 'ぅ', 'ぇ', 'ぉ',
    'ャ', 'ュ', 'ョ', 'ァ', 'ィ', 'ゥ', 'ェ', 'ォ',
  };

  static const CustomBorderStyle falling = CustomBorderStyle(
    top: .solid,
    right: .solid,
  );
  static const CustomBorderStyle rising = CustomBorderStyle(
    right: .solid,
    bottom: .solid,
  );    
  static const CustomBorderStyle low = CustomBorderStyle(
    bottom: .solid,
  );
  static const CustomBorderStyle high = CustomBorderStyle(
      top: .solid,
  );


  @override
  Widget build(BuildContext context) {

    List<String> morae = convertToMoraList(reading);

    return Wrap(
      children: [
        for (final (int i, String mora) in morae.indexed)
          CustomBorderContainer(
            dashLength: 1.5,
            dashSpace: 1.5,
            border: getPitchAccentDecoration(morae, i),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Text(
                    mora,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if(i+1 == nasalPosition)
                    Positioned(
                      right: -2,
                      top: 0,
                      child: Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          )
      ],
    );
  }

  List<String> convertToMoraList(String reading) {
    List<String> moraList = [];
    final runes = reading.runes.map((r) => String.fromCharCode(r)).toList();

    for (int i = 0; i < runes.length; i++) {
      final String char = runes[i];

      // LOOK AHEAD: Check if the *next* char is a small combining kana
      if (i + 1 < runes.length && smallCombiningKana.contains(runes[i + 1])) {
        moraList.add(char + runes[i + 1]);
        i++; // IMPORTANT: Skip the next rune since we've combined it
      } else {
        // Not a combining digraph, just add the char (e.g., "し", "ん", "っ")
        moraList.add(char);
      }
    }
    return moraList;
  }

  /// Determines the pitchAccent BoxDecoration for a given `reading` at `at`
  /// using the `pitchAccent` information of the entry.
  /// Returns the decoration to use for the character at `at`.
  /// 
  /// pitch accent: <br/>
  /// 0 - 平板 <br/>
  /// 1 - 頭高 <br/>
  /// 1 < `pitchAccent` < `reading.length` - 中高 <br/>
  /// `pitchAccent` == `reading.length` - 尾高 <br/>
  CustomBorderStyle getPitchAccentDecoration(List<String> mora, int at) {
    
    CustomBorderStyle ret;
    // 平板 
    if(pitchPosition == 0){
      if(at == 0) {
        ret = rising;
      } else {
        ret = high;
      }
    }
    // 頭高
    else if(pitchPosition == 1 && 1 < mora.length){
      if(at == 0) {
        ret = falling;
      } else {
        ret = low;
      }
    }
    // 中高
    else if(1 < pitchPosition && pitchPosition < mora.length){
      if(at == 0){
        ret = rising;
      }
      else if (0 < at && at < pitchPosition-1){
        ret = high;
      }
      else if (at == pitchPosition-1){
        ret = falling;
      }
      else {
        ret = low;
      }
    }
    // 尾高
    else if(pitchPosition == mora.length){
      if(at == 0){
        if(mora.length == 1) {
          ret = falling;
        } else {
          ret = rising;
        }
      }
      else if(0 < at && at < mora.length-1) {
        ret = high;
      } else if(at == mora.length-1) {
        ret = falling;
      } else {
        ret = low;
      }
    }
    else {
      throw Exception("Invalid pitch accent");
    }

    if(devoicePosition == at){
      ret = ret.copyWith(
        top   : ret.top    == .none ? .none : .dashed,
        bottom: ret.bottom == .none ? .none : .dashed,
      );
    }


    return ret;
  }
}


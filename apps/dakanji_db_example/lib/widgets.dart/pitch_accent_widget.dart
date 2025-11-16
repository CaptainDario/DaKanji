import 'package:flutter/material.dart';


class PitchAccentWidget extends StatelessWidget {
  
  final String reading;

  final int pitchPosition;
  
  const PitchAccentWidget(
    this.reading,
    this.pitchPosition,
    {
      super.key
    }
  );

  static const Set<String> smallCombiningKana = {
    'ゃ', 'ゅ', 'ょ', 'ぁ', 'ぃ', 'ぅ', 'ぇ', 'ぉ',
    'ャ', 'ュ', 'ョ', 'ァ', 'ィ', 'ゥ', 'ェ', 'ォ',
  };
  static const BorderSide empty = BorderSide(
    color: Colors.transparent,
    width: 1.5,
    
  );
  static const BoxDecoration falling = BoxDecoration(
    border: Border(
      left: empty,
      top: BorderSide(
        color: Colors.grey,
        width: 1.5,
      ),
      right: BorderSide(
        color: Colors.grey,
        width: 1.5,
      ),
      bottom: empty
    )
  );
  static const BoxDecoration rising = BoxDecoration(
    border: Border(
      left: empty,
      top: empty,
      right: BorderSide(
        color: Colors.grey,
        width: 1.5,
      ),
      bottom: BorderSide(
        color: Colors.grey,
        width: 1.5,
      ),
    )
  );    
  static const BoxDecoration low = BoxDecoration(
    border: Border(
      left: empty,
      top: empty,
      right: empty,
      bottom: BorderSide(
        color: Colors.grey,
        width: 1.5,
      ),
    )
  );
  static const BoxDecoration high = BoxDecoration(
    border: Border(
      left: empty,
      top: BorderSide(
        color: Colors.grey,
        width: 1.5,
      ),
      right: empty,
      bottom: empty
    )
  );


  @override
  Widget build(BuildContext context) {

    List<String> morae = convertToMoraList(reading);

    return Wrap(
      children: [
        for (final (int i, String mora) in morae.indexed)
          Container(
            decoration: getPitchAccentDecoration(pitchPosition, morae, i),
            child: Text(
              mora,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
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
  BoxDecoration getPitchAccentDecoration(int pitchAccent, List<String> mora, int at) {
    
    // 平板 
    if(pitchAccent == 0){
      if(at == 0) {
        return rising;
      } else {
        return high;
      }
    }
    // 頭高
    else if(pitchAccent == 1 && 1 < mora.length){
      if(at == 0) {
        return falling;
      } else {
        return low;
      }
    }
    // 中高
    else if(1 < pitchAccent && pitchAccent < mora.length){
      if(at == 0){
        return rising;
      }
      else if (0 < at && at < pitchAccent-1){
        return high;
      }
      else if (at == pitchAccent-1){
        return falling;
      }
      else {
        return low;
      }
    }
    // 尾高
    else if(pitchAccent == mora.length){
      if(at == 0){
        if(mora.length == 1) {
          return falling;
        } else {
          return rising;
        }
      }
      else if(0 < at && at < mora.length-1) {
        return high;
      } else if(at == mora.length-1) {
        return falling;
      } else {
        return low;
      }
    }
    else {
      throw Exception("Invalid pitch accent");
    }
  }
}


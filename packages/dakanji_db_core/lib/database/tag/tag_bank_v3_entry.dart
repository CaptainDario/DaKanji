
import 'package:dakanji_db_core/database/index/index_table_entry.dart';
import 'package:dakanji_db_core/helper/json_index_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_bank_v3_entry.freezed.dart';
part 'tag_bank_v3_entry.g.dart';



@Freezed()

/// Class representing one stat of a tag entry of DaKanjiDB
abstract class TagBankV3Entry with _$TagBankV3Entry {

  const TagBankV3Entry._();

  const factory TagBankV3Entry(
    {
      /// id of this tag entry in sqlite database
      required int id,
      /// id of this entry's dictionary
      @IndexEntryConverter()
      required IndexEntry indexEntry,
      /// Tag name.
      required String name,
      /// Categories for the tag.
      required String category,
      /// Sorting order for the tag.
      required int sortingOrder,
      /// Notes for the tag.
      required String notes,
      /// Score used to determine popularity. Negative values are more rare and
      /// positive values are more frequent. This score is also used to sort search
      /// results.
      required int score,

    }) = _TagBankV3Entry;

  /// sort tags first by sortingOrder then by name to ensure consistent order
  int comparedTo(TagBankV3Entry other) {
    int orderComparison = sortingOrder.compareTo(other.sortingOrder);
    if (orderComparison != 0) {
      return orderComparison;
    }
    return name.compareTo(other.name);
  }



  factory TagBankV3Entry.fromJson(Map<String, Object?> json) 
    
    //if(json['indexEntry'] is String)
    //  json['indexEntry'] = jsonDecode(json['indexEntry'] as String);

    => _$TagBankV3EntryFromJson(json);
  

}

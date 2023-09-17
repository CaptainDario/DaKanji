


// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:da_kanji_mobile/domain/tree/tree_node_serializable.dart';
import 'package:da_kanji_mobile/domain/word_lists/word_lists_data.dart';

class TreeNodeConverter<T> implements JsonConverter<T, Object> {

  const TreeNodeConverter();

  @override
  T fromJson(Object json) {

    try {
      if(json is Map<String, dynamic>){
        return WordListsData.fromJson(json) as T;
      }
      else
        throw Exception("Object is not a TreeNodeSerializable");
    }
    catch (e) {
      throw Exception("Object is not a TreeNodeSerializable");
    }

  }

  @override
  Object toJson(T object) {

    if(object is TreeNodeSerializable)
      return object.toJson();
    else
      throw Exception("Object is not a TreeNodeSerializable");

  }
}

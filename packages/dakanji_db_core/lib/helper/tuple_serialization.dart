
import 'package:tuple/tuple.dart';

/// Helper functions to deserialize `Tuple2<int, String>`
Tuple2<int, String> tupleFromJson(Map<String, dynamic> json) {
  return Tuple2(json['item1'] as int, json['item2'] as String);
}

/// Helper functions to serialize Tuple3
Map<String, dynamic> tupleToJson(Tuple2<int, String> tuple) {
  return {
    'item1': tuple.item1,
    'item2': tuple.item2,
  };
}

/// Helper functions to deserialize `List<Tuple2<int, String>>`
List<Tuple2<int?, String?>> tupleListFromJson(List<dynamic> jsonList) {
  return jsonList.map((item) {
    final map = item as Map<String, dynamic>;
    return Tuple2(map['item1'] as int?, map['item2'] as String?);
  }).toList();
}

/// Helper functions to deserialize List<Tuple2<int, String>>
List<Map<String, dynamic>> tupleListToJson(List<Tuple2<int?, String?>> tupleList) {
  return tupleList.map((tuple) {
    return {
      'item1': tuple.item1,
      'item2': tuple.item2,
    };
  }).toList();
}

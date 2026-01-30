import 'dart:convert';

import 'package:dakanji_db_core/data/dakanji_db_search_result_sort_order.dart';
import 'package:drift/drift.dart';

/// Converter for: List<(DakanjiDbSearchResult1stSortOrder, bool)>
class FirstSortOrderConverter extends TypeConverter<List<(DakanjiDbSearchResult1stSortOrder, bool)>, String> {
  const FirstSortOrderConverter();

  @override
  String toSql(List<(DakanjiDbSearchResult1stSortOrder, bool)> value) {
    // Convert Record into a simple List: [enumIndex, bool]
    final serializable = value.map((e) => [e.$1.index, e.$2]).toList();
    return json.encode(serializable);
  }

  @override
  List<(DakanjiDbSearchResult1stSortOrder, bool)> fromSql(String fromDb) {
    final decoded = json.decode(fromDb) as List<dynamic>;
    return decoded.map((e) {
      final list = e as List<dynamic>;
      return (
        DakanjiDbSearchResult1stSortOrder.values[list[0] as int],
        list[1] as bool
      );
    }).toList();
  }
}

/// Converter for: List<(DakanjiDbSearchResult2ndSortOrder, bool)>
class SecondSortOrderConverter extends TypeConverter<List<(DakanjiDbSearchResult2ndSortOrder, bool)>, String> {
  const SecondSortOrderConverter();

  @override
  String toSql(List<(DakanjiDbSearchResult2ndSortOrder, bool)> value) {
    final serializable = value.map((e) => [e.$1.index, e.$2]).toList();
    return json.encode(serializable);
  }

  @override
  List<(DakanjiDbSearchResult2ndSortOrder, bool)> fromSql(String fromDb) {
    final decoded = json.decode(fromDb) as List<dynamic>;
    return decoded.map((e) {
      final list = e as List<dynamic>;
      return (
        DakanjiDbSearchResult2ndSortOrder.values[list[0] as int],
        list[1] as bool
      );
    }).toList();
  }
}
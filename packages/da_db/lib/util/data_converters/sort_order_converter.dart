import 'dart:convert';

import 'package:da_db/data/search_result_sort_order.dart';
import 'package:drift/drift.dart';

/// Converter for: List<(DakanjiDbSearchResult1stSortOrder, bool)>
class FirstSortOrderConverter extends TypeConverter<List<(SearchResult1stSortOrder, bool)>, String> {
  const FirstSortOrderConverter();

  @override
  String toSql(List<(SearchResult1stSortOrder, bool)> value) {
    // Convert Record into a simple List: [enumIndex, bool]
    final serializable = value.map((e) => [e.$1.index, e.$2]).toList();
    return json.encode(serializable);
  }

  @override
  List<(SearchResult1stSortOrder, bool)> fromSql(String fromDb) {
    final decoded = json.decode(fromDb) as List<dynamic>;
    return decoded.map((e) {
      final list = e as List<dynamic>;
      return (
        SearchResult1stSortOrder.values[list[0] as int],
        list[1] as bool
      );
    }).toList();
  }
}

/// Converter for: List<(DakanjiDbSearchResult2ndSortOrder, bool)>
class SecondSortOrderConverter extends TypeConverter<List<(SearchResult2ndSortOrder, bool)>, String> {
  const SecondSortOrderConverter();

  @override
  String toSql(List<(SearchResult2ndSortOrder, bool)> value) {
    final serializable = value.map((e) => [e.$1.index, e.$2]).toList();
    return json.encode(serializable);
  }

  @override
  List<(SearchResult2ndSortOrder, bool)> fromSql(String fromDb) {
    final decoded = json.decode(fromDb) as List<dynamic>;
    return decoded.map((e) {
      final list = e as List<dynamic>;
      return (
        SearchResult2ndSortOrder.values[list[0] as int],
        list[1] as bool
      );
    }).toList();
  }
}
// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dojg_search_provider.g.dart';



/// Riverpod provider that stores information about the DoJG search
@riverpod
class DojgSearch extends _$DojgSearch{

  @override
  String build() => "";

  void setCurrentSearchTerm(String newSearchTerm){
    state = newSearchTerm;
  }

}

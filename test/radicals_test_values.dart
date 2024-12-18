import 'package:tuple/tuple.dart';

/// List of kanjis of which the radicals should be looked up and the expected
/// result
List<Tuple2<String, List<String>>> radicalLookuptests = [
  Tuple2("丂", ["一", "勹"]),
  Tuple2("漢", ["⺡", "⺾", "口", "一", "大", "二"]),
  Tuple2("鬱", ["缶", "木", "冖", "凵", "匕", "彡", "鬯"]),
  Tuple2("暚", ["凵", "山", "日", "曰", "爪", "缶"]),
];

/// List of radicals of which kanjis that use those should be looked up
List<Tuple2<List<String>, dynamic>> kanjiLookuptests = [
  Tuple2(["一"], 2713),
  Tuple2(["一", "勹"], 111),
  Tuple2(["⺡", "⺾", "口", "一", "大", "二"], "漢"),
  Tuple2(["缶", "木", "冖", "凵", "匕", "彡", "鬯"], "鬱"),
  Tuple2(["凵", "山", "日", "曰", "爪", "缶"], "暚"),
];
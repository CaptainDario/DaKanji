import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';



class LogicalKeyboardKeyConverter
  implements JsonConverter<LogicalKeyboardKey, int> {
    
  const LogicalKeyboardKeyConverter();

  @override
  LogicalKeyboardKey fromJson(int json) 
    => LogicalKeyboardKey.findKeyByKeyId(json)!;

  @override
  int toJson(LogicalKeyboardKey object) => object.keyId;
}
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class ColorIntConverter implements JsonConverter<Color, int> {
  const ColorIntConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color object) => object.toARGB32();
}
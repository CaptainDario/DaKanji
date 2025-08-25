// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Version _$VersionFromJson(Map<String, dynamic> json) => Version(
  (json['major'] as num?)?.toInt() ?? 0,
  (json['minor'] as num?)?.toInt() ?? 0,
  (json['patch'] as num?)?.toInt() ?? 0,
  build: (json['build'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$VersionToJson(Version instance) => <String, dynamic>{
  'major': instance.major,
  'minor': instance.minor,
  'patch': instance.patch,
  'build': instance.build,
};

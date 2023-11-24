// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Version _$VersionFromJson(Map<String, dynamic> json) => Version(
      json['major'] as int? ?? 0,
      json['minor'] as int? ?? 0,
      json['patch'] as int? ?? 0,
      build: json['build'] as int? ?? 0,
    );

Map<String, dynamic> _$VersionToJson(Version instance) => <String, dynamic>{
      'major': instance.major,
      'minor': instance.minor,
      'patch': instance.patch,
      'build': instance.build,
    };

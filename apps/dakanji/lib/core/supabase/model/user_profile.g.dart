// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
  avatarColor: json['avatarColor'] == null
      ? g_color_scheme_red
      : const ColorIntConverter().fromJson(
          (json['avatarColor'] as num).toInt(),
        ),
  avatarCharacter: json['avatarCharacter'] as String? ?? "?",
  avatarCharacterColor: json['avatarCharacterColor'] == null
      ? Colors.white
      : const ColorIntConverter().fromJson(
          (json['avatarCharacterColor'] as num).toInt(),
        ),
  username: json['username'] as String? ?? "?",
  sponsorships: json['sponsorships'] == null
      ? null
      : Sponsorships.fromJson(json['sponsorships'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'avatarColor': const ColorIntConverter().toJson(instance.avatarColor),
      'avatarCharacter': instance.avatarCharacter,
      'avatarCharacterColor': const ColorIntConverter().toJson(
        instance.avatarCharacterColor,
      ),
      'username': instance.username,
      'sponsorships': instance.sponsorships,
    };

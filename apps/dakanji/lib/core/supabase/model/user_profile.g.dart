// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
  avatarColor: json['avatarColor'] == null
      ? Colors.white
      : const ColorIntConverter().fromJson(
          (json['avatarColor'] as num).toInt(),
        ),
  avatarCharacter: json['avatarCharacter'] as String? ?? "?",
  username: json['username'] as String? ?? "Anonymous",
  isGithubConnected: json['isGithubConnected'] as bool? ?? false,
  isGithubSponsor: json['isGithubSponsor'] as bool? ?? false,
  githubSponsorTier: json['githubSponsorTier'] as String?,
);

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'avatarColor': const ColorIntConverter().toJson(instance.avatarColor),
      'avatarCharacter': instance.avatarCharacter,
      'username': instance.username,
      'isGithubConnected': instance.isGithubConnected,
      'isGithubSponsor': instance.isGithubSponsor,
      'githubSponsorTier': instance.githubSponsorTier,
    };

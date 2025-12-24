// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsorships.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sponsorships _$SponsorshipsFromJson(Map<String, dynamic> json) => Sponsorships(
  isGithubConnected: json['isGithubConnected'] as bool? ?? false,
  isGithubSponsor: json['isGithubSponsor'] as bool? ?? false,
  githubSponsorTier: json['githubSponsorTier'] as String?,
  isPatreonConnected: json['isPatreonConnected'] as bool? ?? false,
  isPatreonSponsor: json['isPatreonSponsor'] as bool? ?? false,
  patreonSponsorTier: json['patreonSponsorTier'] as String?,
);

Map<String, dynamic> _$SponsorshipsToJson(Sponsorships instance) =>
    <String, dynamic>{
      'isGithubConnected': instance.isGithubConnected,
      'isGithubSponsor': instance.isGithubSponsor,
      'githubSponsorTier': instance.githubSponsorTier,
      'isPatreonConnected': instance.isPatreonConnected,
      'isPatreonSponsor': instance.isPatreonSponsor,
      'patreonSponsorTier': instance.patreonSponsorTier,
    };

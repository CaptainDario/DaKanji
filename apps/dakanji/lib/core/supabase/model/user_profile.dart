import 'package:da_kanji_mobile/core/utils/json_utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'user_profile.g.dart';



@JsonSerializable(converters: [ColorIntConverter()])
class UserProfile extends ChangeNotifier {

  // 1. Private backing fields
  int _avatarColor;
  String _avatarCharacter;
  String _username;
  bool _isGithubConnected;
  bool _isGithubSponsor;
  String? _githubSponsorTier;

  UserProfile({
    Color avatarColor = Colors.white,
    String avatarCharacter = "?",
    String username = "?",
    bool isGithubConnected = false,
    bool isGithubSponsor = false,
    String? githubSponsorTier,
  })  : 
    _avatarColor = avatarColor.toARGB32(),
    _avatarCharacter = avatarCharacter,
    _username = username,
    _isGithubConnected = isGithubConnected,
    _isGithubSponsor = isGithubSponsor,
    _githubSponsorTier = githubSponsorTier;

  /// --- GETTERS & SETTERS ----------------------------------------------------

  Color get avatarColor => Color.fromRGBO(
    (_avatarColor >> 16) & 0xFF,
    (_avatarColor >> 8) & 0xFF,
    _avatarColor & 0xFF,
    1.0,
  );
  set avatarColor(Color value) {
    if (_avatarColor != value.toARGB32()) {
      _avatarColor = value.toARGB32();
      notifyListeners(); 
    }
  }

  String get avatarCharacter => _avatarCharacter;
  set avatarCharacter(String value) {
    if (_avatarCharacter != value) {
      _avatarCharacter = value;
      notifyListeners();
    }
  }

  String get username => _username;
  set username(String value) {
    if (_username != value) {
      _username = value;
      notifyListeners();
    }
  }

  bool get isGithubConnected => _isGithubConnected;
  set isGithubConnected(bool value) {
    if (_isGithubConnected != value) {
      _isGithubConnected = value;
      notifyListeners();
    }
  }

  bool get isGithubSponsor => _isGithubSponsor;
  set isGithubSponsor(bool value) {
    if (_isGithubSponsor != value) {
      _isGithubSponsor = value;
      notifyListeners();
    }
  }

  String? get githubSponsorTier => _githubSponsorTier;
  set githubSponsorTier(String value) {
    if (_githubSponsorTier != value) {
      _githubSponsorTier = value;
      notifyListeners();
    }
  }

  /// --- JSON BOILERPLATE -----------------------------------------------------

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
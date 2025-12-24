import 'package:da_kanji_mobile/core/supabase/model/sponsorships.dart';
import 'package:da_kanji_mobile/core/utils/json_utils.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'user_profile.g.dart';



@JsonSerializable(converters: [ColorIntConverter()])
class UserProfile extends ChangeNotifier {

  // 1. Private backing fields
  int _avatarColor;
  String _avatarCharacter;
  int _avatarCharacterColor;
  String _username;

  Sponsorships _sponsorships;

  UserProfile({
    Color avatarColor = g_Dakanji_red,
    String avatarCharacter = "?",
    Color avatarCharacterColor = Colors.white,
    String username = "?",
    Sponsorships? sponsorships,
  })  : 
    _avatarColor = avatarColor.toARGB32(),
    _avatarCharacter = avatarCharacter,
    _avatarCharacterColor = avatarCharacterColor.toARGB32(),
    _username = username,
    
    _sponsorships = sponsorships ?? Sponsorships(){
    
      _sponsorships.addListener(() {
        notifyListeners();
      });
    
    }

  /// --- GETTERS & SETTERS ----------------------------------------------------

  Color get avatarColor => Color(_avatarColor);
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

  Color get avatarCharacterColor => Color(_avatarCharacterColor);
  set avatarCharacterColor(Color value) {
    if (_avatarCharacterColor != value.toARGB32()) {
      _avatarCharacterColor = value.toARGB32();
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

  Sponsorships get sponsorships => _sponsorships;
  set sponsorships(Sponsorships value) {
    _sponsorships = value;
    notifyListeners();
  }

  /// --- JSON BOILERPLATE -----------------------------------------------------

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
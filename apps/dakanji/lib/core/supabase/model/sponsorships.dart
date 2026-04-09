import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sponsorships.g.dart';



@JsonSerializable()
class Sponsorships extends ChangeNotifier {

  bool _isGithubConnected;
  bool _isGithubSponsor;
  String? _githubSponsorTier;

  bool _isPatreonConnected;
  bool _isPatreonSponsor;
  String? _patreonSponsorTier;

  Sponsorships({

    bool isGithubConnected = false,
    bool isGithubSponsor = false,
    String? githubSponsorTier,

    bool isPatreonConnected = false,
    bool isPatreonSponsor = false,
    String? patreonSponsorTier,
  })  : 
    
    _isGithubConnected = isGithubConnected,
    _isGithubSponsor = isGithubSponsor,
    _githubSponsorTier = githubSponsorTier,
    
    _isPatreonConnected = isPatreonConnected,
    _isPatreonSponsor = isPatreonSponsor,
    _patreonSponsorTier = patreonSponsorTier;

  /// --- GETTERS & SETTERS ----------------------------------------------------

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

  bool get isPatreonConnected => _isPatreonConnected;
  set isPatreonConnected(bool value) {
    if (_isPatreonConnected != value) {
      _isPatreonConnected = value;
      notifyListeners();
    }
  }

  bool get isPatreonSponsor => _isPatreonSponsor;
  set isPatreonSponsor(bool value) {
    if (_isPatreonSponsor != value) {
      _isPatreonSponsor = value;
      notifyListeners();
    }
  }

  String? get patreonSponsorTier => _patreonSponsorTier;
  set patreonSponsorTier(String value) {
    if (_patreonSponsorTier != value) {
      _patreonSponsorTier = value;
      notifyListeners();
    }
  }

  /// --- JSON BOILERPLATE -----------------------------------------------------

  factory Sponsorships.fromJson(Map<String, dynamic> json) => _$SponsorshipsFromJson(json);

  Map<String, dynamic> toJson() => _$SponsorshipsToJson(this);
}
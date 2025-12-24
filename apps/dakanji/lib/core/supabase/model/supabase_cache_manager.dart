import 'dart:convert';
import 'package:da_kanji_mobile/core/supabase/controller/supabase_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:da_kanji_mobile/core/supabase/model/user_profile.dart';

class SupabaseCacheManager with ChangeNotifier {
  // Keys for Secure Storage
  static const String _profileKey = 'supabase_cache';
  static const String _licenseKey = 'supabase_license_jwt';

  final _storage = const FlutterSecureStorage();

  UserProfile _userProfile;

  UserProfile get userProfile => _userProfile;

  // Standard setter for normal profile updates (Name, Settings, etc.)
  set userProfile(UserProfile value) {
    _userProfile = value;
    _saveProfileToCache();
    notifyListeners();
  }

  SupabaseCacheManager() : _userProfile = UserProfile() {
    _init();
  }

  /// Master Init: Loads Profile JSON + License JWT
  Future<void> _init() async {
    await _loadProfileFromCache();
    await _applyLicenseFromCache(); // Overwrites sponsorship fields with trusted data
  }

  /// --------------------------------------------------------------------------
  /// PUBLIC API (Called by your OAuth Service)
  /// --------------------------------------------------------------------------

  /// Call this when the Edge Function returns a new JWT License
  Future<void> updateFromLicense(String jwtToken) async {
    try {
      // 1. Verify/Decode the token immediately
      final jwt = JWT.decode(jwtToken);
      
      // 2. Save the trusted license to Secure Storage
      await _storage.write(key: _licenseKey, value: jwtToken);
      
      // 3. Update the in-memory UserProfile
      _updateProfileFromJwtPayload(jwt.payload);
      
      // 4. Save the updated Profile JSON as well (so UI stays in sync)
      await _saveProfileToCache();
      
      notifyListeners();
    } catch (e) {
      debugPrint("Invalid License Token: $e");
    }
  }

  /// Calls external function to push current state to Supabase
  Future<void> updateUser(BuildContext context) async {
    // Note: You might want to prevent uploading 'isSponsor' fields 
    // if your RLS policies block it anyway.
    await supabaseUpdateProfile(_userProfile, context);
  }

  /// --------------------------------------------------------------------------
  /// INTERNAL STORAGE LOGIC
  /// --------------------------------------------------------------------------

  Future<void> _saveProfileToCache() async {
    try {
      final jsonString = jsonEncode(_userProfile.toJson());
      await _storage.write(key: _profileKey, value: jsonString);
    } catch (e) {
      debugPrint("Failed to save profile cache: $e");
    }
  }

  Future<void> _loadProfileFromCache() async {
    try {
      final jsonString = await _storage.read(key: _profileKey);
      if (jsonString != null) {
        final jsonMap = jsonDecode(jsonString);
        _userProfile = UserProfile.fromJson(jsonMap);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Failed to load profile cache: $e");
    }
  }

  /// Loads the signed JWT and enforces its values onto the UserProfile
  Future<void> _applyLicenseFromCache() async {
    try {
      final token = await _storage.read(key: _licenseKey);
      if (token == null) return;

      final jwt = JWT.decode(token);
      
      // Optional: Check Expiry
      if (jwt.payload['exp'] != null) {
        final expiry = DateTime.fromMillisecondsSinceEpoch(jwt.payload['exp'] * 1000);
        if (DateTime.now().isAfter(expiry)) {
          debugPrint("License Expired");
          // Optionally clear the license or set isSponsor = false
          return;
        }
      }

      // Apply trusted values
      _updateProfileFromJwtPayload(jwt.payload);
      notifyListeners();
      
    } catch (e) {
      debugPrint("Failed to load license: $e");
    }
  }

  /// Helper to map JWT fields to UserProfile fields
  void _updateProfileFromJwtPayload(Map<String, dynamic> payload) {
    // Modify these keys based on exactly what your Edge Function sends
    // Assuming UserProfile has a 'sponsorships' object or flat fields:
    
    if (payload.containsKey('is_github_sponsor')) {
       _userProfile.sponsorships.isGithubSponsor = payload['is_github_sponsor'];
       _userProfile.sponsorships.isGithubConnected = true; 
    }
    
    if (payload.containsKey('is_patreon_sponsor')) {
       _userProfile.sponsorships.isPatreonSponsor = payload['is_patreon_sponsor'];
       _userProfile.sponsorships.isPatreonConnected = true;
    }
    
    // If you send tiers in the JWT:
    if (payload['github_tier'] != null) {
       _userProfile.sponsorships.githubSponsorTier = payload['github_tier'];
    }
  }
}
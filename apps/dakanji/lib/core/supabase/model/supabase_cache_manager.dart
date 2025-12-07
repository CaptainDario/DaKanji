import 'dart:convert';
import 'package:da_kanji_mobile/core/supabase/controller/supabase_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:da_kanji_mobile/core/supabase/model/user_profile.dart';



/// Manages caching of Supabase-related data locally
class SupabaseCacheManager with ChangeNotifier {
  static const String _storageKey = 'supabase_cache';

  UserProfile _userProfile;

  UserProfile get userProfile => _userProfile;

  set userProfile(UserProfile value) {
    _userProfile = value;
    _saveToCache();
    notifyListeners();
  }

  SupabaseCacheManager() : _userProfile = UserProfile() {
    _loadFromCache();
  }

  /// Calls external function to fetch data and updates local state on success
  Future<void> refreshUser(BuildContext context) async {
    final freshProfile = await supabaseGetProfile(context);
    
    if (freshProfile != null) {
      userProfile = freshProfile;
    }
  }

  /// Calls external function to push current state to Supabase
  Future<void> updateUser(BuildContext context) async {
    await supabaseUpdateProfile(_userProfile, context);
  }

  Future<void> _saveToCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(_userProfile.toJson());
      await prefs.setString(_storageKey, jsonString);
    } catch (_) {
      debugPrint("Failed to save cache.");
    }
  }

  Future<void> _loadFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);

      if (jsonString != null) {
        final jsonMap = jsonDecode(jsonString);
        // Update backing field directly to avoid triggering save logic
        _userProfile = UserProfile.fromJson(jsonMap);
        notifyListeners();
      }
    } catch (_) {
      debugPrint("Failed to load cache.");
    }
  }
}
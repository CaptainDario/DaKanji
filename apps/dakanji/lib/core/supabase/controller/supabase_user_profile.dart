import 'package:da_kanji_mobile/core/supabase/model/supabase_cache_manager.dart';
import 'package:da_kanji_mobile/core/supabase/model/user_profile.dart';
import 'package:da_kanji_mobile/core/utils/snackbar.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



/// Fetches the user profile from Supabase
/// 
/// Notes:
///   * Shows informational SnackBars
///   * Automatically caches the fetched profile on success
Future<UserProfile?> supabaseGetProfile(BuildContext context) async {

  UserProfile? profile;

  try {
    final userId = Supabase.instance.client.auth.currentSession!.user.id;
    final data = await Supabase.instance.client
      .from('profiles')
      .select()
      .eq('id', userId);

    profile = UserProfile.fromJson(data[0]);
    GetIt.I<SupabaseCacheManager>().userProfile = profile;
  }
  on PostgrestException catch (error) {
    debugPrint("PostgrestException fetching profile: ${error.message}");
    if (context.mounted) context.showSnackBar(error.message, isError: true);
  }
  catch (error) {
    debugPrint("Error fetching profile: $error");
    if (context.mounted) {
      context.showSnackBar(
        LocaleKeys.HomeScreen_account_page_generic_error.tr(),
        isError: true
      );
    }
  }

  return profile;
}

/// Updates the user profile in Supabase
/// 
/// Notes:
///   * Shows informational SnackBars
///   * Automatically caches the fetched profile on success
Future<void> supabaseUpdateProfile(UserProfile profile, BuildContext context) async {

  final user = Supabase.instance.client.auth.currentUser;
  final Map<String, dynamic> profileUpdates = {
    'id': user!.id,
    'updated_at': DateTime.now().toIso8601String(),
  }..addAll(profile.toJson());
  profileUpdates.remove("sponsorships");

  try {
    await Supabase.instance.client.from('profiles')
      .update(profileUpdates).eq("id", user.id);
    if (context.mounted) context.showSnackBar(LocaleKeys.HomeScreen_account_page_char_updated_profile.tr());

    GetIt.I<SupabaseCacheManager>().userProfile = profile;
  }
  on PostgrestException catch (error) {
    if (context.mounted) context.showSnackBar(error.message, isError: true);
  }
  catch (error) {
    if (context.mounted) {
      context.showSnackBar(
        LocaleKeys.HomeScreen_account_page_generic_error.tr(),
        isError: true
      );
    }
  }
}
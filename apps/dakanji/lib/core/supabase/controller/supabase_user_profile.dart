import 'package:da_kanji_mobile/core/supabase/model/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:da_kanji_mobile/core/utils/snackbar.dart';



/// Fetches the user profile from Supabase
Future<UserProfile?> supabaseGetProfile(BuildContext context) async {

  UserProfile? profile;

  try {
    final userId = Supabase.instance.client.auth.currentSession!.user.id;
    final data = await Supabase.instance.client
      .from('profiles')
      .select()
      .eq('id', userId)
      .single();

    profile = UserProfile.fromJson(data);

  } on PostgrestException catch (error) {
    if (context.mounted) context.showSnackBar(error.message, isError: true);
  } catch (error) {
    if (context.mounted) {
      context.showSnackBar('Unexpected error occurred', isError: true);
    }
  }

  return profile;
}

/// Updates the user profile in Supabase
Future<void> supabaseUpdateProfile(UserProfile profile, BuildContext context) async {

  final user = Supabase.instance.client.auth.currentUser;
  final Map<String, dynamic> updates = {
    'id': user!.id,
    'updated_at': DateTime.now().toIso8601String(),
  }..addAll(profile.toJson());
  try {
    await Supabase.instance.client.from('profiles').upsert(updates);
    if (context.mounted) context.showSnackBar('Successfully updated profile!');
  } on PostgrestException catch (error) {
    if (context.mounted) context.showSnackBar(error.message, isError: true);
  } catch (error) {
    if (context.mounted) {
      context.showSnackBar('Unexpected error occurred', isError: true);
    }
  }
}
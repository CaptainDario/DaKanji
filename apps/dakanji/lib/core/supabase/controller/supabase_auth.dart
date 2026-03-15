

import 'package:da_kanji_mobile/core/utils/snackbar.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



Future signInWithOp(String email) async {
  await Supabase.instance.client.auth.signInWithOtp(
    email: email.trim(),
    emailRedirectTo: kIsWeb ? null : '${g_AppConfig.appLink}login-callback/',
  );
}

Future<void> completeSignInWithOp(String refreshToken) async {
  try {
    // This exchanges the refresh token for a valid session
    await Supabase.instance.client.auth.setSession(refreshToken);
    
    // Note: The UI will automatically update because UserLoginOrWidget is
    // listening to the auth stream.
  } catch (error) {
    debugPrint("Error recovering session: $error");
  }
}

Future<void> signOut(BuildContext context) async {

  try {
    await Supabase.instance.client.auth.signOut();
  } on AuthException catch (error) {
    if (context.mounted) context.showSnackBar(error.message, isError: true);
  } catch (error) {
    if (context.mounted) {
      context.showSnackBar('Unexpected error occurred', isError: true);
    }
  }

}
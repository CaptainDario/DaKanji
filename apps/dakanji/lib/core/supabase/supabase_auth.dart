

import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future signInWithOp(String email) async {
  await Supabase.instance.client.auth.signInWithOtp(
    email: email.trim(),
    emailRedirectTo: kIsWeb ? null : '${g_AppLinkDaKanji}login-callback/',
  );
}
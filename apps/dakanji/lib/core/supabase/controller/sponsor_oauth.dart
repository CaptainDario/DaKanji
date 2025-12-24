import 'package:da_kanji_mobile/core/supabase/model/supabase_cache_manager.dart';
import 'package:da_kanji_mobile/env.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// 1. Define the supported providers
enum OAuthProvider {
  github,
  patreon;
}

class OAuthLinkerService {
  final SupabaseClient _supabase;
  final SupabaseCacheManager _cacheManager;

  static final _githubClientId = Env.GITHUB_CLIENT_ID;
  static final _patreonClientId = Env.PATREON_CLIENT_ID;
  static final String _callbackUrlScheme = g_AppLinkDaKanji.replaceAll("://", "");

  OAuthLinkerService({
    required SupabaseCacheManager cacheManager,
    SupabaseClient? supabaseClient,
  })  : _cacheManager = cacheManager,
        _supabase = supabaseClient ?? Supabase.instance.client;

  /// Main entry point using the Enum
  Future<void> linkProvider(OAuthProvider provider) async {
    try {
      // 1. Construct the URL
      final url = _constructAuthUrl(provider);

      // 2. Open Browser & Handle Redirect
      final result = await FlutterWebAuth2.authenticate(
        url: url,
        callbackUrlScheme: _callbackUrlScheme,
        options: const FlutterWebAuth2Options(preferEphemeral: true),
      );

      // 3. Parse the Result
      // Expected: dakanji://callback?code=ABC&state=github
      final uri = Uri.parse(result);
      final code = uri.queryParameters['code'];
      final stateString = uri.queryParameters['state'];

      if (code == null) throw Exception("No code returned from provider");

      // Verify state matches what we requested (Security Best Practice)
      if (stateString != provider.name) {
        throw Exception("State mismatch: Expected ${provider.name}, got $stateString");
      }

      // 4. Secure Exchange on Backend
      await _exchangeCodeOnBackend(provider: provider, code: code);

    } catch (e) {
      debugPrint("OAuth Flow Failed: $e");
      // Rethrow if you want the UI to handle the error (e.g. show SnackBar)
      rethrow;
    }
  }

  /// Helper to build the correct URL
  String _constructAuthUrl(OAuthProvider provider) {
    String redirectUri = "$_callbackUrlScheme://callback";

    switch (provider) {
      case OAuthProvider.github:
        return "https://github.com/login/oauth/authorize"
            "?client_id=$_githubClientId"
            "&redirect_uri=$redirectUri"
            "&scope=read:user"
            "&state=${provider.name}";
            
      case OAuthProvider.patreon:
        return "https://www.patreon.com/oauth2/authorize"
            "?response_type=code"
            "&client_id=$_patreonClientId"
            "&redirect_uri=$redirectUri"
            "&scope=identity%20campaigns.members"
            "&state=${provider.name}";
    }
  }

  /// Sends the code to Supabase Edge Function
  Future<void> _exchangeCodeOnBackend({
    required OAuthProvider provider, 
    required String code
  }) async {
    
    final response = await _supabase.functions.invoke(
      'link-oauth-account',
      body: {
        'service': provider.name,
        'code': code,
        'redirectUri': "$_callbackUrlScheme://callback"
      },
    );

    final data = response.data;
    
    if (data != null && data['success'] == true) {
      final String? licenseJwt = data['license'];
      if (licenseJwt != null) {
        await _cacheManager.updateFromLicense(licenseJwt);
        debugPrint("Success: Linked ${provider.name}");
      } else {
        debugPrint("Warning: Link successful but no license returned.");
      }
    } else {
      throw Exception("Backend Exchange Failed: ${data?['error'] ?? 'Unknown Error'}");
    }
  }
}
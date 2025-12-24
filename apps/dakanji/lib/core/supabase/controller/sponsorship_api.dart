import 'package:supabase_flutter/supabase_flutter.dart';

enum SponsorshipService {
  github,
  patreon,
}

class SponsorshipApi {
  final SupabaseClient _supabase;

  SponsorshipApi({SupabaseClient? client}) 
      : _supabase = client ?? Supabase.instance.client;

  /// calls the 'connect-service' Edge Function
  /// Returns a Map containing { success, isSponsor, license }
  Future<Map<String, dynamic>> exchangeCodeForLicense({
    required SponsorshipService serviceName, // 'github' or 'patreon'
    required String code,
    required String redirectUri,
  }) async {
    try {
      final response = await _supabase.functions.invoke(
        'connect-service',
        body: {
          'service': serviceName.name,
          'code': code,
          'redirectUri': redirectUri,
        },
      );

      final data = response.data;
      if (data == null || data['error'] != null) {
        throw Exception(data?['error'] ?? "Unknown Error from Edge Function");
      }

      return data;
    } catch (e) {
      throw Exception('Failed to link account: $e');
    }
  }
}
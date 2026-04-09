import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';



Future<void> clearSupabaseStorage() async {
  await clearSupabaseSecureStorage();
  await clearSupabaseLocalStorage();
}

Future<void> clearSupabaseSecureStorage() async {
  // 1. Initialize the secure storage
  const storage = FlutterSecureStorage();

  // 2. Read all keys to find the Supabase one
  final allKeys = await storage.readAll();

  for (final key in allKeys.keys) {
    // 3. Check for the standard Supabase prefix
    if (key.startsWith('sb-')) {
      await storage.delete(key: key);
      print('Deleted Secure Supabase key: $key');
    }
  }
}


Future<void> clearSupabaseLocalStorage() async {
  final prefs = await SharedPreferences.getInstance();
  
  // Get all keys currently stored
  final keys = prefs.getKeys();

  // Iterate and look for Supabase specific keys
  for (final key in keys) {
    // Supabase keys default to starting with 'sb-'
    // and usually end with '-auth-token'
    if (key.startsWith('sb-')) {
      await prefs.remove(key);
      print('Deleted Supabase key: $key');
    }
  }
}
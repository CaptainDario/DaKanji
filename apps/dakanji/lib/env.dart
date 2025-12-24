// lib/env/env.dart
// ignore_for_file: non_constant_identifier_names
// To update the toJson code run `flutter pub run build_runner build --delete-conflicting-outputs`

// Package imports:
import 'package:envied/envied.dart';

part 'env.g.dart';



@Envied(path: 'dakanji.env', obfuscate: true, allowOptionalFields: true)
abstract class Env {

    @EnviedField(varName: 'SENTRY_DSN', defaultValue: "", obfuscate: true)
    static String? SENTRY_DSN = _Env.SENTRY_DSN;


    @EnviedField(varName: 'POSTHOG_API_KEY_DEV', defaultValue: "", obfuscate: true)
    static String? POSTHOG_API_KEY_DEV = _Env.POSTHOG_API_KEY_DEV;
    @EnviedField(varName: 'POSTHOG_API_KEY_REL', defaultValue: "", obfuscate: true)
    static String? POSTHOG_API_KEY_REL = _Env.POSTHOG_API_KEY_REL;


    @EnviedField(varName: 'SUPABASE_URL', defaultValue: "", obfuscate: true)
    static String SUPABASE_URL = _Env.SUPABASE_URL;
    @EnviedField(varName: 'SUPABASE_PUBLISHABLE_KEY', defaultValue: "", obfuscate: true)
    static String SUPABASE_PUBLISHABLE_KEY = _Env.SUPABASE_PUBLISHABLE_KEY;

    @EnviedField(varName: 'GITHUB_CLIENT_ID', defaultValue: "", obfuscate: true)
    static String GITHUB_CLIENT_ID = _Env.GITHUB_CLIENT_ID;
    @EnviedField(varName: 'PATREON_CLIENT_ID', defaultValue: "", obfuscate: true)
    static String PATREON_CLIENT_ID = _Env.PATREON_CLIENT_ID;
}

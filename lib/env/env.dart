// lib/env/env.dart
// ignore_for_file: non_constant_identifier_names
/// To update the toJson code run `flutter pub run build_runner build --delete-conflicting-outputs`

// Package imports:
import 'package:envied/envied.dart';

part 'env.g.dart';



@Envied(path: 'dakanji.env', obfuscate: true, allowOptionalFields: true)
abstract class Env {

    @EnviedField(varName: 'SENTRY_DSN', defaultValue: "", obfuscate: true)
    static String? SENTRY_DSN = _Env.SENTRY_DSN;

    @EnviedField(varName: 'FIREBASE_ANALYTICS_WIN_STREAM_ID', defaultValue: "", obfuscate: true)
    static String? FIREBASE_ANALYTICS_WIN_STREAM_ID = _Env.FIREBASE_ANALYTICS_WIN_STREAM_ID;
    @EnviedField(varName: 'FIREBASE_ANALYTICS_WIN_MEASURMENT_ID', defaultValue: "", obfuscate: true)
    static String? FIREBASE_ANALYTICS_WIN_MEASURMENT_ID = _Env.FIREBASE_ANALYTICS_WIN_MEASURMENT_ID;

    @EnviedField(varName: 'FIREBASE_ANALYTICS_LIN_STREAM_ID', defaultValue: "", obfuscate: true)
    static String? FIREBASE_ANALYTICS_LIN_STREAM_ID = _Env.FIREBASE_ANALYTICS_LIN_STREAM_ID;
    @EnviedField(varName: 'FIREBASE_ANALYTICS_LIN_MEASURMENT_ID', defaultValue: "", obfuscate: true)
    static String? FIREBASE_ANALYTICS_LIN_MEASURMENT_ID = _Env.FIREBASE_ANALYTICS_LIN_MEASURMENT_ID;
}

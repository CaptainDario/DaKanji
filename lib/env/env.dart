// lib/env/env.dart
// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:envied/envied.dart';

part 'env.g.dart';



@Envied(path: 'dakanji.env', obfuscate: true, allowOptionalFields: true)
abstract class Env {
    @EnviedField(varName: 'SENTRY_DSN', defaultValue: "")
    static String? SENTRY_DSN = _Env.SENTRY_DSN;
}

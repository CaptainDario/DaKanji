/// This is copied from Cargokit (which is the official way to use it currently)
/// Details: https://fzyzcjy.github.io/flutter_rust_bridge/manual/integrate/builtin
library;

import 'dart:io';

import 'package:build_tool/src/artifacts_provider.dart';
import 'package:build_tool/src/builder.dart';
import 'package:build_tool/src/environment.dart';
import 'package:build_tool/src/options.dart';
import 'package:build_tool/src/target.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

final log = Logger('build_gradle');

class BuildGradle {
  BuildGradle({required this.userOptions});

  final CargokitUserOptions userOptions;

  Future<void> build() async {
    final targets = Environment.targetPlatforms.map((arch) {
      final target = Target.forFlutterName(arch);
      if (target == null) {
        throw Exception(
            "Unknown darwin target or platform: $arch, ${Environment.darwinPlatformName}");
      }
      return target;
    }).toList();

    final environment = BuildEnvironment.fromEnvironment(isAndroid: true);
    final provider =
        ArtifactProvider(environment: environment, userOptions: userOptions);
    final artifacts = await provider.getArtifacts(targets);

    for (final target in targets) {
      final libs = artifacts[target]!;
      final outputDir = path.join(Environment.outputDir, target.android!);
      Directory(outputDir).createSync(recursive: true);

      for (final lib in libs) {
        if (lib.type == AritifactType.dylib) {
          File(lib.path).copySync(path.join(outputDir, lib.finalFileName));
        }
      }
    }
  }
}

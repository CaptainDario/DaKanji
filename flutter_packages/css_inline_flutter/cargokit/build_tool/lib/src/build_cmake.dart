/// This is copied from Cargokit (which is the official way to use it currently)
/// Details: https://fzyzcjy.github.io/flutter_rust_bridge/manual/integrate/builtin
library;

import 'dart:io';

import 'package:build_tool/src/artifacts_provider.dart';
import 'package:build_tool/src/builder.dart';
import 'package:build_tool/src/environment.dart';
import 'package:build_tool/src/options.dart';
import 'package:build_tool/src/target.dart';
import 'package:path/path.dart' as path;

class BuildCMake {
  final CargokitUserOptions userOptions;

  BuildCMake({required this.userOptions});

  Future<void> build() async {
    final targetPlatform = Environment.targetPlatform;
    final target = Target.forFlutterName(Environment.targetPlatform);
    if (target == null) {
      throw Exception("Unknown target platform: $targetPlatform");
    }

    final environment = BuildEnvironment.fromEnvironment(isAndroid: false);
    final provider =
        ArtifactProvider(environment: environment, userOptions: userOptions);
    final artifacts = await provider.getArtifacts([target]);

    final libs = artifacts[target]!;

    for (final lib in libs) {
      if (lib.type == AritifactType.dylib) {
        File(lib.path)
            .copySync(path.join(Environment.outputDir, lib.finalFileName));
      }
    }
  }
}

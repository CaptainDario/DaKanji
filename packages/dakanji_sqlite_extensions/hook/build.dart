import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:path/path.dart' as p;


List<String> extensionNames = [
  //"spellfix", "crsqlite", "compress",
  "vector", 
];

void main(List<String> args) async {
  
  await build(args, (input, output) async {

    String dylibExtension = getDylibExtension(input.config.code.targetOS);
    String platformName = getPlatformName(input.config.code.targetOS);
    String cpuArchitecture = getCpuArchitecture(input.config.code.targetArchitecture);

    // Add the code asset to the build output.
    for (var extensionName in extensionNames) {
      output.assets.code.add(
        // "package:dakanji_db_core/
        CodeAsset(
          package: input.packageName,
          name: 'extensions/sqlite_${extensionName}_extension.dart',
          linkMode: DynamicLoadingBundled(),
          file: Uri.parse(
            p.join(
              input.packageRoot.toFilePath(),
              'dynamic_libraries',
              platformName,
              '${extensionName}_${platformName}_$cpuArchitecture.$dylibExtension'
            )
          )
        ),
      ); 
    }
    
  });
}

String getPlatformName(OS targetOS) {

  switch (targetOS) {
    case OS.macOS:
      return "mac";
    case OS.linux:
      return "linux";
    case OS.windows:
      return "windows";
    case OS.android:
      return "android";
    case OS.iOS:
      return "ios";
    default:
      throw UnsupportedError('Unsupported platform: $targetOS');
  }
}

String getDylibExtension(OS targetOS) {

  switch (targetOS) {
    case OS.macOS:
    case OS.iOS:
      return "dylib";
    case OS.linux:
    case OS.android:
      return "so";
    case OS.windows:
      return "dll";
    default:
      throw UnsupportedError('Unsupported platform: $targetOS');
  }

}

String getCpuArchitecture(Architecture targetArchitecture) {
  switch (targetArchitecture) {
    case Architecture.x64:
      return "x64";
    case Architecture.arm64:
      return "arm64";
    case Architecture.arm:
      return "arm";

    default:
      throw UnsupportedError('Unsupported architecture: $targetArchitecture');
  }
}
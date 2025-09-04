import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';


List<String> extensionNames = [
  "vec", "spellfix", "crsqlite"
];

void main(List<String> args) async {
  
  await build(args, (input, output) async {

    String extensionPath = "/Users/darioklepoch/dev/DaKanji/dakanji_db/packages/dakanji_db_core/hook/";
    String dylibExtension = getDylibExtension();
    String platformName = getPlatformName();
    String cpuArchitecture = getCpuArchitecture();

    // Add the code asset to the build output.
    for (var extensionName in extensionNames) {
      output.assets.code.add(
        // "package:dakanji_db_core/
        CodeAsset(
          package: input.packageName,
          name: 'extensions/sqlite_${extensionName}_extension.dart',
          linkMode: DynamicLoadingBundled(),
          file: Uri.parse(p.join(extensionPath, '${extensionName}_${platformName}_$cpuArchitecture.$dylibExtension'))
        )
      ); 
    }
    
  });
}

String getPlatformName() {
  if (Platform.isMacOS) {
    return "mac";
  } else if (Platform.isLinux) {
    return "linux";
  } else if (Platform.isWindows) {
    return "windows";
  } else {
    throw UnsupportedError('Unsupported platform: ${Platform.operatingSystem}');
  }
}

String getDylibExtension() {
  if (Platform.isMacOS) {
    return "dylib";
  } else if (Platform.isLinux) {
    return "so";
  } else if (Platform.isWindows) {
    return "dll";
  } else {
    throw UnsupportedError('Unsupported platform: ${Platform.operatingSystem}');
  }
}

String getCpuArchitecture() {
  switch (Architecture.current) {
    case Architecture.x64:
      return "x64";
    case Architecture.arm64:
      return "arm";
    default:
      throw UnsupportedError('Unsupported architecture: ${Platform.operatingSystem}');
  }
}
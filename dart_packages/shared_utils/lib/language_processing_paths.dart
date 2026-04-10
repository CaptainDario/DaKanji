import 'package:path/path.dart' as p;

import 'package:shared_utils/root_path.dart';



/// path to the language processing package root
final String languageProcessingRootPath = p.join(monoRepoRoot, "dart_packages", "language_processing");



/// --- TEST PATHS -------------------------------------------------------------
/// path to the language processing test folder
final String languageProcessingTestsPath = p.join(languageProcessingRootPath, "test");


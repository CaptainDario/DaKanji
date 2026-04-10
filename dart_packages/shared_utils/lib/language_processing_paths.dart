import 'package:path/path.dart' as p;

import 'root_path.dart';




/// path to the language processing package root
final String languageProcessingRootPath = p.join(monoRepoRoot, "dart_packages", "language_processing");
/// path to the language processing test folder
final String languageProcessingTestsPath = p.join(languageProcessingRootPath, "language_processing_test");
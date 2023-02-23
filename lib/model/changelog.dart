import 'package:flutter/services.dart';



/// Class to handle reading and storing the CHANGELOG.md
class Changelog{

  /// the changelog read from CHANGELOG.md
  late String _changelog;
  /// only the newest section from CHANGELOG.md
  late String _newestChangelog;
  /// the complete changelog without the first few header lines
  late String _wholeChangelog;
  /// if this object was initialized
  bool _initialized = false;

  String get changelog{
    if(!_initialized) {
      throw(Exception(
        "You are trying to use the object before initializing it.\n"
        "Try calling init() first."
      ));
    }

    return _changelog;
  }
  
  String get newestChangelog{
    if(!_initialized) {
      throw(Exception(
        "You are trying to use the object before initializing it.\n"
        "Try calling init() first."
      ));
    }

    return _newestChangelog;
  }
  
  String get wholeChangelog{
    if(!_initialized) {
      throw(Exception(
        "You are trying to use the object before initializing it.\n"
        "Try calling init() first."
      ));
    }

    return _wholeChangelog;
  }


  Changelog();

  /// Reads `CHANGELOG.md` from file and returns a converted version.
  /// 
  /// First reads the changelog from file and than returns a list with the  
  /// changes in the current version and the whole changelog.
  Future<void> init() async {

    _changelog = await rootBundle.loadString("CHANGELOG.md");
    // whole changelog
    List<String> changelogList = _changelog.split("\n");
    changelogList.removeRange(0, 3);
    _wholeChangelog = changelogList.join("\n");
    // newest changes
    final matches = RegExp(r"(##.*?##)", dotAll: true);
    _newestChangelog = matches.firstMatch(_changelog)!.group(0).toString();
    _newestChangelog = _newestChangelog.substring(0, _newestChangelog.length - 2);

    _initialized = true;
  }

}
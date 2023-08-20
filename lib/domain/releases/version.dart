import 'package:json_annotation/json_annotation.dart';
import 'package:tuple/tuple.dart';

part 'version.g.dart';



/// Represents a version in the format major.minor.patch
@JsonSerializable(checked: false)
class Version implements Comparable<Version>{

  /// Major part of this version
  @JsonKey(defaultValue: 0)
  int major = 0;
  /// Minor part of this version
  @JsonKey(defaultValue: 0)
  int minor = 0;
  /// Patch part of this version
  @JsonKey(defaultValue: 0)
  int patch = 0;
  /// Build part of this version
  @JsonKey(defaultValue: 0)
  int? build = 0;
  /// The full version (includes build) as string
  String get fullVersionString => "$major.$minor.$patch${build != null ? "+$build" : ""}";
  /// The full version (includes build) as tuple
  Tuple4<int, int, int, int?> get fullVersionTuple => Tuple4(major, minor, patch, build);
  /// The full version as string
  String get versionString => "$major.$minor.$patch";
  /// The full version as tuple
  Tuple3<int, int, int> get versionTuple => Tuple3(major, minor, patch);


  Version(this.major, this.minor, this.patch, {this.build});

  Version.fromStringFull(String version){
    var split = version.split(".");
    split.addAll(split[2].split("+"));
    split.removeAt(2);
    if(split.length != 4){
      throw Exception("Version string is not valid");
    }
    major = int.parse(split[0]);
    minor = int.parse(split[1]);
    patch = int.parse(split[2]);
    build = int.parse(split[3]);
  }

  Version.fromString(String version){
    var split = version.split(".");
    if(split.length != 3){
      throw Exception("Version string is not valid");
    }
    major = int.parse(split[0]);
    minor = int.parse(split[1]);
    patch = int.parse(split[2]);
    build = null;
  }

  @override
  String toString() {
    return versionString;
  }

  /// Returns the full version as string (includes build number)
  String toStringFull() {
    return fullVersionString;
  }

  List<int> toListFull(){
    return [major, minor, patch, build ?? -1];
  }

  List<int> toList(){
    return [major, minor, patch];
  }

  bool operator >(Version other){
    if(major > other.major){
      return true;
    }
    else if(major == other.major){
      if(minor > other.minor){
        return true;
      }
      else if(minor == other.minor){
        if(patch > other.patch){
          return true;
        }
        else if(patch == other.patch){
          if(build != null && other.build != null && build! > other.build!){
            return true;
          }
        }
      }
    }
    return false;
  }

  bool operator <(Version other){
    if(major < other.major){
      return true;
    }
    else if(major == other.major){
      if(minor < other.minor){
        return true;
      }
      else if(minor == other.minor){
        if(patch < other.patch){
          return true;
        }
        else if(patch == other.patch){
          if(build != null && other.build != null && build! < other.build!){
            return true;
          }
        }
      }
    }
    return false;
  }

  bool operator >=(Version other){
    if(this > other || this == other) {
      return true;
    }
    return false;
  }

  bool operator <=(Version other){
    if(this < other || this == other) {
      return true;
    }
    return false;
  }

  @override
  bool operator ==(Object other){

    if(other is Version){
      if(major == other.major && minor == other.minor &&
        patch == other.patch && build == other.build){
        return true;
      }
    }
    else{
      throw Exception("Can only compare Version to Version");
    }
    
    return false;
  }

  @override
  int compareTo(Version other){
    if(this > other) {
      return 1;
    } else if(this < other)
      return -1;
    else
      return 0;
  }

  factory Version.fromJson(dynamic json) {

    // migrate old data format to new one
    if(json is String){
      if(json == "") {
        return Version(0, 0, 0);
      } else if(json.contains("+"))
        return Version.fromStringFull(json);
      else
        return Version.fromString(json);
    }
    else {
      return _$VersionFromJson(json);
    }
  }

  Map<String, dynamic> toJson() => _$VersionToJson(this);

}

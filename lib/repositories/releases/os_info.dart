import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';



Future<String> getVersion() async {

  String version;

  final info = DeviceInfoPlugin();

  if(Platform.isAndroid){
    final androidInfo = (await info.androidInfo);
    version = androidInfo.version.release;
  }
  else if(Platform.isIOS){
    final iosInfo = (await info.iosInfo);
    version = iosInfo.systemVersion;
  }
  else if(Platform.isMacOS){
    final macosInfo = (await info.macOsInfo);
    version = macosInfo.osRelease;
  }
  else if(Platform.isLinux){
    final linuxInfo = (await info.linuxInfo);
    version = "${linuxInfo.name} ${linuxInfo.version}";
  }
  else if(Platform.isWindows){
    final windowsInfo = (await info.windowsInfo);
    version = windowsInfo.productName;
  }
  else{
    version = "unknown";
  }


  return version;

}
import 'dart:ffi';
import 'dart:io';



/// TensorFlowLite C library.
// ignore: missing_return
DynamicLibrary tflitelib = () {
  if (Platform.isAndroid) {
    return DynamicLibrary.open('libtensorflowlite_c.so');
  }
  else if (Platform.isIOS) {
    return DynamicLibrary.process();
  }
  else if (Platform.isMacOS) {

    return DynamicLibrary.open(
      Directory(Platform.resolvedExecutable).parent.parent.path + '/resources/libtensorflowlite_c-mac.dylib'
    );
  }
  else if (Platform.isLinux) {
    return DynamicLibrary.open(
      Directory(Platform.resolvedExecutable).parent.path + '/blobs/libtensorflowlite_c-linux.so'
    );
  }
  else if (Platform.isWindows) {
    return DynamicLibrary.open(
      Directory(Platform.resolvedExecutable).parent.path + '/blobs/libtensorflowlite_c-win.dll'
    );
  }
  else {
    throw UnsupportedError('Unsupported platform!');
  }
}();

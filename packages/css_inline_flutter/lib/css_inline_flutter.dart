library;

import 'package:css_inline_flutter/src/rust/frb_generated.dart';

export 'src/rust/api/simple.dart';
export 'src/rust/frb_generated.dart' show RustLib;



/// Must be called to initialize the Rust library before using any other
/// functions.
Future initInlineCss() async => await RustLib.init();
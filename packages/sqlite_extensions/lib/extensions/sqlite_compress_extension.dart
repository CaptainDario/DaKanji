// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:sqlite3/sqlite3.dart';

@Native<Int Function(Pointer<Void>, Pointer<Void>, Pointer<Void>)>()
external int sqlite3_compress_init(
  Pointer<Void> db,
  Pointer<Void> pzErrMsg,
  Pointer<Void> pApi,
);

extension LoadCompressExtension on Sqlite3 {
  void loadSqliteCompressExtension() {
    ensureExtensionLoaded(
      SqliteExtension(
        Native.addressOf<
          NativeFunction<
            Int Function(Pointer<Void>, Pointer<Void>, Pointer<Void>)
          >
        >(sqlite3_compress_init).cast(),
      ),
    );
  }
}
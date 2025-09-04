// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:sqlite3/sqlite3.dart';

@Native<Int Function(Pointer<Void>, Pointer<Void>, Pointer<Void>)>()
external int sqlite3_crsqlite_init(
  Pointer<Void> db,
  Pointer<Void> pzErrMsg,
  Pointer<Void> pApi,
);

extension LoadCrsqliteExtension on Sqlite3 {
  void loadSqliteCrsqliteExtension() {
    ensureExtensionLoaded(
      SqliteExtension(
        Native.addressOf<
          NativeFunction<
            Int Function(Pointer<Void>, Pointer<Void>, Pointer<Void>)
          >
        >(sqlite3_crsqlite_init).cast(),
      ),
    );
  }
}
import 'package:test/test.dart';
import 'package:sqlite3/native_assets.dart';
import 'package:dakanji_db_core/extensions/sqlite_vector_extension.dart';
import 'package:dakanji_db_core/extensions/sqlite_spellfix_extension.dart';
import 'package:dakanji_db_core/extensions/sqlite_crsqlite_extension.dart';
import 'package:dakanji_db_core/extensions/sqlite_compress_extension.dart';

void main() async {

  //sqlite3Native.loadSqliteVecExtension();
  sqlite3Native.loadSqliteSpellfixExtension();
  sqlite3Native.loadSqliteCrsqliteExtension();

  final db = sqlite3Native.openInMemory();

  test('Testing FTS5 loaded', () async {
    db.execute('CREATE VIRTUAL TABLE email USING fts5(sender, title, body);');
  });

  test('Testing DBSTAT loaded', () async {
    db.execute('SELECT * FROM dbstat;');
  });

  test('Testing SPELLFIX loaded', () async {
    db.execute('CREATE VIRTUAL TABLE demo USING spellfix1;');
  });

  test('Testing SQLite-vec loaded', () async {
    db.execute('create virtual table vec_examples using vec0(sample_embedding float[8]);');
  });

  //test('Testing SQLite-vec loaded', () async {
  //  db.execute('create virtual table vec_examples using vec0(sample_embedding float[8]);');
  //});

  test('Testing CR-SQLite loaded', () async {
    db.execute('''
      create table foo (a primary key not null, b);
      select crsql_as_crr('foo');
    ''');
  });

}

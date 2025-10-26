import 'package:dakanji_sqlite_extensions/dakanji_sqlite_extensions.dart';
import 'package:sqlite3/native_assets.dart';
import 'package:test/test.dart';

void main() async {

  sqlite3Native.loadSqliteVectorExtension();
  sqlite3Native.loadSqliteSpellfixExtension();
  sqlite3Native.loadSqliteCrsqliteExtension();
  sqlite3Native.loadSqliteCompressExtension();

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

  test('Testing COMPRESS loaded', () async {
    db.execute('CREATE TABLE t1 (data TEXT);');
    db.execute("INSERT INTO t1 (data) VALUES (compress('This is a test'));");
    final result = db.select('SELECT uncompress(data) as data FROM t1;');
    List<int> uncompressed = result.first['data'];
    String decoded = String.fromCharCodes(uncompressed);
    expect(decoded, 'This is a test');
  });

  test('Testing SQLite-vector loaded', () async {
    db.execute('SELECT vector_version()');
  });

  test('Testing CR-SQLite loaded', () async {
    db.execute('''
      create table foo (a primary key not null, b);
      select crsql_as_crr('foo');
    ''');
  });

}

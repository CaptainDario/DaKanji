import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite_extensions/sqlite_extensions.dart';
import 'package:test/test.dart';

void main() async {

  sqlite3.loadSqliteVectorExtension();
  sqlite3.loadSqliteCrsqliteExtension();
  sqlite3.loadSqliteBetterTrigramExtension();

  final db = sqlite3.openInMemory();

  test('Testing FTS5 loaded', () async {
    db.execute('CREATE VIRTUAL TABLE email USING fts5(sender, title, body);');
  });

  test('Testing DBSTAT loaded', () async {
    db.execute('SELECT * FROM dbstat;');
  });

  test('Testing SQLite-vector loaded', () async {
    db.execute('SELECT vector_version()');
  });

  test('Testing Better Trigram loaded', () async {
    db.execute("CREATE VIRTUAL TABLE t1 USING fts5(y, tokenize='better_trigram')");
  });

  test('Testing CR-SQLite loaded', () async {
    db.execute('''
      create table foo (a primary key not null, b);
      select crsql_as_crr('foo');
    ''');
  });

}

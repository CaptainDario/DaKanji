dart pub run build_runner clean
dart pub run build_runner build --delete-conflicting-outputs
dart run bin/build_da_db.dart
.venv/bin/eralchemy -i sqlite:///./tmp/dakanji.db -o da_db_schema/schema.pdf
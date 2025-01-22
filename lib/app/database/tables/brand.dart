import 'package:drift/drift.dart';

class Brands extends Table {
  IntColumn get id => integer()();

  TextColumn get name => text()();

  TextColumn get image => text()();

  @override
  Set<Column> get primaryKey => {id};
}

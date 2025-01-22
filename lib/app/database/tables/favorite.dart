import 'package:drift/drift.dart';

class Favorites extends Table {
  IntColumn get productId => integer()();

  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();

  @override
  Set<Column> get primaryKey => {productId};
}

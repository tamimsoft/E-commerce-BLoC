import 'package:drift/drift.dart';
import 'package:ecommerce2/app/database/tables/product.dart';

@TableIndex(name: 'product_id', columns: {#productId})
class Carts extends Table {
  IntColumn get id => integer()();

  IntColumn get productId => integer().references(Products, #id)();

  IntColumn get quantity => integer().withDefault(const Constant(1))();

  TextColumn get sizeName => text().withDefault(const Constant(''))();

  TextColumn get colorName => text().withDefault(const Constant(''))();

  TextColumn get price => text().withDefault(const Constant(''))();

  DateTimeColumn get createdAt => dateTime().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column> get primaryKey => {id};
}

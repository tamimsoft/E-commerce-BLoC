import 'package:drift/drift.dart';

import 'tables.dart';

@TableIndex(name: 'remark', columns: {#remark})
@TableIndex(name: 'category_id', columns: {#categoryId})
@TableIndex(name: 'brand_id', columns: {#brandId})
class Products extends Table {
  IntColumn get id => integer()();

  TextColumn get title => text().customConstraint('NOT NULL')();

  RealColumn get price => real().customConstraint('NOT NULL')();

  RealColumn get discount => real().withDefault(const Constant(0.0))();

  RealColumn get discountPrice => real().withDefault(const Constant(0.0))();

  TextColumn get shortDescription => text()();

  TextColumn get image => text()();

  RealColumn get star => real().withDefault(const Constant(0.0))();

  IntColumn get stock => integer().withDefault(const Constant(0))();

  IntColumn get categoryId => integer().references(Categories, #id)();

  IntColumn get brandId => integer().references(Brands, #id)();

  TextColumn get remark => text()();

  @override
  Set<Column> get primaryKey => {id};
}

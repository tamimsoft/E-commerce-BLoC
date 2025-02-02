import 'package:drift/drift.dart';
import 'package:fakestore/app/utils/helper/string_list_convert.dart';

import 'tables.dart';

class ProductDetails extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get productId => integer().references(Products, #id)();

  TextColumn get imageList => text().map(const StringListConvert())();

  TextColumn get fullDescription => text()();

  TextColumn get colorList => text().map(const StringListConvert())();

  TextColumn get sizeList => text().map(const StringListConvert())();
}

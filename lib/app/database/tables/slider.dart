import 'package:drift/drift.dart' as drift;
import 'package:drift/drift.dart';

import 'product.dart';

class Sliders extends drift.Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get productId => integer().references(Products, #id)();

  TextColumn get title => text()();

  TextColumn get price => text()();

  TextColumn get shortDescription => text()();

  TextColumn get image => text()();

}

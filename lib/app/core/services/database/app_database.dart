import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fakestore/app/utils/helper/string_list_convert.dart';
import 'package:path_provider/path_provider.dart';

import 'tables/tables.dart';


part 'app_database.g.dart';

@DriftDatabase(tables: [Products, ProductDetails, Categories, Brands, Sliders, Carts, Favorites])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

// Database connection

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    try {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File('${dbFolder.path}/app_db.sqlite');
      return NativeDatabase(file);
    } catch (e) {
      // print("Error initializing database: $e");
      throw Exception('Database initialization failed');
    }
  });
}

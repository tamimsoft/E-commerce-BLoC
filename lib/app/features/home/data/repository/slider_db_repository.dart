import 'package:fakestore/app/features/home/data/models/slider_model.dart';
import 'package:flutter/material.dart';
import 'package:fakestore/app/core/services/database/app_database.dart';

class SliderDBRepository {
  final AppDatabase _db;

  SliderDBRepository(this._db);

  Future<List<SliderModel>> fetchDbSliders() async {
    final query = _db.select(_db.sliders);
    final dbSliders = await query.get();
    if (dbSliders.isNotEmpty) {
      return dbSliders.map((row) => SliderModel.fromDrift(row)).toList();
    }
    return [];
  }

  Future<void> save(SliderModel slider) async {
    try {
      final sliderCompanion = slider.toDriftCompanion();
      var i =
          await _db.into(_db.sliders).insertOnConflictUpdate(sliderCompanion);
      debugPrint('Save Slider:::$i');
    } catch (e) {
      debugPrint('Error Save Slider:::\n$e');
    }
  }

  Future<void> delete(int id) async {
    await (_db.delete(_db.sliders)..where((tbl) => tbl.id.equals(id))).go();
  }
}

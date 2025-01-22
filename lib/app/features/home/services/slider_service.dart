import 'package:ecommerce2/app/features/home/data/models/slider_model.dart';
import 'package:ecommerce2/app/features/home/data/repository/slider_api_repository.dart';
import 'package:ecommerce2/app/features/home/data/repository/slider_db_repository.dart';

class SliderService {
  final SliderApiRepository _apiRepo;
  final SliderDBRepository _dbRepo;

  SliderService(this._apiRepo, this._dbRepo);

  Future<List<SliderModel>> getSliders() async {
    try {
      final dbSliders = await _dbRepo.fetchDbSliders();
      if (dbSliders.isNotEmpty) return dbSliders;
      final apiSliders = await _apiRepo.fetchSlideProductList();
      if (apiSliders.isNotEmpty) {
        for (var slider in apiSliders) {
          await _dbRepo.save(slider);
        }
      }
      return apiSliders;
    } catch (e) {
      rethrow;
    }
  }
}

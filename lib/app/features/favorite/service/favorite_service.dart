import 'package:ecommerce2/app/dependency_injection.dart';
import 'package:ecommerce2/app/features/auth/service/auth_service.dart';
import 'package:ecommerce2/app/features/favorite/data/model/favorite_model.dart';
import 'package:ecommerce2/app/features/favorite/data/repository/favorite_api_repository.dart';
import 'package:ecommerce2/app/features/favorite/data/repository/favorite_db_repository.dart';

class FavoriteService {
  final AuthService _authService = getIt<AuthService>();
  final FavoriteDbRepository _dbRepository;

  final FavoriteApiRepository _apiRepository;

  FavoriteService(this._dbRepository, this._apiRepository);

  Future<List<FavoriteModel>> getFavoriteProducts() async {
    try {
      List<FavoriteModel> productList = [];
      productList = await _dbRepository.fetchDbFavoriteList();
      if (productList.isEmpty) {
        if (await _authService.isAuthenticated()) {
          productList = await _apiRepository.fetchFavoriteList();
        }
        if (productList.isEmpty) return [];
        for (var favoriteItem in productList) {
          await _dbRepository.save(favoriteItem);
        }
      }
      return productList;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addToFavorite({required int productId}) async {
    try {
      await _dbRepository.save(FavoriteModel(productId: productId));
      if (await _authService.isAuthenticated()) {
        await _apiRepository.addToFavorite(productId);
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> removeFromFavorite({required int productId}) async {
    try {
      await _dbRepository.remove(productId);
      if (await _authService.isAuthenticated()) {
        await _apiRepository.remove(productId);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}

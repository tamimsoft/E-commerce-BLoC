import 'package:ecommerce2/app/features/favorite/data/model/favorite_model.dart';
import 'package:ecommerce2/app/utils/constants/api_constants.dart';
import 'package:ecommerce2/app/utils/network/api_client.dart';

class FavoriteApiRepository {
  final ApiClient _apiClient;

  FavoriteApiRepository(this._apiClient);

  Future<List<FavoriteModel>> fetchFavoriteList() async {
    return await _apiClient.getRequest<List<FavoriteModel>>(
      endpoint: ApiConstants.favoriteList,
      fromJson: (json) => (json as List).map((i) => FavoriteModel.fromJson(i)).toList(),
    );
  }

  Future<FavoriteModel> addToFavorite(int productId) async {
    return await _apiClient.getRequest<FavoriteModel>(
      endpoint: ApiConstants.addToFavoriteList(productId),
      fromJson: (json) => FavoriteModel.fromJson(json),
    );
  }

  Future<bool> remove(int productId) async {
    try {
      await _apiClient.getRequest(
        endpoint: ApiConstants.removeFromFavoriteList(productId),
        fromJson: (_) {},
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

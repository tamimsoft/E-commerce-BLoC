import 'package:fakestore/app/features/category/data/model/category_model.dart';
import 'package:fakestore/app/core/constants/api_constants.dart';
import 'package:fakestore/app/core/services/network/api_client.dart';

class CategoryApiRepository {
  final ApiClient _apiClient;

  CategoryApiRepository(this._apiClient);

  Future<List<CategoryModel>> fetchCategoryList() async {
    return await _apiClient.getRequest<List<CategoryModel>>(
      endpoint: ApiConstants.categoryList,
      fromJson: (json) => (json as List).map((i) => CategoryModel.fromJson(i)).toList(),
    );
  }
}

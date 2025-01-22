import 'package:ecommerce2/app/features/category/data/model/category_model.dart';
import 'package:ecommerce2/app/utils/constants/api_constants.dart';
import 'package:ecommerce2/app/utils/network/api_client.dart';

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

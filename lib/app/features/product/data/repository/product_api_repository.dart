import '../model/product_model.dart';
import '/app/features/product/data/model/product_details_model.dart';

import '../../../../utils/constants/api_constants.dart';
import '../../../../utils/network/api_client.dart';

class ProductApiRepository {
  final ApiClient _apiClient;

  ProductApiRepository(this._apiClient);

  Future<List<ProductModel>> fetchProductListByCategory({required int categoryId}) async {
    try {
      return await _apiClient.getRequest<List<ProductModel>>(
        endpoint: ApiConstants.productListByCategory(categoryId),
        fromJson: (json) => (json as List).map((i) => ProductModel.fromJson(i)).toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchProductListByBrand({required int brandId}) async {
    try {
      return await _apiClient.getRequest<List<ProductModel>>(
        endpoint: ApiConstants.productListByBrand(brandId),
        fromJson: (json) => (json as List).map((i) => ProductModel.fromJson(i)).toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchProductListByRemark({required String remark}) async {
    try {
      return await _apiClient.getRequest<List<ProductModel>>(
        endpoint: ApiConstants.productListByRemark(remark),
        fromJson: (json) => (json as List).map((i) => ProductModel.fromJson(i)).toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductDetailsModel> fetchProductDetailsById({required int productId}) async {
    try {
      final productDetails = await _apiClient.getRequest<List<ProductDetailsModel>>(
        endpoint: ApiConstants.productDetailsById(productId),
        fromJson: (json) => (json as List).map((i) => ProductDetailsModel.fromJson(i)).toList(),
      );
      return productDetails.first;
    } catch (e) {
      rethrow;
    }
  }

}

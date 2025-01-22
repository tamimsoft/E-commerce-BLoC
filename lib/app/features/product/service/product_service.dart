import 'package:ecommerce2/app/features/product/data/model/product_details_model.dart';
import 'package:ecommerce2/app/features/product/data/model/product_model.dart';
import 'package:ecommerce2/app/features/product/data/repository/product_api_repository.dart';
import 'package:ecommerce2/app/features/product/data/repository/product_db_repository.dart';
import 'package:ecommerce2/app/utils/constants/enums.dart';

class ProductService {
  final ProductDbRepository _dbRepo;

  final ProductApiRepository _apiRepo;

  ProductService(this._dbRepo, this._apiRepo);

  Future<List<ProductModel>> getAllProducts() async {
    try {
      return await _dbRepo.fetchDbAllProducts();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> getProductsByRemark({required ProductRemark remark}) async {
    try {
      List<ProductModel> productList = [];
      productList = await _dbRepo.fetchDbProductsByRemark(remark: remark.name);
      if (productList.isEmpty) {
        productList = await _apiRepo.fetchProductListByRemark(remark: remark.name);
        if (productList.isEmpty) return [];
        for (var product in productList) {
          await _dbRepo.saveProduct(product: product);
        }
      }
      return productList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> getProductsByCategory({required int categoryId}) async {
    try {
      List<ProductModel> productList = [];
      productList = await _dbRepo.fetchDbProductsByCategory(categoryId: categoryId);
      if (productList.isEmpty) {
        productList = await _apiRepo.fetchProductListByCategory(categoryId: categoryId);

        if (productList.isEmpty) return [];
        for (var product in productList) {
          await _dbRepo.saveProduct(product: product);
        }
      }
      return productList;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductDetailsModel> getProductDetails({required int productId}) async {
    try {
      final dbProductDetails = await _dbRepo.fetchProductDetailsById(productId: 1);
      if (dbProductDetails != null) return dbProductDetails;
      final ProductDetailsModel apiProduct = await _apiRepo.fetchProductDetailsById(productId: 1);
      await _dbRepo.saveProductDetails(apiProduct);
      return apiProduct;
    } catch (e) {
      rethrow;
    }
  }

}

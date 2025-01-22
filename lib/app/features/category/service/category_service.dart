import 'package:ecommerce2/app/dependency_injection.dart';
import 'package:ecommerce2/app/features/category/data/model/category_model.dart';
import 'package:ecommerce2/app/features/category/data/repository/category_api_repository.dart';
import 'package:ecommerce2/app/features/category/data/repository/category_db_repository.dart';
import 'package:ecommerce2/app/features/product/data/model/product_model.dart';
import 'package:ecommerce2/app/features/product/service/product_service.dart';

class CategoryService {
  final CategoryDbRepository _dbRepo;
  final CategoryApiRepository _comApiRepo;
  final ProductService _productService = getIt();

  CategoryService(this._dbRepo, this._comApiRepo);

  Future<List<CategoryModel>> getCategories() async {
    try {
      final dbCategories = await _dbRepo.fetchDbCategories();
      if (dbCategories.isNotEmpty) return dbCategories;
      final apiCategories = await _comApiRepo.fetchCategoryList();
      if (apiCategories.isNotEmpty) {
        for (var category in apiCategories) {
          await _dbRepo.save(category);
        }
      }
      return apiCategories;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> getCategoryProducts(int categoryId) async {
    return await _productService.getProductsByCategory(categoryId: categoryId);
  }
}

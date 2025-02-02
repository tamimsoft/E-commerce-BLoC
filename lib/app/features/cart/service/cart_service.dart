import 'package:fakestore/app/config/dependency_injection.dart';
import 'package:fakestore/app/features/auth/service/auth_service.dart';
import 'package:fakestore/app/features/cart/data/model/cart_model.dart';
import 'package:fakestore/app/features/cart/data/repository/cart_api_repository.dart';
import 'package:fakestore/app/features/cart/data/repository/cart_db_repository.dart';

class CartService {
  final CartDbRepository _dbRepo;
  final CartApiRepository _apiRepo;
  final AuthService _authService = getIt<AuthService>();

  CartService(this._dbRepo, this._apiRepo);

  Future<List<CartModel>> getCartProducts() async {
    try {
      List<CartModel> cartList = [];
      cartList = await _dbRepo.fetchDbCartList();
      if (cartList.isEmpty) {
        if (await _authService.isAuthenticated()) {
          cartList = await _apiRepo.fetchCartList();
        }
        if (cartList.isEmpty) return [];
        for (var cart in cartList) {
          await _dbRepo.save(cart: cart);
        }
      }
      return cartList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addToCart(CartModel cart) async {
    try {
      await _dbRepo.save(cart: cart);
      if (await _authService.isAuthenticated()) {
        await _apiRepo.insertNewCart(cart);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCart(int productId) async {
    try {
      await _dbRepo.remove(productId: productId);
      if (await _authService.isAuthenticated()) {
        await _apiRepo.removeCart(productId);
      }
    } catch (e) {
      rethrow;
    }
  }
}

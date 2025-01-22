import 'package:ecommerce2/app/features/cart/data/model/cart_model.dart';
import 'package:ecommerce2/app/utils/constants/api_constants.dart';
import 'package:ecommerce2/app/utils/network/api_client.dart';

class CartApiRepository {
  ApiClient apiClient;

  CartApiRepository(this.apiClient);

  Future<List<CartModel>> fetchCartList() async {
    return await apiClient.getRequest<List<CartModel>>(
      endpoint: ApiConstants.cartList,
      fromJson: (json) => (json as List).map((i) => CartModel.fromJson(i)).toList(),
    );
  }

  Future<CartModel> insertNewCart(CartModel cart) async {
    return await apiClient.postRequest<CartModel>(
      endpoint: ApiConstants.addToCartList,
      body: cart.toJson(),
      fromJson: (json) => CartModel.fromJson(json),
    );
  }

  Future<bool> removeCart(int productId) async {
    try {
      await apiClient.getRequest(
        endpoint: ApiConstants.removeFromCartList(productId),
        fromJson: (_) {},
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

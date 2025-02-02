import 'package:fakestore/app/features/cart/data/model/cart_model.dart';
import 'package:fakestore/app/features/cart/ui/bloc/cart_bloc.dart';
import 'package:fakestore/app/common/widgets/custom_network_image.dart';
import 'package:fakestore/app/common/widgets/quantity_update_button.dart';
import 'package:fakestore/app/config/routes/routes_name.dart';
import 'package:fakestore/app/core/constants/app_colors.dart';
import 'package:fakestore/app/utils/helper/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCartItem extends StatelessWidget {
  const ProductCartItem({
    super.key,
    required this.cart,
  });

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.productDetails, arguments: cart.product);
      },
      child: Card(
        color: Colors.white,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 8),
              child: SizedBox(width: 100, child: _buildProductImage()),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            cart.product?.title ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        buildInkDeleteButton(context),
                      ],
                    ),
                    Row(
                      spacing: 8,
                      children: [
                        Text('Color: ${cart.colorName}'),
                        Text('Size: ${cart.sizeName}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            return Text(
                              '\$${cart.product!.price * (state.quantities[cart.productId] ?? cart.quantity)}',
                              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                        QuantityUpdateButton(productId: cart.productId, cartQuantity: cart.quantity),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        color: AppColors.primary.withValues(alpha: 0.1),
      ),
      child: CustomNetworkImage(
        imageUrl: cart.product?.image ?? '',
        height: 86,
        width: double.infinity,
        fit: BoxFit.contain,
        imageBuilder: (context, imageProvider) => Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover, // Fit the image as needed
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInkDeleteButton(BuildContext context) {
    return InkWell(
      onTap: () {
        showConfirmationDialog(
          context: context,
          title: 'Remove Product',
          content: 'Are you sure you want to remove this product from the cart?',
          onConfirm: () {
            context.read<CartBloc>().add(CartEventRemoveProduct(productId: cart.productId));
          },
        );
      },
      child: const Icon(
        Icons.delete_forever_outlined,
        color: Colors.red,
      ),
    );
  }
}

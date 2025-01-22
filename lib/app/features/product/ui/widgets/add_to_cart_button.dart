import 'package:ecommerce2/app/features/cart/ui/bloc/cart_bloc.dart';
import 'package:ecommerce2/app/features/product/data/model/product_model.dart';
import 'package:ecommerce2/app/utils/constants/app_colors.dart';
import 'package:ecommerce2/app/utils/helper/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.product,
    required this.colorName,
    required this.sizeName,
  });

  final ProductModel product;
  final String colorName;
  final String sizeName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: AppColors.primary.withAlpha(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text('Price:', style: textTheme.titleMedium),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final quantity = state.quantities[product.id] ?? 1;
                return Text(
                  '\$${product.price * quantity}',
                  style: textTheme.titleMedium!.copyWith(color: AppColors.primary),
                );
              },
            ),
          ]),
          SizedBox(
            width: 128,
            child: BlocListener<CartBloc, CartState>(
              listenWhen: (previous, current) {
                return previous.status != current.status;
              },
              listener: (context, state) {
                if (state.status == Status.error) {
                  AppSnackBar.error(context: context, message: state.errorMsg);
                }
                if(state.status == Status.success){
                  AppSnackBar.success(context: context, message: state.errorMsg);
                }
              },
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<CartBloc>().add(
                            CartEventAddToCart(
                              productId: product.id,
                              quantity: state.quantities[product.id] ?? 1,
                              price: product.price * (state.quantities[product.id] ?? 1),
                              colorName: colorName,
                              sizeName: sizeName,
                            ),
                          );
                    },
                    child: Text('Add to cart'),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

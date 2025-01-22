import 'package:ecommerce2/app/features/cart/ui/bloc/cart_bloc.dart';
import 'package:ecommerce2/app/features/cart/ui/widgets/checkout_button.dart';
import 'package:ecommerce2/app/features/checkout/ui/bloc/checkout_bloc.dart';
import 'package:ecommerce2/app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartListScreenFooter extends StatelessWidget {
  const CartListScreenFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
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
            Text(
              'Total Price:',
              style: textTheme.titleMedium,
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return Text(
                  '\$${state.checkoutTotal}',
                  style: textTheme.titleMedium!.copyWith(color: AppColors.primary),
                );
              },
            ),
          ]),
          CheckoutButton(),
        ],
      ),
    );
  }
}

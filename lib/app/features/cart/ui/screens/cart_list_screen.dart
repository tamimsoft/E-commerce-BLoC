import 'package:ecommerce2/app/dependency_injection.dart';
import 'package:ecommerce2/app/features/cart/ui/bloc/cart_bloc.dart';
import 'package:ecommerce2/app/features/cart/ui/widgets/cart_list_screen_footer.dart';
import 'package:ecommerce2/app/features/cart/ui/widgets/product_cart_item.dart';
import 'package:ecommerce2/app/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartListScreen extends StatelessWidget {
  const CartListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(getIt())..add(CartEventLoadProduct()),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return PopScope(
      canPop: false,
      // onPopInvokedWithResult: (_, __) {
      // },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart List'),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (state.status == Status.error) {
              return Center(child: Text(state.errorMsg));
            }
            else if (state.status == Status.empty) {
              return Center(
                  child: Image.asset(
                ImagePath.emptyCartPng,
                width: 150,
              ));
            }
            else if (state.status == Status.loaded) {
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: state.cartList.length,
                        itemBuilder: (context, index) {
                          return ProductCartItem(cart: state.cartList[index]);
                        },
                      ),
                    ),
                  ),
                  state.cartList.isNotEmpty ? const CartListScreenFooter() : const SizedBox(),
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}

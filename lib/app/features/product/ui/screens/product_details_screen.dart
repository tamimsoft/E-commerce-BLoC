import 'package:ecommerce2/app/dependency_injection.dart';
import 'package:ecommerce2/app/features/cart/ui/bloc/cart_bloc.dart';
import 'package:ecommerce2/app/features/product/data/model/product_model.dart';
import 'package:ecommerce2/app/features/product/service/product_service.dart';
import 'package:ecommerce2/app/features/product/ui/blocs/product_details_bloc/product_details_bloc.dart';
import 'package:ecommerce2/app/features/product/ui/widgets/add_to_cart_button.dart';
import 'package:ecommerce2/app/features/product/ui/widgets/color_picker.dart';
import 'package:ecommerce2/app/features/product/ui/widgets/product_description.dart';
import 'package:ecommerce2/app/features/product/ui/widgets/product_image_slider.dart';
import 'package:ecommerce2/app/features/product/ui/widgets/product_summary.dart';
import 'package:ecommerce2/app/features/product/ui/widgets/size_picker.dart';
import 'package:ecommerce2/app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductDetailsBloc(getIt<ProductService>())..add(ProductDetailsEventLoad(productId: product.id)),
        ),
        BlocProvider(
          create: (context) => CartBloc(getIt()),
        ),
      ],
      child: _content(context, product),
    );
  }

  Widget _content(BuildContext context, ProductModel product) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: AppColors.greyLight,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  ProductImageSlider(),
                  ProductSummary(product: product),
                  ColorPicker(),
                  BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
                    builder: (context, state) {
                      return SizePicker(
                        onChange: (String sizeName) {
                          context.read<ProductDetailsBloc>().add(ProductDetailsEventSelectSize(selectedSize: sizeName));
                        },
                      );
                    },
                  ),
                  ProductDescription(),
                  const SizedBox(height: 32)
                ],
              ),
            ),
          ),
          BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
            builder: (context, state) {
              return AddToCartButton(product: product, colorName: state.colorName, sizeName: state.sizeName);
            },
          ),
        ],
      ),
    );
  }
}


import 'package:ecommerce2/app/features/common/widgets/shimmer_placeholder.dart';
import 'package:ecommerce2/app/features/product/ui/blocs/product_details_bloc/product_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: textTheme.titleMedium,
            textAlign: TextAlign.start,
          ),
          BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
            builder: (context, state) {
              if (state.status == Status.loaded) {
                return Text(
                  state.productDetails!.descriptions,
                  style: const TextStyle(color: Colors.grey),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                children: List.generate(
                  6,
                      (index) => ShimmerPlaceholder(
                    height: 12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

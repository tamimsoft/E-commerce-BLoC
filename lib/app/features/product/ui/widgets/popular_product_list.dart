import 'package:ecommerce2/app/dependency_injection.dart';
import 'package:ecommerce2/app/features/home/ui/widgets/section_header.dart';
import 'package:ecommerce2/app/features/product/ui/blocs/popular_product_bloc/popular_product_bloc.dart';
import 'package:ecommerce2/app/features/product/ui/widgets/product_item_shimmer.dart';
import 'package:ecommerce2/app/features/product/ui/widgets/product_item.dart';
import 'package:ecommerce2/app/routes/routes_name.dart';
import 'package:ecommerce2/app/utils/constants/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class PopularProductList extends StatelessWidget {
  const PopularProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          PopularProductBloc(getIt())..add(PopularProductEventLoadProduct()),
      child: Builder(builder: (context) => _buildContent(context)),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<PopularProductBloc, PopularProductState>(
          builder: (context, state) {
            return SectionHeader(
                title: ProductRemark.polularProduct.name,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.productList,
                    arguments: {
                      'title': ProductRemark.polularProduct.name,
                      'productList': state.productList
                    } as Map,
                  );
                });
          },
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<PopularProductBloc,PopularProductState>(
            builder: (context, state) {
              if (state.status == Status.loading) {
                return Row(
                  spacing: 8,
                  children: List.generate(
                      5, (index) => const ProductItemShimmer()),
                );
              } else if (state.status == Status.error) {
                return const Text('Failed to load product');
              } else if (state.status == Status.loaded) {
                return Row(
                  spacing: 8,
                  children: state.productList
                      .map((product) => ProductItem(product: product))
                      .toList(),
                );
              } else if (state.status == Status.empty) {
                return const Text('No sliders found');
              }
              return Text('Something went wrong');
            },
          ),
        ),
      ],
    );
  }
}

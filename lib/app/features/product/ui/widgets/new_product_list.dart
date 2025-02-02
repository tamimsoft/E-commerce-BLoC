import 'package:fakestore/app/config/dependency_injection.dart';
import 'package:fakestore/app/features/home/ui/widgets/section_header.dart';
import 'package:fakestore/app/features/product/ui/blocs/new_product_bloc/new_product_bloc.dart';
import 'package:fakestore/app/features/product/ui/widgets/product_item_shimmer.dart';
import 'package:fakestore/app/features/product/ui/widgets/product_item.dart';
import 'package:fakestore/app/config/routes/routes_name.dart';
import 'package:fakestore/app/core/constants/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class NewProductList extends StatelessWidget {
  const NewProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          NewProductBloc(getIt())..add(NewProductEventLoadProduct()),
      child: Builder(builder: (context) => _buildContent(context)),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<NewProductBloc, NewProductState>(
          builder: (context, state) {
            return SectionHeader(
                title: ProductRemark.newProduct.name,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.productList,
                    arguments: {
                      'title': ProductRemark.newProduct.name.toString(),
                      'productList': state.productList
                    } as Map,
                  );
                });
          },
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<NewProductBloc, NewProductState>(
            builder: (context, state) {
              if (state.status == Status.loading) {
                return Row(
                  spacing: 8,
                  children: List.generate(
                      5, (index) => const ProductItemShimmer()),
                );
              } else if (state.status == Status.error) {
                return const Text('Failed to load Product');
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

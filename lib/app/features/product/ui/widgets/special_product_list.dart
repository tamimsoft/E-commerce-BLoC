import 'package:fakestore/app/config/dependency_injection.dart';
import 'package:fakestore/app/features/home/ui/widgets/section_header.dart';
import 'package:fakestore/app/features/product/ui/blocs/special_product_bloc/special_product_bloc.dart';
import 'package:fakestore/app/features/product/ui/widgets/product_item_shimmer.dart';
import 'package:fakestore/app/features/product/ui/widgets/product_item.dart';
import 'package:fakestore/app/config/routes/routes_name.dart';
import 'package:fakestore/app/core/constants/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class SpecialProductList extends StatelessWidget {
  const SpecialProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          SpecialProductBloc(getIt())..add(SpecialProductEventLoadProduct()),
      child: Builder(builder: (context) => _buildContent(context)),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SpecialProductBloc, SpecialProductState>(
          builder: (context, state) {
            return SectionHeader(
                title: ProductRemark.specialProduct.name,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.productList,
                    arguments: {
                      'title': ProductRemark.specialProduct.name,
                      'productList': state.productList
                    } as Map,
                  );
                });
          },
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<SpecialProductBloc, SpecialProductState>(
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

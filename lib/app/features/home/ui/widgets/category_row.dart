import 'package:fakestore/app/config/dependency_injection.dart';
import 'package:fakestore/app/features/category/ui/bloc/category_bloc.dart';
import 'package:fakestore/app/features/category/ui/widgets/category_item_shimmer.dart';
import 'package:fakestore/app/features/category/ui/widgets/category_item.dart';
import 'package:fakestore/app/common/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CategoryBloc(getIt())..add(CategoryEventLoadCategory()),
      child: Builder(builder: (context) => _buildContent(context)),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
            title: 'Categories',
            onTap: () {
              context.read<MainBloc>().add(NavigateToAnotherScreenEvent(screen: Screen.category));
            }),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state.status == Status.loading) {
                return Row(
                  spacing: 16,
                  children: List.generate(5, (index) => CategoryItemShimmer()),
                );
              } else if (state.status == Status.error) {
                return Text(state.errorMsg.isNotEmpty ? state.errorMsg : 'An error occurred');
              } else if (state.status == Status.empty) {
                return Text('No categories found');
              } else if (state.status == Status.loaded) {
                return Row(
                  spacing: 16,
                  children: state.categoryList.map((category) => CategoryItem(category: category)).toList(),
                );
              }
              return Text('Something went wrong');
            },
          ),
        ),
      ],
    );
  }
}

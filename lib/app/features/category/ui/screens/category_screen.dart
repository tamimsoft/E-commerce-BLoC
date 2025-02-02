import 'package:fakestore/app/config/dependency_injection.dart';
import 'package:fakestore/app/features/category/ui/bloc/category_bloc.dart';
import 'package:fakestore/app/features/category/ui/widgets/category_item_shimmer.dart';
import 'package:fakestore/app/features/category/ui/widgets/category_item.dart';
import 'package:fakestore/app/core/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CategoryBloc(getIt())..add(CategoryEventLoadCategory()),
      child: Builder(builder: (context) => _buildContent(context)),
    );
  }

  Widget _buildContent(BuildContext context) {
    return PopScope(
      canPop: false,
      // onPopInvokedWithResult: (_, __) {
      // },
      child: Scaffold(
        appBar: AppBar(title: const Text('Category List')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state.status == Status.loading) {
                return _buildCategoryShimmerGrid;
              }
              else if (state.status == Status.error) {
                return const Text('Failed to load categories');
              }
              else if (state.status == Status.loaded) {
                if (state.categoryList.isEmpty) {
                  return Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ImagePath.noProductPng,width: 150,),
                      Text('No categories found'),
                    ],
                  ));
                }
                return _buildCategoryGrid(state);
              }
              else if (state.status == Status.empty) {
                return Center(child: const Text('No categories found'));
              }
              return Center(child: Text('Something went wrong'));
            },
          ),
        ),
      ),
    );
  }

  Widget get _buildCategoryShimmerGrid {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        childAspectRatio: 0.9,
      ),
      itemCount: 28, // Number of shimmer placeholders
      itemBuilder: (context, index) => CategoryItemShimmer(),
    );
  }

  Widget _buildCategoryGrid(CategoryState state) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        childAspectRatio: 0.9,
      ),
      itemCount: state.categoryList.length,
      itemBuilder: (context, index) {
        return FittedBox(
          child: CategoryItem(category: state.categoryList[index]),
        );
      },
    );
  }
}

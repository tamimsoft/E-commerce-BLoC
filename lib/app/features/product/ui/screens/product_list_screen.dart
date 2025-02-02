import 'package:fakestore/app/config/dependency_injection.dart';
import 'package:fakestore/app/features/category/ui/bloc/category_bloc.dart';
import 'package:fakestore/app/features/product/data/model/product_model.dart';
import 'package:fakestore/app/features/product/ui/widgets/product_item.dart';
import 'package:fakestore/app/core/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({
    super.key,
    required this.title,
    this.categoryId,
    this.productList,
  });

  final String title;
  final int? categoryId;
  final List<ProductModel>? productList;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CategoryBloc(getIt())..add(CategoryEventLoadCategory()),
      child: Builder(builder: (context) => _buildContent(context)),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (categoryId != null && categoryId! > 0) {
      context.read<CategoryBloc>().add(CategoryEventLoadCategoryProductList(categoryId: categoryId!));
    }
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16),
        child: productList != null && productList!.isNotEmpty
            ? buildProductGrid(productList!)
            : BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == Status.error) {
                    return Center(child: Text(state.errorMsg.isNotEmpty ? state.errorMsg : 'An error occurred'));
                  } else if (state.status == Status.empty) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImagePath.noProductPng,
                          width: 150,
                        ),
                        Text('No products found'),
                      ],
                    ));
                  } else if (state.status == Status.loaded) {
                    return buildProductGrid(state.categoryWiseProductList);
                  }
                  return Center(child: Text('Something went wrong'));
                },
              ),
      ),
    );
  }

  Widget buildProductGrid(List<ProductModel> productList) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        childAspectRatio: 0.8,
        crossAxisSpacing: 8,
      ),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        // return const FittedBox(child: SizedBox());
        return FittedBox(
          child: ProductItem(
            product: productList[index],
          ),
        );
      },
    );
  }
}

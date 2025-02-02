import 'package:fakestore/app/features/home/ui/widgets/widgets.dart';
import 'package:fakestore/app/features/product/ui/widgets/new_product_list.dart';
import 'package:fakestore/app/features/product/ui/widgets/popular_product_list.dart';
import 'package:fakestore/app/features/product/ui/widgets/special_product_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          spacing: 16,
          children: [
            const SizedBox.shrink(),
            ProductSearchBar(),
            const HomeScreenSlider(),
            const CategoryRow(),
            const PopularProductList(),
            const NewProductList(),
            const SpecialProductList(),
            const SizedBox(height: 32)
          ],
        ),
      ),
    );
  }
}

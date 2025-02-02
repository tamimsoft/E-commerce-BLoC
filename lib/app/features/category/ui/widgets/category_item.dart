import 'package:fakestore/app/features/category/data/model/category_model.dart';
import 'package:fakestore/app/common/widgets/widgets.dart';
import 'package:fakestore/app/config/routes/routes_name.dart';
import 'package:fakestore/app/core/constants/app_colors.dart';

import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutesName.productList,
          arguments: {
            'title': category.name,
            'categoryId': category.id,
          } as Map,
        );
      },
      child: Column(
        spacing: 2,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomNetworkImage(
              imageUrl: category.image.toString(),
              width: 36,
              height: 36,
            ),
          ),
          Text(
            category.name.toString(),
            style: const TextStyle(
              color: AppColors.primary,
            ),
          )
        ],
      ),
    );
  }
}

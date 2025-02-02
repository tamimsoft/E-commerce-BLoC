import 'package:fakestore/app/common/widgets/quantity_update_button.dart';
import 'package:fakestore/app/features/product/data/model/product_model.dart';
import 'package:fakestore/app/features/product/ui/widgets/rating_review_and_favorite.dart';
import 'package:flutter/material.dart';

class ProductSummary extends StatelessWidget {
  const ProductSummary({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        spacing: 4,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(product.title, style: textTheme.bodyLarge),
              ),
              QuantityUpdateButton(productId: product.id),
            ],
          ),
          RatingReviewAndFavorite(product: product),
        ],
      ),
    );
  }
}

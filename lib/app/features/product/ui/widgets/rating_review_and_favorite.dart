import 'package:ecommerce2/app/features/product/data/model/product_model.dart';
import 'package:ecommerce2/app/features/product/ui/widgets/favorite_button.dart';
import 'package:ecommerce2/app/routes/routes_name.dart';

import 'package:flutter/material.dart';

class RatingReviewAndFavorite extends StatelessWidget {
  const RatingReviewAndFavorite({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 2,
      children: [
        Wrap(
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 18,
            ),
            Text(product.star.toStringAsFixed(0)),
          ],
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.productReview);
            },
            child: const Text('Reviews')),
        FavoriteButton(productId: product.id),
      ],
    );
  }
}

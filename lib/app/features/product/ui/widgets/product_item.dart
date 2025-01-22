import 'package:ecommerce2/app/features/common/widgets/custom_network_image.dart';
import 'package:ecommerce2/app/features/product/data/model/product_model.dart';
import 'package:ecommerce2/app/features/product/ui/widgets/favorite_button.dart';
import 'package:ecommerce2/app/routes/routes_name.dart';
import 'package:ecommerce2/app/utils/constants/app_colors.dart';

import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.productDetails, arguments: product);
      },
      child: SizedBox(
        width: 128,
        child: Card(
          color: Colors.white,
          child: Column(
            spacing: 2,
            children: [
              _buildProductImage(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: FittedBox(
                  child: Row(
                    spacing: 4,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          Text('${product.stock}'),
                        ],
                      ),
                      FavoriteButton(productId: product.id),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        color: AppColors.primary.withValues(alpha: 0.1),
      ),
      child: CustomNetworkImage(
        imageUrl: product.image,
        height: 86,
        width: double.infinity,
        fit: BoxFit.contain,
        imageBuilder: (context, imageProvider) => Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover, // Fit the image as needed
            ),
          ),
        ),
      ),
      // padding: const EdgeInsets.all(8),
      // child: Image.asset(ImagePath.shoePng,  height: 86,width:double.infinity,fit: BoxFit.contain,),
    );
  }
}
